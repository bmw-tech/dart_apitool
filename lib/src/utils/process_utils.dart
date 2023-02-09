import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'stdout_session.dart';

/// utility class for running subprocesses
class ProcessUtils {
  /// runs the given [executablePath] with the given [args] and returns the stdout as a string
  /// In case of an error the stderr is thrown as an exception
  ///
  /// If [workingDirectory] is given then this directory will be passed to the
  /// Process as working directory
  ///
  /// If [stdoutSession] is given then the output of the subprocess will be written to the
  /// [StdoutSession] and the [StdoutSession] will be opened and closed
  static Future<String> runSubProcess(
    String executablePath, {
    String? workingDirectory,
    List<String> args = const [],
    StdoutSession? stdoutSession,
  }) async {
    final process = await Process.start(executablePath, args,
        workingDirectory: workingDirectory);

    List<StreamSubscription> subscriptions = [];

    List<int> stdoutBytes = [];
    List<int> stderrBytes = [];

    stdoutSession?.openSubprocessOutputWindow();

    subscriptions.add(
      process.stdout.listen(
        (event) {
          stdoutBytes.addAll(event);
          stdoutSession?.write(event);
        },
      ),
    );
    subscriptions.add(
      process.stderr.listen(
        (event) {
          stderrBytes.addAll(event);
          stdoutSession?.write(event);
        },
      ),
    );

    final exitCode = await process.exitCode;
    for (var element in subscriptions) {
      element.cancel();
    }
    stdoutSession?.closeSubprocessOutputWindow();
    final decoder = Utf8Decoder();
    if (exitCode != 0) {
      throw Exception(decoder.convert(stderrBytes));
    }
    return decoder.convert(stdoutBytes);
  }
}
