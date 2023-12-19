import 'dart:io';

import 'package:dart_apitool/src/tooling/dart_interaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;
import '../errors/run_dart_error.dart';
import '../utils/utils.dart';

/// helper class for interactions with pub
abstract class PubInteraction {
  /// installs a package to the pub cache and returns the path to it throws [RunDartError] on failure
  static Future<String> installPackageToCache(
    String packageName,
    String version, {
    StdoutSession? stdoutSession,
  }) async {
    await DartInteraction.runDartCommand(
      args: [
        'pub',
        'cache',
        'add',
        packageName,
        '-v $version',
      ],
      stdoutSession: stdoutSession,
    );
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

  /// gets the pub cache directory
  static String get pubCacheDir {
    String? cacheDir = Platform.environment['PUB_CACHE'];
    if (cacheDir == null) {
      if (Platform.isWindows) {
        cacheDir =
            path.join(Platform.environment['LOCALAPPDATA']!, 'Pub', 'Cache');
      } else {
        cacheDir = path.join(Platform.environment['HOME']!, '.pub-cache');
      }
    }
    return cacheDir;
  }

  /// returns the cache path of a package with the given [packageName] and [version]
  static String getPackagePathInCache(String packageName, String version) {
    String? findHostedDirectory(List<String> hostedUrls) {
      for (final hostedUrl in hostedUrls) {
        final packagePath = path.join(hostedUrl, '$packageName-$version');
        if (Directory(packagePath).existsSync()) {
          return packagePath;
        }
      }
      return null;
    }

    final cacheDir = pubCacheDir;
    final hostedDir = path.join(cacheDir, 'hosted');
    List<String> hostedDirs = [];

    if (Directory(hostedDir).existsSync()) {
      Directory(hostedDir)
          .listSync()
          .map((entity) => entity.path)
          .forEach((path) {
        if (Directory(path).existsSync()) {
          hostedDirs.add(path);
        }
      });
    }

    final envHostedUrl = Platform.environment['PUB_HOSTED_URL'];
    final envHosted =
        envHostedUrl == null ? null : Uri.parse(envHostedUrl).host;

    final List<String> hostPriorities = [
      // first check PUB_HOSTED_URL from environment variable if set
      if (envHosted != null) envHosted,
      // Flutter 3.7 changed the name of the pub.dev directory => first test the old one, then the new one
      'pub.dartlang.org',
      'pub.dev',
    ];

    for (final hostPriority in hostPriorities) {
      final matchingHostedDirs =
          hostedDirs.where((dir) => dir.startsWith(hostPriority)).toList();
      final foundPackagePath = findHostedDirectory(matchingHostedDirs);
      if (foundPackagePath != null) {
        return foundPackagePath;
      }
    }
    return findHostedDirectory(hostedDirs)!;
  }

  /// runs pub get in the given [packageDirectory]
  /// depending or the package either `dart` or `flutter` is executed
  static Future runPubGet(
    String packageDirectory, {
    StdoutSession? stdoutSession,
  }) async {
    return DartInteraction.runDartOrFlutterCommand(
      packageDirectory,
      args: [
        'pub',
        'get',
      ],
      stdoutSession: stdoutSession,
    );
  }
}
