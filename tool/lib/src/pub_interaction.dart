import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;

/// helper class for interactions with pub
abstract class PubInteraction {
  /// installs a package to the pub cache and returns the path to it (or [null] when the installation was not successful)
  static Future<String?> installPackageToCache(
      String packageName, String version) async {
    try {
      await _runDart(args: ['pub', 'cache', 'add', packageName, '-v $version']);
    } catch (error) {
      return null;
    }
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
    final homeDir = Platform.environment['HOME']; //TODO: Windows
    final envHosted = Platform.environment['PUB_HOSTED'];
    final hostedUrl = envHosted ?? 'pub.dartlang.org';
    return path.join(
        homeDir!, '.pub-cache', 'hosted', hostedUrl, '$packageName-$version');
  }

  static Future<String> _runDart({List<String> args = const []}) async {
    final result =
        await Process.run(_getDartExecutablePath(), args, runInShell: true);
    if (result.exitCode != 0) {
      throw RunDartError(result.stderr);
    }
    return result.stdout;
  }

  static String _getDartExecutablePath() {
    return path.normalize(path.absolute(Platform.resolvedExecutable));
  }
}

class RunDartError extends Error {
  final String stdErr;

  RunDartError(this.stdErr);
}
