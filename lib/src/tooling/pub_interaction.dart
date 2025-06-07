import 'dart:io';

import 'package:dart_apitool/src/tooling/dart_interaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart' as path;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import '../errors/run_dart_error.dart';
import '../utils/utils.dart';

/// helper class for interactions with pub
abstract class PubInteraction {
  /// installs a package to the pub cache and returns the path to it throws [RunDartError] on failure
  /// if no [version] is provided dart will decide what version to use ("the best of all known versions")
  static Future<String> installPackageToCache(
    String packageName,
    String? version, {
    StdoutSession? stdoutSession,
  }) async {
    await DartInteraction.runDartCommand(
      args: [
        'pub',
        'cache',
        'add',
        packageName,
        if (version != null) '-v $version',
      ],
      stdoutSession: stdoutSession,
    );
    if (version == null) {
      await stdoutSession?.writeln(
          'No version for $packageName specified, using latest version');
      final latestVersion = getLatestVersionInCacheFor(packageName);
      version = latestVersion.toString();
      await stdoutSession?.writeln('Using version $version');
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

  static Version getLatestVersionInCacheFor(String packageName) {
    final allVersions = getAllPackageVersionsForPackageInCache(packageName);
    final versions = allVersions.keys.toList(growable: false);
    if (versions.isEmpty) {
      throw RunDartError('No version of $packageName found');
    }

    return versions.reduce((v1, v2) => v1 > v2 ? v1 : v2);
  }

  static Map<Version, String> getAllPackageVersionsForPackageInCache(
      String packageName) {
    final cacheDir = pubCacheDir;
    final hostedDir = path.join(cacheDir, 'hosted');

    final versions = <Version, String>{};

    final repositoryDirs =
        Directory(hostedDir).listSync().whereType<Directory>().toList();

    for (final repositoryDir in repositoryDirs) {
      for (final potentialPackageDir
          in repositoryDir.listSync().whereType<Directory>()) {
        final packageDirName = path.basename(potentialPackageDir.path);
        final dirParts = packageDirName.split('-').toList();
        final versionPart = dirParts.last;
        dirParts.removeLast();
        final packageNamePart = dirParts.join('-');

        if (packageNamePart != packageName) {
          continue;
        }

        final version = Version.parse(versionPart);
        versions[version] = potentialPackageDir.path;
      }
    }
    return versions;
  }

  /// returns the cache path of a package with the given [packageName] and [version]
  /// if [version] is null the latest version is used
  static String getPackagePathInCache(String packageName, String? version) {
    version ??= getLatestVersionInCacheFor(packageName).toString();

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
    bool forceUseFlutterTool = false,
  }) async {
    return DartInteraction.runDartOrFlutterCommand(
      packageDirectory,
      args: [
        'pub',
        'get',
      ],
      stdoutSession: stdoutSession,
      forceUseFlutterTool: forceUseFlutterTool,
    );
  }

  /// runs pub get indirectly by creating a temporary package that refers to [forDirectory] and copying the result back
  static Future runPubGetIndirectly(
    String forDirectory, {
    required StdoutSession stdoutSession,
    bool forceUseFlutterTool = false,
  }) async {
    final forDirectoryPubspecPath = path.join(forDirectory, 'pubspec.yaml');
    final forDirectoryPubspec =
        Pubspec.parse(File(forDirectoryPubspecPath).readAsStringSync());
    final packageName = forDirectoryPubspec.name;
    final isFlutter = forDirectoryPubspec.flutter != null;

    String potentialFlutterDependency = isFlutter
        ? '''
  flutter:
    sdk: flutter
'''
        : '';

    final tempDirectory = Directory.systemTemp.createTempSync();
    final tempPackagePath = path.join(tempDirectory.path, 'temp_package');
    final tempPackagePubspecPath = path.join(tempPackagePath, 'pubspec.yaml');
    Directory(tempPackagePath).createSync(recursive: true);
    File(tempPackagePubspecPath).writeAsStringSync(
      '''
name: temp_package
version: 0.0.1
publish_to: none

environment:
  sdk: '>=3.5.0 <4.0.0'

dependencies:
  $packageName:
    path: $forDirectory
$potentialFlutterDependency
''',
    );
    await DartInteraction.runDartOrFlutterCommand(tempPackagePath,
        args: ['pub', 'get'],
        stdoutSession: stdoutSession,
        forceUseFlutterTool: forceUseFlutterTool);
    await DartInteraction.transferPackageConfig(
      fromPackage: tempPackagePath,
      toPackage: forDirectory,
      stdoutSession: stdoutSession,
      packageNameReplacementInfo: (
        oldPackageName: 'temp_package',
        newPackageName: packageName
      ),
    );
    await Directory(tempDirectory.path).delete(recursive: true);
  }
}
