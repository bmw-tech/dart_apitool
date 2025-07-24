import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_apitool/api_tool.dart';
import 'package:dart_apitool/src/cli/source_item.dart';
import 'package:path/path.dart' as p;

import '../git_ref.dart';
import '../package_ref.dart';
import '../prepared_package_ref.dart';

/// mixin for all dart-apitool commands that provides common information and functionality
mixin CommandMixin {
  final packageRefExplanation = '''
Package reference can be one of:
- directory path pointing to a package on disk
  (e.g. /path/to/package)
- any package from pub
  (e.g. pub://package_name/version)
- git repository with optional branch/tag/commit
  (e.g. git://https://github.com/user/repo or git://https://github.com/user/repo:branch)
  (e.g. git://git@github.com:user/repo or git://git@github.com:user/repo:tag)
''';

  final includePathDependenciesExplanation = '''
OBSOLETE: Has no effect anymore.
 ''';

  static final String _flagNameForceUseFlutter = 'force-use-flutter';
  static final String _helpTextForceUseFlutter =
      'If present forces dart_apitool to use Flutter\n(instead of Dart if the project is Dart only)';

  void init(ArgParser argParser) {
    argParser.addFlag(
      _flagNameForceUseFlutter,
      help: _helpTextForceUseFlutter,
      defaultsTo: false,
      negatable: false,
    );
  }

  /// prepares given [ref]. Depending on the type of ref this can include
  /// - copying the package to a temporary directory
  /// - running pub get
  /// If you use [analyze] with this result then it will take care to clean up
  /// everything (e.g. removing temp directory)
  Future<PreparedPackageRef> prepare(
    ArgResults argResults,
    PackageRef ref,
  ) async {
    final stdoutSession = StdoutSession();

    final forceUseFlutterTool =
        (argResults[_flagNameForceUseFlutter] as bool?) ?? false;

    List<SourceItem> sources = [];
    String? packageRelativePath;
    if (ref.isDirectoryPath) {
      String forceUseFlutterSuffix = '';
      if (forceUseFlutterTool) {
        forceUseFlutterSuffix = ' (forced Flutter)';
      }
      await stdoutSession.writeln('Preparing ${ref.ref}$forceUseFlutterSuffix');
      String sourceDir = ref.ref;
      if (sourceDir.endsWith(p.separator)) {
        sourceDir =
            sourceDir.substring(0, sourceDir.length - p.separator.length);
      }

      sources.add(SourceItem(
        sourceDir: sourceDir,
        isInCache: false,
      ));
    } else if (ref.isPubRef) {
      await stdoutSession.writeln(
          'Preparing ${ref.pubPackage!}:${ref.pubVersion ?? 'latest'}');
      await stdoutSession.writeln('Downloading');
      String sourceDir = await PubInteraction.installPackageToCache(
        ref.pubPackage!,
        ref.pubVersion,
        stdoutSession: stdoutSession,
      );
      sources.add(SourceItem(
        sourceDir: sourceDir,
        isInCache: true,
      ));
    } else if (ref.isGitRef) {
      final gitRefObj = ref.gitRef!;
      await stdoutSession.writeln('Preparing git repository: ${gitRefObj.uri}');
      if (gitRefObj.ref != null) {
        await stdoutSession.writeln('Using ref: ${gitRefObj.ref}');
      }
      // For git repositories, we'll clone directly to the temp directory later
      // Store the git info in a special SourceItem
      sources.add(SourceItem(
        sourceDir: gitRefObj.toInternalString(),
        isInCache: false, // Treat git repos like local dirs - they need pub get
      ));
    } else {
      throw ArgumentError('Unknown package ref: ${ref.ref}');
    }
    // merge sources to not copy children of a parent separately
    // => remove all sources that have a parent in the list
    sources.removeWhere((sToRemove) =>
        sources.any((s) => p.isWithin(s.sourceDir, sToRemove.sourceDir)));
    final tempDir = await Directory.systemTemp.createTemp();
    String? gitPackageRelativePath; // Store the relative path for git packages
    await Future.forEach<SourceItem>(sources, (sourceItem) async {
      if (sourceItem.sourceDir.startsWith('GIT:')) {
        // Handle git repository
        final gitRef = GitRef.fromInternalString(sourceItem.sourceDir);

        final targetDir = sourceItem.destinationPath(forPrefix: tempDir.path);
        final packageDir = await GitInteraction.cloneRepositoryToDirectory(
          gitRef.uri,
          targetDir,
          gitRef.ref,
          gitRef.path,
          stdoutSession: stdoutSession,
        );

        // Calculate the relative path from tempDir to packageDir
        gitPackageRelativePath = p.relative(packageDir, from: tempDir.path);

        String forceUseFlutterSuffix = '';
        if (forceUseFlutterTool) {
          forceUseFlutterSuffix = ' (forced Flutter)';
        }

        await stdoutSession.writeln(
            'Preparing package dependencies for git package ${gitRef.uri}$forceUseFlutterSuffix');
        await PubInteraction.runPubGet(
          packageDir,
          stdoutSession: stdoutSession,
          forceUseFlutterTool: forceUseFlutterTool,
        );
        await DartInteraction.transferPackageConfig(
          fromPackage: packageDir,
          toPackage: tempDir.path,
          stdoutSession: stdoutSession,
        );
      } else {
        // Handle regular directories and pub packages
        await stdoutSession
            .writeln('Copying sources from ${sourceItem.sourceDir}');
        await _copyPath(sourceItem.sourceDir,
            sourceItem.destinationPath(forPrefix: tempDir.path));
        if (!sourceItem.isInCache) {
          String forceUseFlutterSuffix = '';
          if (forceUseFlutterTool) {
            forceUseFlutterSuffix = ' (forced Flutter)';
          }

          await stdoutSession.writeln(
              'Preparing package dependencies for local package ${sourceItem.sourceDir}$forceUseFlutterSuffix');
          await PubInteraction.runPubGet(
            sourceItem.sourceDir,
            stdoutSession: stdoutSession,
            forceUseFlutterTool: forceUseFlutterTool,
          );
          await DartInteraction.transferPackageConfig(
            fromPackage: sourceItem.sourceDir,
            toPackage: tempDir.path,
            stdoutSession: stdoutSession,
          );
        } else {
          await stdoutSession.writeln('Cleaning up local copy of pub package');
          // Check if we have a pub package that bundles a pubspec_overrides.yaml (as this most probably destroys pub get)
          final pubspecOverrides = File(p.join(
              sourceItem.destinationPath(forPrefix: tempDir.path),
              'pubspec_overrides.yaml'));
          if (await pubspecOverrides.exists()) {
            await pubspecOverrides.delete();
            await stdoutSession.writeln('- Removed pubspec_overrides.yaml');
          }
        }
      }
    });
    return PreparedPackageRef(
        packageRef: ref,
        tempDirectory: tempDir.path,
        packageRelativePath: gitPackageRelativePath ?? packageRelativePath);
  }

  /// Analyzes the given prepared Package [ref].
  /// [doMergeBaseClasses] defines if base classes should be merged into derived ones. This allows to remove private base classes from the list of interface declarations.
  /// [doAnalyzePlatformConstraints] defines if the platform constraints of the package shall be analyzed.
  Future<PackageApi> analyze(
    ArgResults argResults,
    PreparedPackageRef preparedRef, {
    bool doAnalyzePlatformConstraints = true,
  }) async {
    final stdoutSession = StdoutSession();

    final forceUseFlutterTool =
        (argResults[_flagNameForceUseFlutter] as bool?) ?? false;

    String? path;
    if (preparedRef.packageRef.isDirectoryPath) {
      path = preparedRef.packageRef.ref;
    }
    if (preparedRef.packageRef.isPubRef) {
      path = PubInteraction.getPackagePathInCache(
          preparedRef.packageRef.pubPackage!,
          preparedRef.packageRef.pubVersion);
    }
    if (preparedRef.packageRef.isGitRef) {
      // For git references, use the temp directory where the repository was cloned
      path = preparedRef.tempDirectory;
    }
    if (path == null) {
      throw ArgumentError(
          'Don\'t know how to handle ${preparedRef.packageRef.ref}');
    }

    String packagePath = preparedRef.packageDirectory ?? path;
    // The analysis options might limit the scope of dart_apitool
    final analysisOptionsFile =
        File(p.join(packagePath, 'analysis_options.yaml'));
    if (await analysisOptionsFile.exists()) {
      await analysisOptionsFile.delete();
    }

    // Check if the package_config.json is already present from the preparation step
    final packageConfig = File(DartInteraction.getPackageConfigPathForPackage(
      packagePath,
      stdoutSession: stdoutSession,
      doCheckWorkspace: true,
    ));
    if (!packageConfig.existsSync()) {
      await stdoutSession.writeln('Running pub get');
      await PubInteraction.runPubGetIndirectly(
        packagePath,
        stdoutSession: stdoutSession,
        forceUseFlutterTool: forceUseFlutterTool,
      );
    } else {
      await stdoutSession
          .writeln('Omitting pub get (package config already present)');
    }

    await stdoutSession.writeln('Analyzing $path');
    final analyzer = PackageApiAnalyzer(
      packagePath: packagePath,
      doAnalyzePlatformConstraints: doAnalyzePlatformConstraints,
    );
    return await analyzer.analyze();
  }

  /// If the prepared package contains anything that has to be cleaned up
  /// (like created temp directories) then [cleanUp] takes care of that
  Future cleanUp(PreparedPackageRef preparedPackageRef) {
    stdout.writeln('Cleaning up');
    if (preparedPackageRef.tempDirectory != null) {
      return Directory(preparedPackageRef.tempDirectory!)
          .delete(recursive: true);
    }
    return Future.value();
  }

  bool _doNothing(String from, String to) {
    if (p.canonicalize(from) == p.canonicalize(to)) {
      return true;
    }
    if (p.isWithin(from, to)) {
      throw ArgumentError('Cannot copy from $from to $to');
    }
    return false;
  }

  Future<void> _copyPath(String from, String to) async {
    if (_doNothing(from, to)) {
      return;
    }
    if (await Directory(to).exists()) {
      await Directory(to).delete();
    }
    await Directory(to).create(recursive: true);
    await for (final file in Directory(from).list(recursive: true)) {
      final copyTo = p.join(to, p.relative(file.path, from: from));
      if (file is Directory) {
        await Directory(copyTo).create(recursive: true);
      } else if (file is File) {
        await File(file.path).copy(copyTo);
      } else if (file is Link) {
        await Link(copyTo).create(await file.target(), recursive: true);
      }
    }
  }
}
