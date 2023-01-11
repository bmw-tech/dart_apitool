import 'dart:io';

import 'package:dart_apitool/api_tool.dart';
import 'package:path/path.dart' as p;

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

  String copyDepthExplanation(String inputKind) {
    return '''
Integer that determines how many path levels up from $inputKind package reference should be copied along with the package itself.
This option allows to copy bigger part of the packages tree to make required path dependencies available for 'pub get' execution.
This number can not be greater then the count of components of the path given in the --$inputKind parameter.
This parameter is ignored for published packages and absolute paths. Defaults to 0.
 ''';
  }

  /// prepares given [ref]. Depending on the type of ref this can include
  /// - copying the package to a temporary directory
  /// - running pub get
  /// If you use [analyze] with this result then it will take care to clean up
  /// everything (e.g. removing temp directory)
  Future<PreparedPackageRef> prepare(PackageRef ref, {int? depth}) async {
    String sourceDir = '';
    String? packageRelativePath;
    if (ref.isDirectoryPath) {
      stdout.writeln('Preparing ${ref.ref}');
      sourceDir = ref.ref;
      if (depth != null && depth != 0 && !ref.isAbsolutePath) {
        if (sourceDir.endsWith('/')) {
          sourceDir = sourceDir.substring(0, sourceDir.length - 1);
        }
        int componentsCount =
            sourceDir == '.' ? 0 : sourceDir.split('/').length;
        if (componentsCount < depth) {
          throw ArgumentError(
              'Package path (${ref.ref}) components count ($componentsCount) is lower than package relative location depth ($depth)');
        }
        packageRelativePath =
            sourceDir.split('/').sublist(componentsCount - depth).join('/');
        if (packageRelativePath.split('/').any((element) => element == '..')) {
          throw ArgumentError(
              'Package path (${ref.ref}) should not have ".." as one of last $depth components (copy-depth).');
        }
        sourceDir = ref.ref + '/..' * depth;
      }
    } else if (ref.isPubRef) {
      stdout.writeln('Preparing ${ref.pubPackage!}:${ref.pubVersion!}');
      stdout.writeln('Downloading');
      sourceDir = await PubInteraction.installPackageToCache(
          ref.pubPackage!, ref.pubVersion!);
    } else {
      throw ArgumentError('Unknown package ref: ${ref.ref}');
    }
    final tempDir = await Directory.systemTemp.createTemp();
    stdout.writeln('Copying sources from $sourceDir');
    await _copyPath(sourceDir, tempDir.path);
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
