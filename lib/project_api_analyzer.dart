// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_apitool/model/project_api.dart';
import 'package:dart_apitool/src/api_relevant_elements_collector.dart';
import 'package:dart_apitool/src/referenced_files_collector.dart';
import 'package:dart_apitool/utils/string_utils.dart';
import 'package:path/path.dart' as path;

import 'model/class_declaration.dart';
import 'model/executable_declaration.dart';
import 'model/field_declaration.dart';
import 'src/model/internal_class_declaration.dart';
import 'src/model/internal_executable_declaration.dart';
import 'src/model/internal_field_declaration.dart';

class ProjectApiAnalyzer {
  final String projectPath;

  ProjectApiAnalyzer({required this.projectPath});

  Future<ProjectApi> analyze() async {
    final resourceProvider = PhysicalResourceProvider.INSTANCE;

    final normalizedAbsoluteProjectPath =
        _getNormalizedAbsolutePath(projectPath);
    final normalizedAbsolutePublicEntrypointPath = _getNormalizedAbsolutePath(
        path.join(normalizedAbsoluteProjectPath, 'lib'));

    final contextCollection = _createAnalysisContextCollection(
      path: normalizedAbsoluteProjectPath,
      resourceProvider: resourceProvider,
    );

    final collectedClasses = <int?, _ClassCollectionResult>{};

    final analyzedFiles = List<String>.empty(growable: true);
    final filesToAnalyze = Queue<String>();
    filesToAnalyze.addAll(
        _findPublicFilesInProject(normalizedAbsolutePublicEntrypointPath));

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
            final collector = APIRelevantElementsCollector();
            unitResult.libraryElement.accept(collector);
            final skippedClasses = <int>[];
            for (final cd in collector.classDeclarations) {
              if (!collectedClasses.containsKey(cd.id)) {
                collectedClasses[cd.id] = _ClassCollectionResult();
              }
              if (!collectedClasses[cd.id]!
                  .classDeclarations
                  .any((cdToCheck) => cdToCheck.id == cd.id)) {
                collectedClasses[cd.id]!.classDeclarations.add(cd);
              } else {
                skippedClasses.add(cd.id);
              }
            }
            for (final exd in collector.executableDeclarations) {
              if (skippedClasses.contains(exd.parentClassId)) {
                continue;
              }
              if (!collectedClasses.containsKey(exd.parentClassId)) {
                collectedClasses[exd.parentClassId] = _ClassCollectionResult();
              }
              collectedClasses[exd.parentClassId]!
                  .executableDeclarations
                  .add(exd);
            }
            for (final fd in collector.fieldDeclarations) {
              if (skippedClasses.contains(fd.parentClassId)) {
                continue;
              }
              if (!collectedClasses.containsKey(fd.parentClassId)) {
                collectedClasses[fd.parentClassId] = _ClassCollectionResult();
              }
              collectedClasses[fd.parentClassId]!.fieldDeclarations.add(fd);
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
            final relativeUri =
                _getRelativeUriFromLibraryIdentifier(fileRef.uri);
            final referencedFilePath = path
                .normalize(path.join(path.dirname(fileToAnalyze), relativeUri));
            if (!analyzedFiles.contains(referencedFilePath) &&
                !filesToAnalyze.contains(referencedFilePath)) {
              filesToAnalyze.add(referencedFilePath);
            }
          }
        }
      } on StateError catch (e) {
        print('Problem parsing $fileToAnalyze: $e');
      }
    }

    final projectClassDeclarations =
        List<ClassDeclaration>.empty(growable: true);
    final projectExecutableDeclarations =
        List<ExecutableDeclaration>.empty(growable: true);
    final projectFieldDeclarations =
        List<FieldDeclaration>.empty(growable: true);

    // aggregate class declrations
    for (final classId in collectedClasses.keys) {
      final entry = collectedClasses[classId]!;
      if (entry.classDeclarations.isEmpty) {
        projectExecutableDeclarations.addAll(
            entry.executableDeclarations.map((e) => e.executableDeclaration));
        projectFieldDeclarations
            .addAll(entry.fieldDeclarations.map((e) => e.fieldDeclaration));
      } else {
        assert(entry.classDeclarations.length == 1,
            'We found multiple classes sharing the same classId!');
        final cd = entry.classDeclarations.first;
        projectClassDeclarations.add(
          cd.classDeclaration.copyWith(
            executableDeclarations: [
              ...cd.classDeclaration.executableDeclarations,
              ...entry.executableDeclarations
                  .map((e) => e.executableDeclaration),
            ],
            fieldDeclarations: [
              ...cd.classDeclaration.fieldDeclarations,
              ...entry.fieldDeclarations.map((e) => e.fieldDeclaration),
            ],
          ),
        );
      }
    }
    final normalizedProjectPath = path.normalize(path.absolute(projectPath));
    return ProjectApi(
      projectName: _getProjectNameFromPath(normalizedProjectPath),
      projectPath: normalizedProjectPath,
      classDeclarations: projectClassDeclarations,
      executableDeclarations: projectExecutableDeclarations,
      fieldDeclarations: projectFieldDeclarations,
    );
  }

  String _getNormalizedAbsolutePath(String pathToNormalize) {
    return path.normalize(path.absolute(pathToNormalize));
  }

  Iterable<String> _findPublicFilesInProject(String normalizedAbsolutePath) {
    return Directory(normalizedAbsolutePath)
        .listSync(recursive: false)
        .where((file) => path.extension(file.path) == '.dart')
        .map((file) => path.normalize(path.absolute(file.path)));
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
        getPackageNameFromLibraryIdentifier(originLibrary.identifier);
    final refPackageName =
        getPackageNameFromLibraryIdentifier(refLibrary.identifier);

    return origPackageName == refPackageName;
  }

  String _getProjectNameFromPath(String normalizedProjectPath) {
    return path.basename(normalizedProjectPath);
  }
}

class _ClassCollectionResult {
  final classDeclarations =
      List<InternalClassDeclaration>.empty(growable: true);
  final executableDeclarations =
      List<InternalExecutableDeclaration>.empty(growable: true);
  final fieldDeclarations =
      List<InternalFieldDeclaration>.empty(growable: true);
}
