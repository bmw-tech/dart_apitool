// ignore_for_file: avoid_print

import 'dart:collection';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/file_system.dart' hide File;
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_apitool/api_tool.dart';
import 'package:dart_apitool/src/analyze/api_relevant_elements_collector.dart';
import 'package:dart_apitool/src/analyze/exported_files_collector.dart';
import 'package:dart_apitool/src/model/internal/internal_declaration.dart';
import 'package:dart_apitool/src/model/internal/internal_type_alias_declaration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:path/path.dart' as path;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import '../model/internal/internal_interface_declaration.dart';
import '../model/internal/internal_executable_declaration.dart';
import '../model/internal/internal_field_declaration.dart';
import '../model/package_api_semantics.dart';
import '../utils/string_utils.dart';
import 'constraints/android_platform_constraints_helper.dart';
import 'constraints/ios_platform_contraints_helper.dart';

part 'package_api_analyzer.freezed.dart';

/// this class analyzes the public package API of a given package ([packagePath])
class PackageApiAnalyzer {
  /// path to the package to analyze
  final String packagePath;
  final bool doMergeBaseClasses;
  final bool doAnalyzePlatformConstraints;

  /// the semantics of package API models this analyzer produces.
  /// this set defines what packages can be compared with each other and is the result of the combination of parameters this analyzer was constructed with.
  final semantics = <PackageApiSemantics>{};

  /// constructor
  /// [doMergeBaseClasses] defines if base classes should be merged into derived ones. This allows to remove private base classes from the list of class declarations.
  /// [doAnalyzePlatformConstraints] defines if the platform constraints of the package shall be analyzed.
  PackageApiAnalyzer({
    required this.packagePath,
    this.doMergeBaseClasses = true,
    this.doAnalyzePlatformConstraints = true,
  }) {
    if (doMergeBaseClasses) {
      semantics.add(PackageApiSemantics.mergeBaseClasses);
    }
    if (doAnalyzePlatformConstraints) {
      semantics.add(PackageApiSemantics.containsPlatformConstraints);
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

    final collectedInterfaces = <int?, _InterfaceCollectionResult>{};

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
            final skippedInterfaces = <int>[];
            for (final cd in collector.interfaceDeclarations) {
              if (!collectedInterfaces.containsKey(cd.id)) {
                collectedInterfaces[cd.id] = _InterfaceCollectionResult();
              }
              if (!collectedInterfaces[cd.id]!
                  .interfaceDeclarations
                  .any((cdToCheck) => cdToCheck.id == cd.id)) {
                collectedInterfaces[cd.id]!.interfaceDeclarations.add(cd);
              } else {
                skippedInterfaces.add(cd.id);
              }

              // set entry point
              _addEntryPoints<InternalInterfaceDeclaration>(
                collectedInterfaces[cd.id]!.interfaceDeclarations,
                cd.id,
                {
                  if (_isPublicEntryPoint(relativeFilePath)) relativeFilePath,
                  ...fileToAnalyze.exportedBy
                },
              );
            }
            for (final exd in collector.executableDeclarations) {
              if (skippedInterfaces.contains(exd.parentClassId)) {
                continue;
              }
              if (!collectedInterfaces.containsKey(exd.parentClassId)) {
                collectedInterfaces[exd.parentClassId] =
                    _InterfaceCollectionResult();
              }
              final exdAlreadyExists = collectedInterfaces[exd.parentClassId]!
                  .executableDeclarations
                  .any((element) => element.id == exd.id);
              if (!exdAlreadyExists) {
                collectedInterfaces[exd.parentClassId]!
                    .executableDeclarations
                    .add(exd);
              }
              if (exd.parentClassId == null) {
                //we only store the entry point on root elements
                _addEntryPoints<InternalExecutableDeclaration>(
                  collectedInterfaces[exd.parentClassId]!
                      .executableDeclarations,
                  exd.id,
                  {
                    if (_isPublicEntryPoint(relativeFilePath)) relativeFilePath,
                    ...fileToAnalyze.exportedBy
                  },
                );
              }
            }
            for (final fd in collector.fieldDeclarations) {
              if (skippedInterfaces.contains(fd.parentClassId)) {
                continue;
              }
              if (!collectedInterfaces.containsKey(fd.parentClassId)) {
                collectedInterfaces[fd.parentClassId] =
                    _InterfaceCollectionResult();
              }
              final fdAlreadyExists = collectedInterfaces[fd.parentClassId]!
                  .fieldDeclarations
                  .any((element) => element.id == fd.id);
              if (!fdAlreadyExists) {
                collectedInterfaces[fd.parentClassId]!
                    .fieldDeclarations
                    .add(fd);
              }
              if (fd.parentClassId == null) {
                //we only store the entry point on root elements
                _addEntryPoints<InternalFieldDeclaration>(
                  collectedInterfaces[fd.parentClassId]!.fieldDeclarations,
                  fd.id,
                  {
                    if (_isPublicEntryPoint(relativeFilePath)) relativeFilePath,
                    ...fileToAnalyze.exportedBy
                  },
                );
              }
            }
            for (final tad in collector.typeAliasDeclarations) {
              if (skippedInterfaces.contains(tad.parentClassId)) {
                continue;
              }
              if (!collectedInterfaces.containsKey(tad.parentClassId)) {
                collectedInterfaces[tad.parentClassId] =
                    _InterfaceCollectionResult();
              }
              final tadAlreadyExists = collectedInterfaces[tad.parentClassId]!
                  .typeAliasDeclarations
                  .any((element) => element.id == tad.id);
              if (!tadAlreadyExists) {
                collectedInterfaces[tad.parentClassId]!
                    .typeAliasDeclarations
                    .add(tad);
              }
              if (tad.parentClassId == null) {
                //we only store the entry point on root elements
                _addEntryPoints<InternalTypeAliasDeclaration>(
                  collectedInterfaces[tad.parentClassId]!.typeAliasDeclarations,
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

    final packageInterfaceDeclarations =
        List<InterfaceDeclaration>.empty(growable: true);
    final packageExecutableDeclarations =
        List<ExecutableDeclaration>.empty(growable: true);
    final packageFieldDeclarations =
        List<FieldDeclaration>.empty(growable: true);
    final packageTypeAliasDeclarations =
        List<TypeAliasDeclaration>.empty(growable: true);

    if (!collectedInterfaces.containsKey(null)) {
      collectedInterfaces[null] = _InterfaceCollectionResult();
    }

    // aggregate interface declarations
    for (final interfaceId in collectedInterfaces.keys) {
      final entry = collectedInterfaces[interfaceId]!;
      // for all non-root elements add the fields and executables to its class
      if (entry.interfaceDeclarations.isNotEmpty) {
        assert(entry.interfaceDeclarations.length == 1,
            'We found multiple classes sharing the same classId!');
        final cd = entry.interfaceDeclarations.single;
        cd.executableDeclarations.addAll(entry.executableDeclarations
            .map((e) => e.toExecutableDeclaration()));
        cd.fieldDeclarations
            .addAll(entry.fieldDeclarations.map((e) => e.toFieldDeclaration()));
      } else if (interfaceId != null) {
        // here we collected an element in the context of a class but the class is not available
        // in this case we print a warning and ignore them
        final executableList =
            entry.executableDeclarations.map((e) => e.name).join(', ');
        final fieldList = entry.fieldDeclarations.map((e) => e.name).join(', ');
        final typeAliasList =
            entry.typeAliasDeclarations.map((e) => e.name).join(', ');
        logWarning(
            'We encountered elements that are marked to belong to an interface but the interface is not collected!\nExecutables: $executableList\nFields: $fieldList\nTypeAliases: $typeAliasList');
      }
    }

    // remove collected elements that don't have their class collected (we merged the elements with root already)
    collectedInterfaces.removeWhere(
        (key, value) => key != null && value.interfaceDeclarations.isEmpty);

    if (doMergeBaseClasses) {
      _mergeSuperTypes(collectedInterfaces);
    }

    // extract package declarations
    for (final classId in collectedInterfaces.keys) {
      final entry = collectedInterfaces[classId]!;
      if (entry.interfaceDeclarations.isEmpty) {
        packageExecutableDeclarations.addAll(entry.executableDeclarations
            .map((e) => e.toExecutableDeclaration()));
        packageFieldDeclarations
            .addAll(entry.fieldDeclarations.map((e) => e.toFieldDeclaration()));
        packageTypeAliasDeclarations.addAll(
            entry.typeAliasDeclarations.map((e) => e.toTypeAliasDeclaration()));
      } else {
        assert(entry.interfaceDeclarations.length == 1,
            'We found multiple classes sharing the same classId!');
        final cd = entry.interfaceDeclarations.single;
        packageInterfaceDeclarations.add(cd.toInterfaceDeclaration());
      }
    }

    final normalizedProjectPath = path.normalize(path.absolute(packagePath));
    final androidPlatformConstraints = doAnalyzePlatformConstraints
        ? await AndroidPlatformConstraintsHelper.getAndroidPlatformConstraints(
            packagePath: normalizedProjectPath,
          )
        : null;
    final iosPlatformConstraints = doAnalyzePlatformConstraints
        ? await IOSPlatformConstraintsHelper.getIOSPlatformConstraints(
            packagePath: normalizedProjectPath,
          )
        : null;

    final sdkVersion = pubSpec.environment?['sdk'];
    Version? minSdkVersion;
    if (sdkVersion is VersionRange) {
      minSdkVersion = sdkVersion.min;
    } else if (sdkVersion is Version) {
      minSdkVersion = sdkVersion;
    }
    final isFlutter = pubSpec.dependencies.containsKey('flutter');

    return PackageApi(
      packageName: pubSpec.name,
      packageVersion: pubSpec.version?.toString(),
      packagePath: normalizedProjectPath,
      interfaceDeclarations: packageInterfaceDeclarations,
      executableDeclarations: packageExecutableDeclarations,
      fieldDeclarations: packageFieldDeclarations,
      typeAliasDeclarations: packageTypeAliasDeclarations,
      semantics: semantics,
      androidPlatformConstraints: androidPlatformConstraints,
      iosPlatformConstraints: iosPlatformConstraints,
      sdkType: isFlutter ? SdkType.flutter : SdkType.dart,
      minSdkVersion: minSdkVersion ?? Version.none,
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

  void _mergeSuperTypes(
      Map<int?, _InterfaceCollectionResult> collectedInterfaces) {
    final mergedSuperTypeIds = <int>{};
    // we merge all super class elements into the derived classes
    for (final interfaceId in collectedInterfaces.keys) {
      // no class info available for root elements
      if (interfaceId == null) {
        continue;
      }
      final entry = collectedInterfaces[interfaceId]!;
      final interfaceDeclaration = entry.interfaceDeclarations.single;
      mergedSuperTypeIds.addAll(_mergeSuperTypesInto(collectedInterfaces,
          interfaceDeclaration.superClassIds, interfaceDeclaration));
    }
    // now we remove all private classes that got merged into their derived classes
    for (final mergedSuperTypeId in mergedSuperTypeIds) {
      final entry = collectedInterfaces[mergedSuperTypeId]!;
      final interfaceDeclaration = entry.interfaceDeclarations.single;
      if (interfaceDeclaration.isPrivate) {
        collectedInterfaces.remove(mergedSuperTypeId);
      }
    }
  }

  List<int> _mergeSuperTypesInto(
      Map<int?, _InterfaceCollectionResult> collectedInterfaces,
      List<int> superTypeIds,
      InternalInterfaceDeclaration target,
      {bool isTransitive = false}) {
    final mergedSuperTypeIds = List<int>.empty(growable: true);
    for (final superClassId in superTypeIds) {
      final superClassEntry = collectedInterfaces[superClassId];
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

      final superInterfaceDeclaration =
          superClassEntry.interfaceDeclarations.single;

      // now merge all executable and field declarations into the merge target.
      // constructors don't get merged
      target.executableDeclarations.addAll(superInterfaceDeclaration
          .executableDeclarations
          .where((element) => element.type != ExecutableType.constructor)
          // only executables that are not already declared in the target class get merged
          .where((element) => !target.executableDeclarations
              .any((targetElement) => targetElement.name == element.name)));
      target.fieldDeclarations.addAll(superInterfaceDeclaration
          .fieldDeclarations
          // only fields that are not already declared in the target class get merged
          .where((element) => !target.fieldDeclarations
              .any((targetElement) => targetElement.name == element.name)));

      // for all super types this type has we also merge
      mergedSuperTypeIds.addAll(_mergeSuperTypesInto(
          collectedInterfaces, superInterfaceDeclaration.superClassIds, target,
          isTransitive: true));
    }
    return mergedSuperTypeIds;
  }
}

class _InterfaceCollectionResult {
  final interfaceDeclarations =
      List<InternalInterfaceDeclaration>.empty(growable: true);
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
