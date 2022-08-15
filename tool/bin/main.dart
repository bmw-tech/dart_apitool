// ignore_for_file: avoid_print

import 'package:args/args.dart';
import 'package:dart_apitool/api_tool.dart';

void main(List<String> arguments) async {
  final listArgParser = ArgParser();
  final dumpArgParser = ArgParser();

  final parser = ArgParser();
  final listCommandParser = parser.addCommand('list', listArgParser);
  listCommandParser.addOption('root',
      abbr: 'r', mandatory: true, help: 'root directory');
  final dumpCommandParser = parser.addCommand('dump', dumpArgParser);
  dumpCommandParser.addOption('root',
      abbr: 'r', mandatory: true, help: 'root directory');

  final argResults = parser.parse(arguments);
  final cmd = argResults.command;
  if (cmd != null) {
    switch (cmd.name) {
      case 'list':
        await _handleListCommand(cmd);
        break;
      case 'dump':
        await _handleDumpCommand(cmd);
        break;
      default:
    }
  }
}

void _printClasses(List<ClassDeclaration> classDeclarations) {
  print('** Classes:');
  for (final cd in classDeclarations) {
    print('-- ${cd.signature}');
    _printFields(cd.fieldDeclarations, indent: '    ');
    _printExecutables(cd.executableDeclarations, indent: '    ');
  }
}

void _printExecutables(
  List<ExecutableDeclaration> executableDeclarations, {
  String indent = '',
}) {
  print('$indent** Executables:');
  for (final exd in executableDeclarations) {
    print('  $indent${exd.signature}');
  }
}

void _printFields(
  List<FieldDeclaration> fieldDeclarations, {
  String indent = '',
}) {
  print('$indent** Fields:');
  for (final fd in fieldDeclarations) {
    print('  $indent${fd.signature}');
  }
}

Future _handleListCommand(ArgResults cmd) async {
  final String rootDir = cmd['root'];
  final analyzer = PackageApiAnalyzer(packagePath: rootDir);
  final packageApi = await analyzer.analyze();

  print(
      '----- Package ${packageApi.packageName} (${packageApi.packageVersion}) -----');
  _printFields(packageApi.fieldDeclarations);
  _printExecutables(packageApi.executableDeclarations);
  _printClasses(packageApi.classDeclarations);
}

Future _handleDumpCommand(ArgResults cmd) async {
  final String rootDir = cmd['root'];
  final analyzer = PackageApiAnalyzer(packagePath: rootDir);
  final projectApi = await analyzer.analyze();

  final jsonString =
      PackageApiStorage.packageApitoStorageJson(projectApi, pretty: true);
  print(jsonString);
}
