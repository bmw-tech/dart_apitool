// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/file_system.dart' hide File;
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_apitool/src/analyze/api_relevant_elements_collector.dart';
import 'package:dart_apitool/src/analyze/exported_files_collector.dart';
import 'package:dart_apitool/src/model/internal/internal_declaration.dart';
import 'package:dart_apitool/src/model/internal/internal_type_alias_declaration.dart';
import 'package:dart_apitool/src/model/type_alias_declaration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_parse/pubspec_parse.dart';

import '../model/class_declaration.dart';
import '../model/executable_declaration.dart';
import '../model/field_declaration.dart';
import '../model/internal/internal_class_declaration.dart';
import '../model/internal/internal_executable_declaration.dart';
import '../model/internal/internal_field_declaration.dart';
import '../model/package_api.dart';
import '../model/package_api_semantics.dart';
import '../utils/string_utils.dart';

part 'package_api_analyzer.freezed.dart';

/// this class analyzes the public package API of a given package ([packagePath])
class PackageApiAnalyzer {
  /// path to the package to analyze
  final String packagePath;
  final bool mergeBaseClasses;

  /// the semantics of package API models this analyzer produces.
  /// this set defines what packages can be compared with each other and is the result of the combination of parameters this analyzer was constructed with.
  final semantics = <PackageApiSemantics>{};

  /// constructor
  PackageApiAnalyzer({
    required this.packagePath,
    this.mergeBaseClasses = true,
  }) {
    if (mergeBaseClasses) {
      semantics.add(PackageApiSemantics.mergeBaseClasses);
    }
    _checkProjectPathValidity();
  }

  bool _isPublicEntryPoint(String relativeFilePath) {
    return !relativeFilePath.startsWith('src');
  }

  /// analyzes the configured package and returns a model of its public API
  Future<PackageApi> analyze() async {
    final normalizedAbsoluteProjectPath =
        _getNormalizedAbsolutePath(packagePath);

    final yamlContent =
        await File(path.join(normalizedAbsoluteProjectPath, 'pubspec.yaml'))
            .readAsString();
    final pubSpec = Pubspec.parse(yamlContent);

    final resourceProvider = PhysicalResourceProvider.INSTANCE;

    final normalizedAbsolutePublicEntrypointPath = _getNormalizedAbsolutePath(
        path.join(normalizedAbsoluteProjectPath, 'lib'));

    final contextCollection = _createAnalysisContextCollection(
      path: normalizedAbsoluteProjectPath,
      resourceProvider: resourceProvider,
    );

    final collectedClasses = <int?, _ClassCollectionResult>{};

    final analyzedFiles = List<_FileToAnalyzeEntry>.empty(growable: true);
    final filesToAnalyze = Queue<_FileToAnalyzeEntry>();
    filesToAnalyze.addAll(
        _findPublicFilesInProject(normalizedAbsolutePublicEntrypointPath));

    while (filesToAnalyze.isNotEmpty) {
      final fileToAnalyze = filesToAnalyze.first;
      filesToAnalyze.removeFirst();
      analyzedFiles.add(fileToAnalyze);

      final relativeFilePath = path.relative(fileToAnalyze.filePath,
          from: normalizedAbsolutePublicEntrypointPath);

      try {
        final context = contextCollection.contextFor(fileToAnalyze.filePath);

        final unitResult = await context.currentSession
            .getResolvedUnit(fileToAnalyze.filePath);
        if (unitResult is ResolvedUnitResult) {
          if (!unitResult.isPart) {
            final collector = APIRelevantElementsCollector(
              shownNames: fileToAnalyze.shownNames,
              hiddenNames: fileToAnalyze.hiddenNames,
            );
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

              // set entry point
              _addEntryPoints<InternalClassDeclaration>(
                collectedClasses[cd.id]!.classDeclarations,
                cd.id,
                {
                  if (_isPublicEntryPoint(relativeFilePath)) relativeFilePath,
                  ...fileToAnalyze.exportedBy
                },
              );
            }
            for (final exd in collector.executableDeclarations) {
              if (skippedClasses.contains(exd.parentClassId)) {
                continue;
              }
              if (!collectedClasses.containsKey(exd.parentClassId)) {
                collectedClasses[exd.parentClassId] = _ClassCollectionResult();
              }
              final exdAlreadyExists = collectedClasses[exd.parentClassId]!
                  .executableDeclarations
                  .any((element) => element.id == exd.id);
              if (!exdAlreadyExists) {
                collectedClasses[exd.parentClassId]!
                    .executableDeclarations
                    .add(exd);
              }
              if (exd.parentClassId == null) {
                //we only store the entry point on root elements
                _addEntryPoints<InternalExecutableDeclaration>(
                  collectedClasses[exd.parentClassId]!.executableDeclarations,
                  exd.id,
                  {
                    if (_isPublicEntryPoint(relativeFilePath)) relativeFilePath,
                    ...fileToAnalyze.exportedBy
                  },
                );
              }
            }
            for (final fd in collector.fieldDeclarations) {
              if (skippedClasses.contains(fd.parentClassId)) {
                continue;
              }
              if (!collectedClasses.containsKey(fd.parentClassId)) {
                collectedClasses[fd.parentClassId] = _ClassCollectionResult();
              }
              final fdAlreadyExists = collectedClasses[fd.parentClassId]!
                  .fieldDeclarations
                  .any((element) => element.id == fd.id);
              if (!fdAlreadyExists) {
                collectedClasses[fd.parentClassId]!.fieldDeclarations.add(fd);
              }
              if (fd.parentClassId == null) {
                //we only store the entry point on root elements
                _addEntryPoints<InternalFieldDeclaration>(
                  collectedClasses[fd.parentClassId]!.fieldDeclarations,
                  fd.id,
                  {
                    if (_isPublicEntryPoint(relativeFilePath)) relativeFilePath,
                    ...fileToAnalyze.exportedBy
                  },
                );
              }
            }
            for (final tad in collector.typeAliasDeclarations) {
              if (skippedClasses.contains(tad.parentClassId)) {
                continue;
              }
              if (!collectedClasses.containsKey(tad.parentClassId)) {
                collectedClasses[tad.parentClassId] = _ClassCollectionResult();
              }
              final tadAlreadyExists = collectedClasses[tad.parentClassId]!
                  .typeAliasDeclarations
                  .any((element) => element.id == tad.id);
              if (!tadAlreadyExists) {
                collectedClasses[tad.parentClassId]!
                    .typeAliasDeclarations
                    .add(tad);
              }
              if (tad.parentClassId == null) {
                //we only store the entry point on root elements
                _addEntryPoints<InternalTypeAliasDeclaration>(
                  collectedClasses[tad.parentClassId]!.typeAliasDeclarations,
                  tad.id,
                  {
                    if (_isPublicEntryPoint(relativeFilePath)) relativeFilePath,
                    ...fileToAnalyze.exportedBy
                  },
                );
              }
            }
          }

          final referencedFilesCollector = ExportedFilesCollector();
          unitResult.libraryElement.accept(referencedFilesCollector);
          for (final fileRef in referencedFilesCollector.fileReferences) {
            if (!_isInternalRef(
                originLibrary: fileRef.originLibrary,
                refLibrary: fileRef.referencedLibrary)) {
              continue;
            }
            final relativeUri =
                _getRelativeUriFromLibraryIdentifier(fileRef.uri);
            final referencedFilePath = path.normalize(
                path.join(path.dirname(fileToAnalyze.filePath), relativeUri));
            final analyzeEntry = _FileToAnalyzeEntry(
              filePath: referencedFilePath,
              shownNames: fileRef.shownNames,
              hiddenNames: fileRef.hiddenNames,
              exportedBy: {
                ...fileToAnalyze.exportedBy,
                if (_isPublicEntryPoint(relativeFilePath)) relativeFilePath,
              },
            );
            if (!analyzedFiles.contains(analyzeEntry) &&
                !filesToAnalyze.contains(analyzeEntry)) {
              filesToAnalyze.add(analyzeEntry);
            }
          }
        }
      } on StateError catch (e) {
        logError('Problem parsing $fileToAnalyze: $e');
      }
    }

    final packageClassDeclarations =
        List<ClassDeclaration>.empty(growable: true);
    final packageExecutableDeclarations =
        List<ExecutableDeclaration>.empty(growable: true);
    final packageFieldDeclarations =
        List<FieldDeclaration>.empty(growable: true);
    final packageTypeAliasDeclarations =
        List<TypeAliasDeclaration>.empty(growable: true);

    if (!collectedClasses.containsKey(null)) {
      collectedClasses[null] = _ClassCollectionResult();
    }

    // aggregate class declarations
    for (final classId in collectedClasses.keys) {
      final entry = collectedClasses[classId]!;
      // for all non-root elements add the fields and executables to its class
      if (entry.classDeclarations.isNotEmpty) {
        assert(entry.classDeclarations.length == 1,
            'We found multiple classes sharing the same classId!');
        final cd = entry.classDeclarations.single;
        cd.executableDeclarations.addAll(entry.executableDeclarations
            .map((e) => e.toExecutableDeclaration()));
        cd.fieldDeclarations
            .addAll(entry.fieldDeclarations.map((e) => e.toFieldDeclaration()));
      } else if (classId != null) {
        // here we collected an element in the context of a class but the class is not available
        // in this case we add the elements to the root level and print a warning
        logWarning(
            'We encountered elements that are marked to belong to a class but the class is not collected!');
        collectedClasses[null]!
            .executableDeclarations
            .addAll(entry.executableDeclarations);
        collectedClasses[null]!
            .fieldDeclarations
            .addAll(entry.fieldDeclarations);
        collectedClasses[null]!
            .typeAliasDeclarations
            .addAll(entry.typeAliasDeclarations);
      }
    }

    // remove collected elements that don't have their class collected (we merged the elements with root already)
    collectedClasses.removeWhere(
        (key, value) => key != null && value.classDeclarations.isEmpty);

    if (mergeBaseClasses) {
      _mergeSuperTypes(collectedClasses);
    }

    // extract package declarations
    for (final classId in collectedClasses.keys) {
      final entry = collectedClasses[classId]!;
      if (entry.classDeclarations.isEmpty) {
        packageExecutableDeclarations.addAll(entry.executableDeclarations
            .map((e) => e.toExecutableDeclaration()));
        packageFieldDeclarations
            .addAll(entry.fieldDeclarations.map((e) => e.toFieldDeclaration()));
        packageTypeAliasDeclarations.addAll(
            entry.typeAliasDeclarations.map((e) => e.toTypeAliasDeclaration()));
      } else {
        assert(entry.classDeclarations.length == 1,
            'We found multiple classes sharing the same classId!');
        final cd = entry.classDeclarations.single;
        packageClassDeclarations.add(cd.toClassDeclaration());
      }
    }

    final normalizedProjectPath = path.normalize(path.absolute(packagePath));
    return PackageApi(
      packageName: pubSpec.name,
      packageVersion: pubSpec.version?.toString(),
      packagePath: normalizedProjectPath,
      classDeclarations: packageClassDeclarations,
      executableDeclarations: packageExecutableDeclarations,
      fieldDeclarations: packageFieldDeclarations,
      typeAliasDeclarations: packageTypeAliasDeclarations,
      semantics: semantics,
    );
  }

  void _addEntryPoints<TDec extends InternalDeclaration>(
      List<TDec> collectedDeclarations,
      int elementId,
      Set<String> entryPointsToAdd) {
    final existingEntry =
        collectedDeclarations.singleWhere((element) => element.id == elementId);
    existingEntry.entryPoints?.addAll(entryPointsToAdd);
  }

  String _getNormalizedAbsolutePath(String pathToNormalize) {
    return path.normalize(path.absolute(pathToNormalize));
  }

  Iterable<_FileToAnalyzeEntry> _findPublicFilesInProject(
      String normalizedAbsolutePath) {
    return Directory(normalizedAbsolutePath)
        .listSync(recursive: false)
        .where((file) => path.extension(file.path) == '.dart')
        .map((file) => _FileToAnalyzeEntry(
              filePath: path.normalize(path.absolute(file.path)),
              exportedBy: {},
            ));
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
    final origPackageName = getPackageNameFromLibrary(originLibrary);
    final refPackageName = getPackageNameFromLibrary(refLibrary);

    return origPackageName == refPackageName;
  }

  void _checkProjectPathValidity() {
    final absoluteNormalizedPackagePath =
        path.normalize(path.absolute(packagePath));
    assert(Directory(absoluteNormalizedPackagePath).existsSync(),
        'Given package path doesn\'t exist ($absoluteNormalizedPackagePath)');
    final pubspecPath =
        path.join(absoluteNormalizedPackagePath, 'pubspec.yaml');
    assert(File(pubspecPath).existsSync(),
        'Given package path doesn\'t contain a pubspec.yaml ($absoluteNormalizedPackagePath)');
  }

  void _mergeSuperTypes(Map<int?, _ClassCollectionResult> collectedClasses) {
    final mergedSuperTypeIds = <int>{};
    // we merge all super class elements into the derived classes
    for (final classId in collectedClasses.keys) {
      // no class info available for root elements
      if (classId == null) {
        continue;
      }
      final entry = collectedClasses[classId]!;
      final classDeclaration = entry.classDeclarations.single;
      mergedSuperTypeIds.addAll(_mergeSuperTypesInto(
          collectedClasses, classDeclaration.superClassIds, classDeclaration));
    }
    // now we remove all private classes that got merged into their derived classes
    for (final mergedSuperTypeId in mergedSuperTypeIds) {
      final entry = collectedClasses[mergedSuperTypeId]!;
      final classDeclaration = entry.classDeclarations.single;
      if (classDeclaration.isPrivate) {
        collectedClasses.remove(mergedSuperTypeId);
      }
    }
  }

  List<int> _mergeSuperTypesInto(
      Map<int?, _ClassCollectionResult> collectedClasses,
      List<int> superTypeIds,
      InternalClassDeclaration target,
      {bool isTransitive = false}) {
    final mergedSuperTypeIds = List<int>.empty(growable: true);
    for (final superClassId in superTypeIds) {
      final superClassEntry = collectedClasses[superClassId];
      if (superClassEntry == null) {
        continue;
      }

      // if we are in a transitive merge, we only merge super types that are not merged already.
      // this check can only be done if we are in a transitive merge because the direct merge will contain entries of all direct super types in the superClassIds list.
      if (isTransitive && target.superClassIds.contains(superClassId)) {
        continue;
      }
      // mark the super type as merged
      if (!target.superClassIds.contains(superClassId)) {
        target.superClassIds.add(superClassId);
      }

      mergedSuperTypeIds.add(superClassId);

      final superClassDeclaration = superClassEntry.classDeclarations.single;

      // now merge all executable and field declarations into the merge target.
      // constructors don't get merged
      target.executableDeclarations.addAll(superClassDeclaration
          .executableDeclarations
          .where((element) => element.type != ExecutableType.constructor)
          // only executables that are not already declared in the target class get merged
          .where((element) => !target.executableDeclarations
              .any((targetElement) => targetElement.name == element.name)));
      target.fieldDeclarations.addAll(superClassDeclaration.fieldDeclarations
          // only fields that are not already declared in the target class get merged
          .where((element) => !target.fieldDeclarations
              .any((targetElement) => targetElement.name == element.name)));

      // for all super types this type has we also merge
      mergedSuperTypeIds.addAll(_mergeSuperTypesInto(
          collectedClasses, superClassDeclaration.superClassIds, target,
          isTransitive: true));
    }
    return mergedSuperTypeIds;
  }
}

class _ClassCollectionResult {
  final classDeclarations =
      List<InternalClassDeclaration>.empty(growable: true);
  final executableDeclarations =
      List<InternalExecutableDeclaration>.empty(growable: true);
  final fieldDeclarations =
      List<InternalFieldDeclaration>.empty(growable: true);
  final typeAliasDeclarations =
      List<InternalTypeAliasDeclaration>.empty(growable: true);
}

@freezed
class _FileToAnalyzeEntry with _$_FileToAnalyzeEntry {
  const factory _FileToAnalyzeEntry({
    required String filePath,
    @Default([]) List<String> shownNames,
    @Default([]) List<String> hiddenNames,
    required Set<String> exportedBy,
  }) = __FileToAnalyzeEntry;
}
