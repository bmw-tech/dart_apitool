import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:lumberdash/lumberdash.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:path/path.dart' as path;

import 'package:package_config/package_config.dart' as package_config;

import '../errors/errors.dart';
import '../utils/utils.dart';

/// Helper class for interacting with Dart and Flutter
abstract class DartInteraction {
  /// runs the dart or flutter command with the given [args].
  /// The decision which command to run is taken from the pubspec.yaml file in
  /// [forDirectory]
  /// This command determines which tool to use based on the pubspec.yaml file.
  /// If [forceUseFlutterTool] is given then this value will be used to
  /// determine which tool to use. [true] means Flutter, [false] means Dart
  static Future runDartOrFlutterCommand(
    String forDirectory, {
    List<String> args = const [],
    StdoutSession? stdoutSession,
    bool forceUseFlutterTool = false,
  }) async {
    bool useFlutter = false;
    if (!forceUseFlutterTool) {
      // if we are not forced to use Flutter then we get this information
      // from the pubspec.yaml file
      final pubspecPath = path.join(forDirectory, 'pubspec.yaml');
      final pubspecExists = await File(pubspecPath).exists();
      if (!pubspecExists) {
        throw RunDartError(
            'Error running pub get in $forDirectory:\nThis is not a valid dart package directory');
      }
      final yamlContent = await File(pubspecPath).readAsString();
      final pubSpec = Pubspec.parse(yamlContent);
      useFlutter = pubSpec.dependencies.containsKey('flutter');
    } else {
      // here we are forced to use Flutter (forceUseFlutterTool == true)
      useFlutter = true;
    }
    if (!useFlutter) {
      return _runDartOrFlutterCommand(
        _getDartExecutablePath(),
        workingDirectory: forDirectory,
        args: args,
        stdoutSession: stdoutSession,
      );
    } else {
      final flutterExecutablePath = await _findFlutterExecutablePath();
      if (flutterExecutablePath == null) {
        logWarning(
          'Unable to find matching Flutter executable. Using system Flutter executable...',
          extras: {
            'dart executable': _getDartExecutablePath(),
          },
        );
      }
      return _runDartOrFlutterCommand(
        flutterExecutablePath ?? 'flutter',
        workingDirectory: forDirectory,
        args: args,
        stdoutSession: stdoutSession,
        runInShell: flutterExecutablePath == null,
      );
    }
  }

  /// runs the dart command with the given [args].
  /// If [workingDirectory] is given then this directory will be passed to the
  /// Process as working directory
  static Future<String> runDartCommand({
    String? workingDirectory,
    List<String> args = const [],
    StdoutSession? stdoutSession,
  }) {
    return _runDartOrFlutterCommand(_getDartExecutablePath(),
        args: args,
        workingDirectory: workingDirectory,
        stdoutSession: stdoutSession);
  }

  static Future transferPackageConfig({
    required String fromPackage,
    required String toPackage,
    required StdoutSession stdoutSession,
    ({
      String oldPackageName,
      String newPackageName
    })? packageNameReplacementInfo,
  }) async {
    // we need to turn relative paths into absolute paths as the
    // functionality to find the package config is relying on absolute paths
    if (path.isRelative(fromPackage)) {
      fromPackage = path.absolute(fromPackage);
    }
    if (path.isRelative(toPackage)) {
      toPackage = path.absolute(toPackage);
    }

    final packageConfig =
        await package_config.findPackageConfig(Directory(fromPackage));
    if (packageConfig == null) {
      throw Exception('No package config found for $fromPackage');
    }
    await package_config.savePackageConfig(packageConfig, Directory(toPackage));

    // now we need to replace all references to "fromPackage" with "toPackage"
    // and apply potentially given package replacements
    final packageConfigFile = File(
      path.join(toPackage, '.dart_tool', 'package_config.json'),
    );
    if (!packageConfigFile.existsSync()) {
      throw Exception('No package config file found for $toPackage');
    }
    final packageConfigContent = await packageConfigFile.readAsString();
    final packageConfigJson = jsonDecode(packageConfigContent);
    for (final packageEntry in packageConfigJson['packages']) {
      final rootUri = Uri.parse(packageEntry['rootUri']);
      if (rootUri.isScheme('file')) {
        final rootPath = rootUri.toFilePath();
        if (path.equals(fromPackage, rootPath)) {
          packageEntry['rootUri'] = Uri.file(toPackage).toString();
        }
      }
      if (packageNameReplacementInfo != null &&
          packageEntry['name'] == packageNameReplacementInfo.oldPackageName) {
        packageEntry['name'] = packageNameReplacementInfo.newPackageName;
      }
    }
    await packageConfigFile.writeAsString(jsonEncode(packageConfigJson));
  }

  static Future<String> _runDartOrFlutterCommand(
    String executablePath, {
    String? workingDirectory,
    List<String> args = const [],
    StdoutSession? stdoutSession,
    bool? runInShell,
  }) async {
    try {
      return await ProcessUtils.runSubProcess(
        executablePath,
        workingDirectory: workingDirectory,
        args: args,
        stdoutSession: stdoutSession,
        runInShell: runInShell ?? false,
      );
    } catch (e) {
      throw RunDartError(e.toString());
    }
  }

  static String _getDartExecutablePath() {
    return path.normalize(path.absolute(Platform.resolvedExecutable));
  }

  static Future<String?> _findFlutterExecutablePath() async {
    final dartExecutableDirPath = _getDartExecutablePath();

    final flutterExecutableName =
        Platform.isWindows ? 'flutter.bat' : 'flutter';

    // trying to search in the first bin folder from the dart executable path
    // we have to search for it this way as we want to find the matching flutter executable.
    // if the user is using e.g. fvm then we can't just run the first flutter executable visible
    // on PATH
    final parts = path.split(dartExecutableDirPath).toList(growable: true);
    int binIndex = parts.lastIndexOf('bin');
    while (binIndex >= 0) {
      final binPath = path.joinAll(parts.take(binIndex + 1));
      final flutterFilePath = path.join(binPath, flutterExecutableName);
      if (await File(flutterFilePath).exists()) {
        return flutterFilePath;
      }
      parts.removeRange(binIndex, parts.length);
      binIndex = parts.lastIndexOf('bin');
    }
    return null;
  }
}
