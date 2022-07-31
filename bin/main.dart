import 'dart:collection';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:args/args.dart';
import 'package:dart_apitool/src/ApiRelevantElementsCollector.dart';
import 'package:dart_apitool/src/ReferencedFilesCollector.dart';
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

String _getPackageNameFromLibraryIdentifier(String libraryIdentifier) {
  if (!libraryIdentifier.startsWith('package:')) {
    return '';
  }
  int endIndex = libraryIdentifier.length;
  if (libraryIdentifier.contains('/')) {
    endIndex = libraryIdentifier.indexOf('/');
  }

  return libraryIdentifier.substring('package:'.length, endIndex);
}

String _getRelativeUriFromLibraryIdentifier(String libraryIdentifier) {
  if (!libraryIdentifier.contains('package:')) {
    return libraryIdentifier;
  }
  if (!libraryIdentifier.contains('/')) {
    throw ArgumentError.value(libraryIdentifier, 'libraryIdentifier',
        'Looks like a package (starts with \'package:\' but doesn\'t contain \'/\'');
  }
  return libraryIdentifier.substring(libraryIdentifier.indexOf('/'));
}

bool _isInternalRef(
    {required LibraryElement originLibrary,
    required LibraryElement? refLibrary}) {
  if (refLibrary == null) {
    return true;
  }
  final origPackageName =
      _getPackageNameFromLibraryIdentifier(originLibrary.identifier);
  final refPackageName =
      _getPackageNameFromLibraryIdentifier(refLibrary.identifier);

  return origPackageName == refPackageName;
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
    analyzedFiles.add(fileToAnalyze);

    try {
      final context = contextCollection.contextFor(fileToAnalyze);

      final unitResult =
          await context.currentSession.getResolvedUnit(fileToAnalyze);
      if (unitResult is ResolvedUnitResult) {
        if (!unitResult.isPart) {
          print('*** ${unitResult.path} ***');
          final collector = APIRelevantElementsCollector();
          unitResult.libraryElement.accept(collector);
          // for (final thing in collector.things) {
          //   print('    ${thing}');
          // }
          for (final executableDeclaration
              in collector.executableDeclarations) {
            print(
                '${executableDeclaration.type.name}: ${executableDeclaration.parentClassName}: ${executableDeclaration.signature}');
          }
          for (final fieldDeclaration in collector.fieldDeclarations) {
            print(
                'Field: ${fieldDeclaration.parentClassName}: ${fieldDeclaration.signature}');
          }
        }

        final referencedFilesCollector = ReferencedFilesCollector();
        unitResult.libraryElement.accept(referencedFilesCollector);
        for (final fileRef in referencedFilesCollector.fileReferences) {
          if (!_isInternalRef(
              originLibrary: fileRef.originLibrary,
              refLibrary: fileRef.referencedLibrary)) {
            continue;
          }
          final relativeUri = _getRelativeUriFromLibraryIdentifier(fileRef.uri);
          final referencedFilePath = path
              .normalize(path.join(path.dirname(fileToAnalyze), relativeUri));
          if (!analyzedFiles.contains(referencedFilePath) &&
              !filesToAnalyze.contains(referencedFilePath)) {
            filesToAnalyze.add(referencedFilePath);
          }

//           print('''
// ref:
//   - Type: ${fileRef.type}
//   - Uri: ${fileRef.uri}
//   - Orig-Lib: ${fileRef.originLibrary.identifier}
//   - Ref-Lib: ${fileRef.referencedLibrary?.identifier ?? '[none]'}
// ''');
        }
      }
    } on StateError catch (e) {
      print('Problem parsing $fileToAnalyze: $e');
    }
  }
}
