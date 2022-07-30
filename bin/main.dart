import 'dart:collection';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:args/args.dart';
import 'package:dart_apitool/ApiRelevantElementsCollector.dart';
import 'package:dart_apitool/ReferencedFilesCollector.dart';
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

  final entryPointDirPath = _makePackageSubPath(absolutePath, ['lib']);
  final entryPointFiles = Directory(entryPointDirPath)
      .listSync(recursive: false)
      .where((file) => path.extension(file.path) == '.dart')
      .map((file) => path.normalize(path.absolute(file.path)));

  final analyzedFiles = List<String>.empty(growable: true);
  final filesToAnalyze = Queue<String>();
  filesToAnalyze.addAll(entryPointFiles);

  final resourceProvider = PhysicalResourceProvider.INSTANCE;

  final contextCollection = _createAnalysisContextCollection(
    path: absolutePath,
    resourceProvider: resourceProvider,
  );

  while (filesToAnalyze.isNotEmpty) {
    final fileToAnalyze = filesToAnalyze.first;
    filesToAnalyze.removeFirst();

    try {
      final context = contextCollection.contextFor(fileToAnalyze);

      final unitResult =
          await context.currentSession.getResolvedUnit(fileToAnalyze);
      if (unitResult is ResolvedUnitResult) {
        if (!unitResult.isPart) {
          print('*** ${unitResult.path} ***');
          final collector = APIRelevantElementsCollector();
          unitResult.libraryElement.accept(collector);
          for (final thing in collector.things) {
            print('    ${thing}');
          }
        }

        final referencedFilesCollector = ReferencedFilesCollector();
        unitResult.libraryElement.accept(referencedFilesCollector);
        for (final fileRef in referencedFilesCollector.fileReferences) {
          print('ref:');
          print('  - Type: ${fileRef.type}');
          print('  - Uri: ${fileRef.uri}');
          print('  - Orig-Lib: ${fileRef.originLibrary.identifier}');
          print(
              '  - Ref-Lib: ${fileRef.referencedLibrary?.identifier ?? '[none]'}');
        }
      }
    } on StateError catch (e) {
      print('Problem parsing $fileToAnalyze: $e');
    }
  }
}
