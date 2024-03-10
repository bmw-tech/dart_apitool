import 'dart:async';
import 'dart:io';

import 'package:lumberdash/lumberdash.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:path/path.dart' as path;

import '../errors/errors.dart';
import '../utils/utils.dart';

/// Helper class for interacting with Dart and Flutter
abstract class DartInteraction {
  /// runs the dart or flutter command with the given [args].
  /// The decision which command to run is taken from the pubspec.yaml file in
  /// [forDirectory]
  /// This command determines which tool to use based on the pubspcec.yaml file.
  /// If [overrideUseFlutterCommand] is given then this value will be used to
  /// determine which tool to use. [true] means Flutter, [false] means Dart
  static Future runDartOrFlutterCommand(
    String forDirectory, {
    List<String> args = const [],
    StdoutSession? stdoutSession,
    bool? overrideUseFlutterCommand,
  }) async {
    bool useFlutter = false;
    if (overrideUseFlutterCommand == null) {
      // if no override is specified we get the information which tool to use
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
      // if the decision is overridden we use the given value (overrideUseFlutterCommand == true => Flutter, == false => Dart)
      useFlutter = overrideUseFlutterCommand;
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
