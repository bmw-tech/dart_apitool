import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:plist_parser/plist_parser.dart';
import '../../model/model.dart';

abstract class IOSPlatformConstraintsHelper {
  /// determines the AndroidPlaformConstrants for the given package path
  static Future<IOSPlatformConstraints?> getIOSPlatformConstraints({
    required String packagePath,
  }) async {
    // check if the project has an iOS Platform
    final iosPlatformDirectory = Directory(path.join(packagePath, 'ios'));
    if (await iosPlatformDirectory.exists()) {
      // get all plist files
      final plistFiles = await iosPlatformDirectory
          .list(recursive: true)
          .where((file) => path.extension(file.path) == '.plist')
          .toList();

      IOSPlatformConstraints iosPlatformConstraints = IOSPlatformConstraints(
        minimumOsVersion: null,
      );
      for (final plistFile in plistFiles) {
        final plistContent = await PlistParser().parseFile(plistFile.path);
        if (plistContent.containsKey('MinimumOSVersion')) {
          final minimumOsVersionString = plistContent['MinimumOSVersion'];
          final minimumOsVersion = num.tryParse(minimumOsVersionString);
          if (minimumOsVersion != null) {
            if (iosPlatformConstraints.minimumOsVersion == null ||
                iosPlatformConstraints.minimumOsVersion! < minimumOsVersion) {
              iosPlatformConstraints = iosPlatformConstraints.copyWith(
                minimumOsVersion: minimumOsVersion,
              );
            }
          }
        }
      }

      // get all podspec files
      final podspecFiles = await iosPlatformDirectory
          .list(recursive: true)
          .where((file) => path.extension(file.path) == '.podspec')
          .toList();
      for (final podspecFile in podspecFiles) {
        if (podspecFile is! File) {
          continue;
        }
        final podspecContent = await podspecFile.readAsString();
        final minimumOsVersion =
            _getMinimumOsVersionFromPodspecContent(podspecContent);
        if (minimumOsVersion != null) {
          if (iosPlatformConstraints.minimumOsVersion == null ||
              iosPlatformConstraints.minimumOsVersion! < minimumOsVersion) {
            iosPlatformConstraints = iosPlatformConstraints.copyWith(
              minimumOsVersion: minimumOsVersion,
            );
          }
        }
      }
      return iosPlatformConstraints;
    }
    return null;
  }

  static num? _getMinimumOsVersionFromPodspecContent(String podspecContent) {
    final minimumOsVersionMatches =
        RegExp(r"platform\s*=\s*:ios\s*,\s*'(?<num>[0-9.]+)'")
            .allMatches(podspecContent);
    if (minimumOsVersionMatches.isNotEmpty) {
      final minimumOsVersionString =
          minimumOsVersionMatches.first.namedGroup('num');
      if (minimumOsVersionString != null) {
        return num.tryParse(minimumOsVersionString);
      }
    }
    return null;
  }
}
