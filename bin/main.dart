import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:args/args.dart';
import 'package:dart_apitool/ApiRelevantElementsCollector.dart';
import 'package:path/path.dart' as path;

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

AnalysisContextCollection _createAnalysisContextCollection({
  required String path,
  ResourceProvider? resourceProvider,
}) {
  AnalysisContextCollection collection = AnalysisContextCollection(
    includedPaths: <String>[path],
    resourceProvider: resourceProvider ?? PhysicalResourceProvider.INSTANCE,
  );
  return collection;
}

String _makePackageSubPath(String projectPath, List<String> directories) {
  return path.normalize(
    path.absolute(
      path.joinAll([
        projectPath,
        ...directories,
      ]),
    ),
  );
}

Future _handleListCommand(ArgResults cmd) async {
  final String rootDir = cmd['root'];
  final absolutePath = path.normalize(path.absolute(rootDir));

  final relativeSearchPathParts = const [
    ['lib'],
    ['lib', 'src'],
    ['bin'],
    ['web'],
    ['test'],
  ];

  final dartFiles = relativeSearchPathParts.map((parts) {
    final dirPath = _makePackageSubPath(absolutePath, parts);
    if (!Directory(dirPath).existsSync()) {
      return <String>[];
    }
    return Directory(dirPath)
        .listSync(recursive: true)
        .where((file) => path.extension(file.path) == '.dart')
        //.where((file) => !exportedOnly || !file.path.contains('lib/src/'))
        .map((file) => path.normalize(path.absolute(file.path)));
  }).fold<List<String>>(List<String>.empty(growable: true), (result, element) {
    result.addAll(element);
    return result;
  }).toSet();

  final resourceProvider = PhysicalResourceProvider.INSTANCE;

  final contextCollection = _createAnalysisContextCollection(
    path: absolutePath,
    resourceProvider: resourceProvider,
  );

  for (final filePath in dartFiles) {
    try {
      final context = contextCollection.contextFor(filePath);

      final unitResult = await context.currentSession.getResolvedUnit(filePath);
      if (unitResult is ResolvedUnitResult) {
        if (!unitResult.isPart) {
          print('*** ${unitResult.path} ***');
          final collector = APIRelevantElementsCollector();
          unitResult.libraryElement.accept(collector);
          for (final thing in collector.things) {
            print('    ${thing}');
          }
//          unitResult.libraryElement.accept(collector);
        }
      }
    } on StateError catch (e) {
      print('Problem parsing $filePath: $e');
    }
  }
}
