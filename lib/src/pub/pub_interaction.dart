import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;
import '../errors/run_dart_error.dart';

/// helper class for interactions with pub
abstract class PubInteraction {
  /// installs a package to the pub cache and returns the path to it throws [RunDartError] on failure
  static Future<String> installPackageToCache(
      String packageName, String version) async {
    await _runDart(args: ['pub', 'cache', 'add', packageName, '-v $version']);
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
    final hostedUrl = envHosted ?? 'pub.dartlang.org';
    return path.join(cacheDir, 'hosted', hostedUrl, '$packageName-$version');
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
