import 'dart:io';

import 'package:path/path.dart' as path;

import 'package:dart_apitool/src/model/model.dart';

abstract class AndroidPlatformConstraintsHelper {
  /// determines the AndroidPlaformConstrants for the given package path
  static Future<AndroidPlatformConstraints?> getAndroidPlatformConstraints({
    required String packagePath,
  }) async {
    // check if the project has an Android Platform
    final androidPlatformDirectory =
        Directory(path.join(packagePath, 'android'));
    if (await androidPlatformDirectory.exists()) {
      // get all gradle files
      final gradleFiles = await androidPlatformDirectory
          .list(recursive: true)
          .where((file) => path.extension(file.path) == '.gradle')
          .toList();
      AndroidPlatformConstraints androidPlatformConstraints =
          AndroidPlatformConstraints(
        compileSdkVersion: null,
        minSdkVersion: null,
        targetSdkVersion: null,
      );
      for (final gradleFile in gradleFiles) {
        if (gradleFile is File) {
          final fileContent = await gradleFile.readAsString();
          final androidPlatformConstraintsFromFile =
              _getAndroidPlatformConstraintsFromGradleFileContent(fileContent);
          if (androidPlatformConstraintsFromFile != null) {
            androidPlatformConstraints = _mergeAndroidPlatformConstraints(
                androidPlatformConstraints, androidPlatformConstraintsFromFile);
          }
        }
      }
      return androidPlatformConstraints;
    }
    return null;
  }

  static AndroidPlatformConstraints _mergeAndroidPlatformConstraints(
      AndroidPlatformConstraints a, AndroidPlatformConstraints b) {
    return AndroidPlatformConstraints(
      minSdkVersion: (a.minSdkVersion ?? 0) > (b.minSdkVersion ?? 0)
          ? a.minSdkVersion
          : b.minSdkVersion,
      compileSdkVersion: (a.compileSdkVersion ?? 0) > (b.compileSdkVersion ?? 0)
          ? a.compileSdkVersion
          : b.compileSdkVersion,
      targetSdkVersion: (a.targetSdkVersion ?? 0) > (b.targetSdkVersion ?? 0)
          ? a.targetSdkVersion
          : b.targetSdkVersion,
    );
  }

  static AndroidPlatformConstraints?
      _getAndroidPlatformConstraintsFromGradleFileContent(String fileContent) {
    final minSdkVersionMatches =
        RegExp(r'minSdkVersion (\d+)').allMatches(fileContent);
    final targetSdkVersionMatches =
        RegExp(r'targetSdkVersion (\d+)').allMatches(fileContent);
    final compileSdkVersionMatches =
        RegExp(r'compileSdkVersion (\d+)').allMatches(fileContent);

    int? versionFromMatches(Iterable<RegExpMatch> matches) {
      int? result;
      for (final match in matches) {
        final version = int.tryParse(match.group(1)!);
        if (version != null) {
          if (result == null || version > result) {
            result = version;
          }
        }
      }
      return result;
    }

    final minSdkVersion = versionFromMatches(minSdkVersionMatches);
    final targetSdkVersion = versionFromMatches(targetSdkVersionMatches);
    final compileSdkVersion = versionFromMatches(compileSdkVersionMatches);

    if (minSdkVersion != null ||
        targetSdkVersion != null ||
        compileSdkVersion != null) {
      return AndroidPlatformConstraints(
        minSdkVersion: minSdkVersion,
        compileSdkVersion: compileSdkVersion,
        targetSdkVersion: targetSdkVersion,
      );
    }
    return null;
  }
}
