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

  /// prepares given [ref]. Depending on the type of ref this can include
  /// - copying the package to a temporary directory
  /// - running pub get
  /// If you use [analyze] with this result then it will take care to clean up
  /// everything (e.g. removing temp directory)
  Future<PreparedPackageRef> prepare(PackageRef ref) async {
    if (ref.isDirectoryPath) {
      await PubInteraction.runPubGet(ref.ref);
      return PreparedPackageRef(packageRef: ref);
    }
    if (ref.isPubRef) {
      stdout.writeln('Downloading ${ref.pubPackage!}:${ref.pubVersion!}');
      final cachePath = await PubInteraction.installPackageToCache(
          ref.pubPackage!, ref.pubVersion!);
      //Workaround. It seems that the analyzer has problems with no pub get run and it is not possible to run pub get in the cache directory
      final tempDir = await Directory.systemTemp.createTemp();
      await _copyPath(cachePath, tempDir.path);
      await PubInteraction.runPubGet(tempDir.path);
      return PreparedPackageRef(packageRef: ref, tempDirectory: tempDir.path);
    }
    throw ArgumentError('Unknown package ref: ${ref.ref}');
  }

  /// Analyzes the given prepared Package [ref].
  /// If the prepared package contains anything that has to be cleaned up
  /// (like created temp directories) then [analyze] takes care of that
  /// [doMergeBaseClasses] defines if base classes should be merged into derived ones. This allows to remove private base classes from the list of class declarations.
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
    stdout.writeln('Analyzing $path');
    final analyzer = PackageApiAnalyzer(
      packagePath: preparedRef.tempDirectory ?? path,
      doMergeBaseClasses: doMergeBaseClasses,
      doAnalyzePlatformConstraints: doAnalyzePlatformConstraints,
    );
    return await analyzer.analyze();
  }

  Future cleanUp(PreparedPackageRef preparedPackageRef) {
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
