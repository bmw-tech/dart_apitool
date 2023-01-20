import 'dart:io';
import 'dart:math';

import 'package:dart_apitool/api_tool.dart';
import 'package:dart_apitool/src/cli/source_item.dart';
import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';

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
''';

  final includePathDependenciesExplanation = '''
Scans package for path dependencies and makes sure to copy all path dependencies for evaluation.
Warning: This option might cause copy to lift the copying scope outside the current working directory,
depending on paths defined by path dependencies.
Affects only local references.
(defaults to off)
 ''';

  /// prepares given [ref]. Depending on the type of ref this can include
  /// - copying the package to a temporary directory
  /// - running pub get
  /// If you use [analyze] with this result then it will take care to clean up
  /// everything (e.g. removing temp directory)
  Future<PreparedPackageRef> prepare(PackageRef ref,
      {bool shouldCheckPathDependencies = false}) async {
    List<SourceItem> sources = [];
    String? packageRelativePath;
    if (ref.isDirectoryPath) {
      stdout.writeln('Preparing ${ref.ref}');
      String sourceDir = ref.ref;
      if (sourceDir.endsWith(p.separator)) {
        sourceDir =
            sourceDir.substring(0, sourceDir.length - p.separator.length);
      }
      if (shouldCheckPathDependencies) {
        String commonPath = sourceDir;
        final pathDependencies = await _listPathDependencies(sourceDir);
        if (pathDependencies.isNotEmpty) {
          stdout.writeln(
              'Found path dependencies: [\n${pathDependencies.reduce((v, e) => '$v\n$e')}\n]');
          commonPath = _commonRootPathForPackagesPaths(
              paths: pathDependencies.toList() + [sourceDir]);
          stdout.writeln('Common path: $commonPath');
          for (final path in pathDependencies) {
            sources.add(SourceItem.forCommonPath(
                sourceDir: path, commonPath: commonPath));
          }
        }

        final sourceItem = SourceItem.forCommonPath(
            sourceDir: sourceDir, commonPath: commonPath);
        packageRelativePath = sourceItem.relativeDestinationDir;
        sources.add(sourceItem);
      } else {
        sources.add(SourceItem(sourceDir: sourceDir));
      }
    } else if (ref.isPubRef) {
      stdout.writeln('Preparing ${ref.pubPackage!}:${ref.pubVersion!}');
      stdout.writeln('Downloading');
      String sourceDir = await PubInteraction.installPackageToCache(
          ref.pubPackage!, ref.pubVersion!);
      sources.add(SourceItem(sourceDir: sourceDir));
    } else {
      throw ArgumentError('Unknown package ref: ${ref.ref}');
    }
    final tempDir = await Directory.systemTemp.createTemp();
    await Future.forEach<SourceItem>(sources, (sourceItem) async {
      stdout.writeln('Copying sources from ${sourceItem.sourceDir}');
      await _copyPath(sourceItem.sourceDir,
          sourceItem.destinationPath(forPrefix: tempDir.path));
    });
    return PreparedPackageRef(
        packageRef: ref,
        tempDirectory: tempDir.path,
        packageRelativePath: packageRelativePath);
  }

  /// Analyzes the given prepared Package [ref].
  /// [doMergeBaseClasses] defines if base classes should be merged into derived ones. This allows to remove private base classes from the list of interface declarations.
  /// [doAnalyzePlatformConstraints] defines if the platform constraints of the package shall be analyzed.
  Future<PackageApi> analyze(
    PreparedPackageRef preparedRef, {
    bool doMergeBaseClasses = true,
    bool doAnalyzePlatformConstraints = true,
  }) async {
    String? path;
    if (preparedRef.packageRef.isDirectoryPath) {
      path = preparedRef.packageRef.ref;
    }
    if (preparedRef.packageRef.isPubRef) {
      path = PubInteraction.getPackagePathInCache(
          preparedRef.packageRef.pubPackage!,
          preparedRef.packageRef.pubVersion!);
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
    stdout.writeln('Running pub get');
    await PubInteraction.runPubGet(packagePath);

    stdout.writeln('Analyzing $path');
    final analyzer = PackageApiAnalyzer(
      packagePath: packagePath,
      doMergeBaseClasses: doMergeBaseClasses,
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

  Future<Set<String>> _listPathDependencies(String packagePath) async {
    File pubspecFile = File(p.join(packagePath, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) {
      throw 'Cannot find pubspec.yaml at ${pubspecFile.path}, while searching for path dependencies.';
    }

    Set<String> pathDependencies = {};

    final yamlContent = await pubspecFile.readAsString();
    final pubSpec = Pubspec.parse(yamlContent);
    await Future.forEach<Dependency>(pubSpec.dependencies.values,
        (dependency) async {
      if (dependency is PathDependency) {
        String pathDependencyPath =
            p.normalize(p.join(packagePath, dependency.path));
        pathDependencies.add(pathDependencyPath);
        pathDependencies = pathDependencies
            .union(await _listPathDependencies(pathDependencyPath));
      }
    });

    return pathDependencies;
  }

  String _commonRootPathForPackagesPaths({required List<String> paths}) {
    if (paths.isEmpty) {
      return '';
    }
    return paths.reduce((value, element) {
      final valueComponents = p.split(value);
      final elementComponents = p.split(element);
      List<String> commonComponents = [];

      for (int i = 0;
          i < min(valueComponents.length, elementComponents.length);
          i++) {
        if (valueComponents[i] == elementComponents[i]) {
          commonComponents.add(valueComponents[i]);
        } else {
          break;
        }
      }

      return p.joinAll(commonComponents);
    });
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
