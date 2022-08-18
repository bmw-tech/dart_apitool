import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:colorize/colorize.dart';
import 'package:dart_apitool/api_tool_cli.dart';

void main(List<String> arguments) async {
  final runner =
      CommandRunner<int>('dart-apitool', 'A set of utilities for Package APIs')
        ..addCommand(DiffCommand())
        ..addCommand(ExtractCommand());
  try {
    final exitCode = await runner.run(arguments);
    exit(exitCode!);
  } catch (e) {
    bool colorize = true;
    if (e is UsageException) {
      colorize = false;
    }
    final errorMessage =
        colorize ? Colorize(e.toString()).red() : Colorize(e.toString());
    final errorPrefix =
        colorize ? Colorize('Error:').red().bold() : Colorize('Error:');
    stderr.writeln('$errorPrefix $errorMessage');
    exit(1);
  }
}
