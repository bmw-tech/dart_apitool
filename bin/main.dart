// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:args/args.dart';
import 'package:dart_apitool/project_api_analyzer.dart';

void main(List<String> arguments) async {
  final listArgParser = ArgParser();

  final parser = ArgParser();
  final listCommandParser = parser.addCommand('list', listArgParser);
  listCommandParser.addOption('root',
      abbr: 'r', mandatory: true, help: 'root directory');

  final argResults = parser.parse(arguments);
  final cmd = argResults.command;
  if (cmd != null) {
    switch (cmd.name) {
      case 'list':
        await _handleListCommand(cmd);
        break;
      default:
    }
  }
}

Future _handleListCommand(ArgResults cmd) async {
  final String rootDir = cmd['root'];
  final analyzer = ProjectApiAnalyzer(projectPath: rootDir);
  final projectApi = await analyzer.analyze();

  const encoder = JsonEncoder.withIndent('    ');

  final jsonString = encoder.convert(projectApi.toJson());
  print(jsonString);
}
