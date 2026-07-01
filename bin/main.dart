#!/usr/bin/env dart --checked

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:dart_apitool/api_tool_cli.dart';
import 'package:lumberdash/lumberdash.dart';

void main(List<String> arguments) async {
  putLumberdashToWork(withClients: [ColorizeLumberdash()]);
  final runner = CommandRunner<int>('dart-apitool', '''
dart-apitool (${ColorUtils.bold(await getOwnVersion())})

A set of utilities for Package APIs.
''')
    ..argParser.addFlag('version',
        abbr: 'v', help: 'Prints the version of this tool.', negatable: false)
    ..addCommand(DiffCommand())
    ..addCommand(ExtractCommand());
  try {
    final argParseResult = runner.argParser.parse(arguments);
    if (argParseResult['version']) {
      print(await getOwnVersion());
      exit(0);
    }
    final exitCode = await runner.run(arguments);
    exit(exitCode ?? -1);
  } catch (e) {
    final errorMessage = ColorUtils.redError(e.toString());
    final errorPrefix = ColorUtils.boldRedError('Error:');
    stderr.writeln('$errorPrefix $errorMessage');
    exit(1);
  }
}
