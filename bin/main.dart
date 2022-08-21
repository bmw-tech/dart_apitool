#!/usr/bin/env dart --checked

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:colorize/colorize.dart';
import 'package:dart_apitool/api_tool_cli.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import 'package:path/path.dart' as p;

void main(List<String> arguments) async {
  final mainFilePath = Platform.script.toFilePath();
  final yamlContent =
      await File(p.join(p.dirname(mainFilePath), '..', 'pubspec.yaml'))
          .readAsString();
  final pubSpec = Pubspec.parse(yamlContent);
  final runner = CommandRunner<int>('dart-apitool', '''
dart-apitool (${Colorize(pubSpec.version.toString()).bold()})

A set of utilities for Package APIs.
''')
    ..addCommand(DiffCommand())
    ..addCommand(ExtractCommand());
  try {
    final exitCode = await runner.run(arguments);
    exit(exitCode ?? -1);
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
