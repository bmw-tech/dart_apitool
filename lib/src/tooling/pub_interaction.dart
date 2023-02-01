import 'dart:io';

import 'package:dart_apitool/src/tooling/dart_interaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;
import '../errors/run_dart_error.dart';

/// helper class for interactions with pub
abstract class PubInteraction {
  /// installs a package to the pub cache and returns the path to it throws [RunDartError] on failure
  static Future<String> installPackageToCache(
      String packageName, String version) async {
    await DartInteraction.runDartCommand(
        args: ['pub', 'cache', 'add', packageName, '-v $version']);
    return getPackagePathInCache(packageName, version);
  }

  @visibleForTesting
  static Future<bool> removePackageFromCache(
      String packageName, String version) async {
    try {
      final directory = Directory(getPackagePathInCache(packageName, version));
      if (!await directory.exists()) {
        return true;
      }
      await directory.delete();
    } catch (error) {
      return false;
    }
    return true;
  }

  /// returns the cache path of a package with the given [packageName] and [version]
  static String getPackagePathInCache(String packageName, String version) {
    String getHostedDirectory(String cacheDir, String hostedUrl) {
      return path.join(cacheDir, 'hosted', hostedUrl, '$packageName-$version');
    }

    String? cacheDir = Platform.environment['PUB_CACHE'];
    if (cacheDir == null) {
      if (Platform.isWindows) {
        cacheDir =
            path.join(Platform.environment['LOCALAPPDATA']!, 'Pub', 'Cache');
      } else {
        cacheDir = path.join(Platform.environment['HOME']!, '.pub-cache');
      }
    }
    final envHostedUrl = Platform.environment['PUB_HOSTED_URL'];
    final envHosted =
        envHostedUrl == null ? null : Uri.parse(envHostedUrl).host;
    if (envHosted == null) {
      // Flutter 3.7 changed the name of the pub.dev directory => first test the old one, then the new one
      var packageDirectory = getHostedDirectory(cacheDir, 'pub.dartlang.org');
      if (Directory(packageDirectory).existsSync()) {
        return packageDirectory;
      }
      packageDirectory = getHostedDirectory(cacheDir, 'pub.dev');
      return packageDirectory;
    } else {
      return getHostedDirectory(cacheDir, envHosted);
    }
  }

  /// runs pub get in the given [packageDirectory]
  /// depending or the package either `dart` or `flutter` is executed
  static Future runPubGet(String packageDirectory) async {
    return DartInteraction.runDartOrFlutterCommand(packageDirectory, args: [
      'pub',
      'get',
    ]);
  }
}
