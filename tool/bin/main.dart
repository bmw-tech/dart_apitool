import 'package:args/command_runner.dart';
import 'package:dart_apitool/api_tool_cli.dart';

void main(List<String> arguments) async {
  CommandRunner('dart run dart_apitool', 'A set of utilities for Package APIs')
    ..addCommand(DiffCommand())
    ..addCommand(ExtractCommand())
    ..run(arguments);
}
