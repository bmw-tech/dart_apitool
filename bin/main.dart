#!/usr/bin/env dart --checked

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:colorize/colorize.dart';
import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:dart_apitool/api_tool_cli.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

Future<String> _getOwnVersion() async {
  String? result;
  final mainFilePath = Platform.script.toFilePath();
  final pubspecFile =
      File(p.join(p.dirname(mainFilePath), '..', 'pubspec.yaml'));
  if (await pubspecFile.exists()) {
    final yamlContent = await pubspecFile.readAsString();
    final pubSpec = Pubspec.parse(yamlContent);
    result = pubSpec.version?.canonicalizedVersion;
  }
  if (result == null) {
    // if we are in a pub global environment we have to read our version from the pubspec.lock file
    final pubspecLockFile =
        File(p.join(p.dirname(mainFilePath), '..', 'pubspec.lock'));
    if (await pubspecLockFile.exists()) {
      final pubspecLockContent = await pubspecLockFile.readAsString();
      final pubspecLockDom = loadYaml(pubspecLockContent);
      result = pubspecLockDom['packages']['dart_apitool']['version'];
    }
  }
  if (result == null) {
    return 'UNKNOWN VERSION';
  }
  return result;
}

void main(List<String> arguments) async {
  putLumberdashToWork(withClients: [ColorizeLumberdash()]);
  final runner = CommandRunner<int>('dart-apitool', '''
dart-apitool (${Colorize(await _getOwnVersion()).bold()})

A set of utilities for Package APIs.
''')
    ..argParser.addFlag('version',
        abbr: 'v', help: 'Prints the version of this tool.', negatable: false)
    ..addCommand(DiffCommand())
    ..addCommand(ExtractCommand());
  try {
    final argParseResult = runner.argParser.parse(arguments);
    if (argParseResult['version']) {
      print(await _getOwnVersion());
      exit(0);
    }
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
