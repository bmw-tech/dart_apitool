import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:pubspec_manager/pubspec_manager.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:path/path.dart' as path;

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

  /// Returns the path to the package config file for the given package.
  /// [packagePath] the `absolute` path to the package directory.
  /// If [doCheckWorkspace] is true then the function will check if the package
  /// is part of a workspace and return the package config path for the workspace.
  static String getPackageConfigPathForPackage(
    String packagePath, {
    required StdoutSession stdoutSession,
    required bool doCheckWorkspace,
  }) {
    String packageConfigPackagePath = packagePath;
    final packageDir = Directory(packagePath);
    if (doCheckWorkspace && packageDir.existsSync()) {
      // if the package directory exists (source) then we check if we have to deal with a workspace
      try {
        final pubspec = PubSpec.load(directory: packagePath);
        final resolutionSection =
            pubspec.document.findSectionForKey('resolution');
        if (!resolutionSection.missing) {
          bool resolvesWithWorkspace = false;
          for (final line in resolutionSection.lines) {
            if (line.text.contains('resolution:') &&
                line.text.trim().endsWith('workspace')) {
              resolvesWithWorkspace = true;
              break;
            }
          }
          if (resolvesWithWorkspace) {
            final workspacePath = _findWorkspacePath(packagePath);
            if (workspacePath == null) {
              stdoutSession
                  .writeln('Could not find workspace for package $packagePath');
            } else {
              packageConfigPackagePath = workspacePath;
            }
          }
        }
      } catch (e) {
        stdoutSession
            .writeln('Error loading pubspec.yaml, continuing anyways: $e');
      }
    }
    return path.join(
        packageConfigPackagePath, '.dart_tool', 'package_config.json');
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
    final fromPackageConfigPath = getPackageConfigPathForPackage(fromPackage,
        stdoutSession: stdoutSession, doCheckWorkspace: true);
    final toPackageConfigPath = getPackageConfigPathForPackage(toPackage,
        stdoutSession: stdoutSession, doCheckWorkspace: true);
    Directory(path.dirname(toPackageConfigPath)).createSync(recursive: true);
    File(toPackageConfigPath)
        .writeAsStringSync(File(fromPackageConfigPath).readAsStringSync());
    await _adaptPackageConfigToAbsolutePaths(
      targetPackageConfigPath: toPackageConfigPath,
      sourcePackageConfigPath: fromPackageConfigPath,
      packageNameReplacementInfo: packageNameReplacementInfo,
    );
  }

  static Future _adaptPackageConfigToAbsolutePaths({
    required String targetPackageConfigPath,
    required String sourcePackageConfigPath,
    ({
      String newPackageName,
      String oldPackageName
    })? packageNameReplacementInfo,
  }) async {
    final sourcePackageConfigDirPath = path.dirname(sourcePackageConfigPath);
    final sourcePackageDirPath =
        Directory(sourcePackageConfigDirPath).parent.path;
    final targetPackageConfigContent =
        jsonDecode(await File(targetPackageConfigPath).readAsString());
    if (packageNameReplacementInfo != null) {
      final packages = targetPackageConfigContent['packages'] as List;
      packages.removeWhere((package) =>
          package['name'] == packageNameReplacementInfo.newPackageName);
      packages.singleWhereOrNull((package) =>
              package['name'] ==
              packageNameReplacementInfo.oldPackageName)?['name'] =
          packageNameReplacementInfo.newPackageName;
    }
    // iterate through the package_config.json content and look for relative paths
    for (final packageConfig in targetPackageConfigContent['packages']) {
      final rootUri = Uri.parse(packageConfig['rootUri']);
      final packagePath = path.fromUri(rootUri);

      if (path.isRelative(packagePath)) {
        // we make the relative path absolute by using the origin of the source package config as a base
        final normalizedAbsolutePackagePath = path.absolute(
          path.normalize(path.join(sourcePackageConfigDirPath, packagePath)),
        );
        // if the relative path is the package path, then don't make it absolute
        if (path.equals(sourcePackageDirPath, normalizedAbsolutePackagePath)) {
          continue;
        }
        // and write the new absolute path back to the json structure
        packageConfig['rootUri'] =
            path.toUri(normalizedAbsolutePackagePath).toString();
      }
    }
    final encoder = JsonEncoder.withIndent('    ');
    // replace the package config with the new content
    await File(targetPackageConfigPath).writeAsString(
      encoder.convert(targetPackageConfigContent),
      mode: FileMode.write,
    );
  }

  static String? _findWorkspacePath(String packagePath) {
    Directory currentDirectory = Directory(packagePath).parent;
    while (currentDirectory.path != currentDirectory.parent.path) {
      if (!File(path.join(currentDirectory.path, 'pubspec.yaml'))
          .existsSync()) {
        currentDirectory = currentDirectory.parent;
        continue;
      }
      final pubspec = PubSpec.load(directory: currentDirectory.path);
      if (pubspec.document.findSectionForKey('workspace').missing) {
        currentDirectory = currentDirectory.parent;
      } else {
        return currentDirectory.path;
      }
    }
    return null;
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
