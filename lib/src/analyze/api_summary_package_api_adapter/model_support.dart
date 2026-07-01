part of '../api_summary_package_api_adapter.dart';

final class _AdaptedApiSummary {
  final List<InterfaceDeclaration> interfaceDeclarations;
  final List<ExecutableDeclaration> executableDeclarations;
  final List<FieldDeclaration> fieldDeclarations;
  final List<TypeAliasDeclaration> typeAliasDeclarations;
  final TypeHierarchy typeHierarchy;

  const _AdaptedApiSummary({
    required this.interfaceDeclarations,
    required this.executableDeclarations,
    required this.fieldDeclarations,
    required this.typeAliasDeclarations,
    required this.typeHierarchy,
  });
}

final class _DeclarationKey {
  final String name;
  final String libraryUri;

  const _DeclarationKey({required this.name, required this.libraryUri});

  @override
  bool operator ==(Object other) {
    return other is _DeclarationKey &&
        other.name == name &&
        other.libraryUri == libraryUri;
  }

  @override
  int get hashCode => Object.hash(name, libraryUri);
}

final class _InterfaceDraft {
  final String name;
  final bool isDeprecated;
  final bool isExperimental;
  final bool isSealed;
  final bool isAbstract;
  final List<String> typeParameterNames;
  final Set<String> superTypeNames;
  final List<ExecutableDeclaration> executableDeclarations;
  final List<FieldDeclaration> fieldDeclarations;
  final Set<String> entryPoints;
  final String relativePath;
  final String libraryUri;
  final List<_SourceExecutableData> sourceExecutables;
  final List<api_summary.ApiType> baseTypes;
  final api_summary.ApiType? superClassType;
  final List<api_summary.ApiType> mixedInTypes;
  final api_summary.ApiType? extraHierarchyType;

  const _InterfaceDraft({
    required this.name,
    required this.isDeprecated,
    required this.isExperimental,
    required this.isSealed,
    required this.isAbstract,
    required this.typeParameterNames,
    required this.superTypeNames,
    required this.executableDeclarations,
    required this.fieldDeclarations,
    required this.entryPoints,
    required this.relativePath,
    required this.libraryUri,
    required this.sourceExecutables,
    required this.baseTypes,
    this.superClassType,
    this.mixedInTypes = const [],
    this.extraHierarchyType,
  });

  InterfaceDeclaration toInterfaceDeclaration(Set<TypeUsage> typeUsages) {
    return InterfaceDeclaration(
      name: name,
      isDeprecated: isDeprecated,
      isExperimental: isExperimental,
      isSealed: isSealed,
      isAbstract: isAbstract,
      typeUsages: typeUsages,
      typeParameterNames: typeParameterNames,
      superTypeNames: superTypeNames,
      executableDeclarations: executableDeclarations,
      fieldDeclarations: fieldDeclarations,
      entryPoints: entryPoints,
      relativePath: relativePath,
    );
  }

  _InterfaceDraft flattenMixedInMembersFrom(_InterfaceDraft mixinDraft) {
    final executableNames = executableDeclarations
        .map((declaration) => declaration.name)
        .toSet();
    final fieldNames = fieldDeclarations
        .map((declaration) => declaration.name)
        .toSet();
    final sourceExecutableKeys = sourceExecutables
        .map(
          (declaration) =>
              '${declaration.declaration.kind.name}:${declaration.declaration.name}',
        )
        .toSet();

    final inheritedExecutables = mixinDraft.executableDeclarations
        .where((declaration) => declaration.type != ExecutableType.constructor)
        .where((declaration) => !executableNames.contains(declaration.name))
        .map(
          (declaration) => declaration.copyWith(
            entryPoints: entryPoints,
            relativePath: relativePath,
          ),
        )
        .toList();
    final inheritedFields = mixinDraft.fieldDeclarations
        .where((declaration) => !fieldNames.contains(declaration.name))
        .map(
          (declaration) => declaration.copyWith(
            entryPoints: entryPoints,
            relativePath: relativePath,
          ),
        )
        .toList();
    final inheritedSourceExecutables = mixinDraft.sourceExecutables
        .where(
          (declaration) =>
              declaration.declaration.kind !=
              api_summary.ApiExecutableKind.constructor,
        )
        .where(
          (declaration) => !sourceExecutableKeys.contains(
            '${declaration.declaration.kind.name}:${declaration.declaration.name}',
          ),
        )
        .toList();

    if (inheritedExecutables.isEmpty &&
        inheritedFields.isEmpty &&
        inheritedSourceExecutables.isEmpty) {
      return this;
    }

    return _InterfaceDraft(
      name: name,
      isDeprecated: isDeprecated,
      isExperimental: isExperimental,
      isSealed: isSealed,
      isAbstract: isAbstract,
      typeParameterNames: typeParameterNames,
      superTypeNames: superTypeNames,
      executableDeclarations: [
        ...executableDeclarations,
        ...inheritedExecutables,
      ],
      fieldDeclarations: [...fieldDeclarations, ...inheritedFields],
      entryPoints: entryPoints,
      relativePath: relativePath,
      libraryUri: libraryUri,
      sourceExecutables: [...sourceExecutables, ...inheritedSourceExecutables],
      baseTypes: baseTypes,
      superClassType: superClassType,
      mixedInTypes: mixedInTypes,
      extraHierarchyType: extraHierarchyType,
    );
  }

  _InterfaceDraft mergeWith(_InterfaceDraft other) {
    return _InterfaceDraft(
      name: name,
      isDeprecated: isDeprecated || other.isDeprecated,
      isExperimental: isExperimental || other.isExperimental,
      isSealed: isSealed || other.isSealed,
      isAbstract: isAbstract || other.isAbstract,
      typeParameterNames: typeParameterNames,
      superTypeNames: {...superTypeNames, ...other.superTypeNames},
      executableDeclarations: executableDeclarations,
      fieldDeclarations: fieldDeclarations,
      entryPoints: {...entryPoints, ...other.entryPoints},
      relativePath: relativePath,
      libraryUri: libraryUri,
      sourceExecutables: sourceExecutables,
      baseTypes: baseTypes,
      superClassType: superClassType ?? other.superClassType,
      mixedInTypes: [...mixedInTypes, ...other.mixedInTypes],
      extraHierarchyType: extraHierarchyType ?? other.extraHierarchyType,
    );
  }

  _InterfaceDraft withEntryPoints(Set<String> updatedEntryPoints) {
    return _InterfaceDraft(
      name: name,
      isDeprecated: isDeprecated,
      isExperimental: isExperimental,
      isSealed: isSealed,
      isAbstract: isAbstract,
      typeParameterNames: typeParameterNames,
      superTypeNames: superTypeNames,
      executableDeclarations: executableDeclarations,
      fieldDeclarations: fieldDeclarations,
      entryPoints: updatedEntryPoints,
      relativePath: relativePath,
      libraryUri: libraryUri,
      sourceExecutables: sourceExecutables,
      baseTypes: baseTypes,
      superClassType: superClassType,
      mixedInTypes: mixedInTypes,
      extraHierarchyType: extraHierarchyType,
    );
  }
}

final class _SourceExecutableData {
  final api_summary.ApiExecutable declaration;
  final String referringElementName;
  final bool isVisibleForTesting;

  const _SourceExecutableData({
    required this.declaration,
    required this.referringElementName,
    required this.isVisibleForTesting,
  });
}

final class _FieldAccumulator {
  final String name;
  final String relativePath;
  final Set<String> entryPoints;

  String typeName = 'dynamic';
  String? typeFullLibraryName;
  bool isDeprecated = false;
  bool isExperimental = false;
  bool isStatic = false;
  bool isConst = false;
  bool isReadable = false;
  bool isWriteable = false;

  _FieldAccumulator({
    required this.name,
    required this.relativePath,
    required this.entryPoints,
  });

  void addExecutable(api_summary.ApiExecutable executable) {
    isDeprecated = isDeprecated || executable.isDeprecated;
    isExperimental = isExperimental || executable.isExperimental;
    isStatic = isStatic || executable.isStatic;
    isConst = isConst || executable.isConst;

    switch (executable.kind) {
      case api_summary.ApiExecutableKind.getter:
        isReadable = true;
        typeName = _renderType(executable.returnType);
        typeFullLibraryName = _libraryUriFromType(executable.returnType);
      case api_summary.ApiExecutableKind.setter:
        isWriteable = true;
        if (executable.parameters.isNotEmpty) {
          typeName = _renderType(executable.parameters.first.type);
          typeFullLibraryName = _libraryUriFromType(
            executable.parameters.first.type,
          );
        }
      default:
        break;
    }
  }

  FieldDeclaration build() {
    return FieldDeclaration(
      typeName: typeName,
      typeFullLibraryName: typeFullLibraryName,
      name: name,
      isDeprecated: isDeprecated,
      isStatic: isStatic,
      isConst: isConst,
      isExperimental: isExperimental,
      entryPoints: entryPoints,
      relativePath: relativePath,
      isReadable: isReadable,
      isWriteable: isWriteable,
    );
  }
}
