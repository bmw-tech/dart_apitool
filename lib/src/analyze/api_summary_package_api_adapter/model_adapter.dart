part of '../api_summary_package_api_adapter.dart';

final class _ApiSummaryModelAdapter {
  final String packageName;
  final String packagePath;
  final bool doConsiderNonSrcAsEntryPoints;
  Map<String, List<_DeclarationKey>> _localTypeAliasesByName = const {};
  Map<_DeclarationKey, api_summary.ApiType> _typeAliasTargets = const {};

  _ApiSummaryModelAdapter({
    required this.packageName,
    required this.packagePath,
    required this.doConsiderNonSrcAsEntryPoints,
  });

  _AdaptedApiSummary adapt(api_summary.ApiSummary summary) {
    final typeHierarchy = TypeHierarchy.empty();
    final interfaceDrafts = <_DeclarationKey, _InterfaceDraft>{};
    final rootExecutables = <_DeclarationKey, ExecutableDeclaration>{};
    final rootFieldAccumulators = <_DeclarationKey, _FieldAccumulator>{};
    final rootTypeAliases = <_DeclarationKey, TypeAliasDeclaration>{};
    final rootTypeAliasTargets = <_DeclarationKey, api_summary.ApiType>{};
    final hasSinglePublicEntrypoint =
        summary.libraries.where(_isConsideredEntrypointLibrary).length == 1;

    for (final library in summary.libraries) {
      for (final declaration in [
        ...library.classes,
        ...library.enums,
        ...library.mixins,
      ]) {
        final declarationLibraryUri = _declarationLibraryUri(
          declaration,
          library.uri,
        );
        final relativePath = _relativePathFromLibraryUri(declarationLibraryUri);
        final key = _DeclarationKey(
          name: declaration.name,
          libraryUri: declarationLibraryUri,
        );
        final draft = _adaptClassLikeDeclaration(
          declaration: declaration,
          relativePath: relativePath,
          libraryUri: declarationLibraryUri,
          entryPoints: _entryPointsForDeclaration(
            declaration,
            library,
            hasSinglePublicEntrypoint: hasSinglePublicEntrypoint,
          ),
          typeHierarchy: typeHierarchy,
        );
        if (declaration.status == api_summary.ApiDeclarationStatus.referenced) {
          continue;
        }
        _addInterfaceDraft(interfaceDrafts, key, draft);
      }

      for (final declaration in library.extensions) {
        final declarationLibraryUri = _declarationLibraryUri(
          declaration,
          library.uri,
        );
        final relativePath = _relativePathFromLibraryUri(declarationLibraryUri);
        final key = _DeclarationKey(
          name: declaration.name,
          libraryUri: declarationLibraryUri,
        );
        final draft = _adaptExtensionDeclaration(
          declaration: declaration,
          relativePath: relativePath,
          libraryUri: declarationLibraryUri,
          entryPoints: _entryPointsForDeclaration(
            declaration,
            library,
            hasSinglePublicEntrypoint: hasSinglePublicEntrypoint,
          ),
          typeHierarchy: typeHierarchy,
        );
        if (declaration.status == api_summary.ApiDeclarationStatus.referenced) {
          continue;
        }
        _addInterfaceDraft(interfaceDrafts, key, draft);
      }

      for (final declaration in library.extensionTypes) {
        final declarationLibraryUri = _declarationLibraryUri(
          declaration,
          library.uri,
        );
        final relativePath = _relativePathFromLibraryUri(declarationLibraryUri);
        final key = _DeclarationKey(
          name: declaration.name,
          libraryUri: declarationLibraryUri,
        );
        final draft = _adaptExtensionTypeDeclaration(
          declaration: declaration,
          relativePath: relativePath,
          libraryUri: declarationLibraryUri,
          entryPoints: _entryPointsForDeclaration(
            declaration,
            library,
            hasSinglePublicEntrypoint: hasSinglePublicEntrypoint,
          ),
          typeHierarchy: typeHierarchy,
        );
        if (declaration.status == api_summary.ApiDeclarationStatus.referenced) {
          continue;
        }
        _addInterfaceDraft(interfaceDrafts, key, draft);
      }

      for (final declaration in library.functions) {
        if (declaration.status == api_summary.ApiDeclarationStatus.referenced) {
          continue;
        }
        final declarationLibraryUri = _declarationLibraryUri(
          declaration,
          library.uri,
        );
        final relativePath = _relativePathFromLibraryUri(declarationLibraryUri);
        final key = _DeclarationKey(
          name: declaration.name,
          libraryUri: declarationLibraryUri,
        );
        final entryPoints = _entryPointsForDeclaration(
          declaration,
          library,
          hasSinglePublicEntrypoint: hasSinglePublicEntrypoint,
        );
        if (_isFieldLikeExecutable(declaration.kind)) {
          final fieldName = _fieldNameForExecutable(declaration.name);
          final fieldKey = _DeclarationKey(
            name: fieldName,
            libraryUri: declarationLibraryUri,
          );
          rootFieldAccumulators
              .putIfAbsent(
                fieldKey,
                () => _FieldAccumulator(
                  name: fieldName,
                  relativePath: relativePath,
                  entryPoints: {...entryPoints},
                ),
              )
              .addExecutable(declaration);
          rootFieldAccumulators[fieldKey]!.entryPoints.addAll(entryPoints);
          continue;
        }
        final executable = _adaptExecutableDeclaration(
          declaration: declaration,
          relativePath: relativePath,
          entryPoints: entryPoints,
        );
        rootExecutables.update(
          key,
          (existing) => _mergeExecutableDeclaration(existing, executable),
          ifAbsent: () => executable,
        );
      }

      for (final declaration in library.typeAliases) {
        if (declaration.status == api_summary.ApiDeclarationStatus.referenced) {
          continue;
        }
        final declarationLibraryUri = _declarationLibraryUri(
          declaration,
          library.uri,
        );
        final relativePath = _relativePathFromLibraryUri(declarationLibraryUri);
        final key = _DeclarationKey(
          name: declaration.name,
          libraryUri: declarationLibraryUri,
        );
        final typeAlias = TypeAliasDeclaration(
          name: declaration.name,
          aliasedTypeName: _renderType(declaration.aliasedType),
          isDeprecated: declaration.isDeprecated,
          isExperimental: declaration.isExperimental,
          entryPoints: _entryPointsForDeclaration(
            declaration,
            library,
            hasSinglePublicEntrypoint: hasSinglePublicEntrypoint,
          ),
          relativePath: relativePath,
        );
        rootTypeAliases.update(
          key,
          (existing) => _mergeTypeAliasDeclaration(existing, typeAlias),
          ifAbsent: () => typeAlias,
        );
        rootTypeAliasTargets[key] = declaration.aliasedType;
      }
    }

    final flattenedInterfaceDrafts = _flattenMixedInMembers(interfaceDrafts);

    final localDeclarationsByName = <String, List<_DeclarationKey>>{};
    for (final key in flattenedInterfaceDrafts.keys) {
      localDeclarationsByName.putIfAbsent(key.name, () => []).add(key);
    }
    _localTypeAliasesByName = <String, List<_DeclarationKey>>{};
    for (final key in rootTypeAliases.keys) {
      _localTypeAliasesByName.putIfAbsent(key.name, () => []).add(key);
    }
    _typeAliasTargets = rootTypeAliasTargets;

    // A public type alias is also a public way to reach its aliased interface.
    final interfaceDraftsWithAliasEntrypoints =
        <_DeclarationKey, _InterfaceDraft>{
          for (final entry in flattenedInterfaceDrafts.entries)
            entry.key: entry.value,
        };
    for (final typeAliasEntry in rootTypeAliases.entries.where(
      (entry) => (entry.value.entryPoints ?? const {}).isNotEmpty,
    )) {
      final aliasedType = rootTypeAliasTargets[typeAliasEntry.key];
      if (aliasedType == null) {
        continue;
      }
      final resolvedKey = _resolveDeclarationKey(
        typeName: _renderType(aliasedType),
        typeFullLibraryName: _libraryUriFromType(aliasedType),
        localDeclarationsByName: localDeclarationsByName,
        interfaceDrafts: interfaceDraftsWithAliasEntrypoints,
      );
      if (resolvedKey == null) {
        continue;
      }
      final draft = interfaceDraftsWithAliasEntrypoints[resolvedKey];
      if (draft == null) {
        continue;
      }
      interfaceDraftsWithAliasEntrypoints[resolvedKey] = draft.withEntryPoints({
        ...draft.entryPoints,
        ...?typeAliasEntry.value.entryPoints,
      });
    }

    final typeUsagesByDeclaration = <_DeclarationKey, Set<TypeUsage>>{};

    // Type usages are a dart_apitool concept, so they are reconstructed from
    // the already summarized signatures instead of asking analyzer again.
    for (final draft in interfaceDraftsWithAliasEntrypoints.values.where(
      (draft) => draft.entryPoints.isNotEmpty,
    )) {
      for (final baseType in draft.baseTypes) {
        _recordTypeUsage(
          apiType: baseType,
          localDeclarationsByName: localDeclarationsByName,
          interfaceDrafts: interfaceDraftsWithAliasEntrypoints,
          typeUsagesByDeclaration: typeUsagesByDeclaration,
          kind: TypeUsageKind.hierarchy,
          referringElementName: draft.name,
          referringLibraryUri: draft.libraryUri,
        );
      }
      for (final executable in draft.sourceExecutables) {
        _recordExecutableTypeUsages(
          declaration: executable.declaration,
          localDeclarationsByName: localDeclarationsByName,
          interfaceDrafts: interfaceDraftsWithAliasEntrypoints,
          typeUsagesByDeclaration: typeUsagesByDeclaration,
          referringElementName: executable.referringElementName,
          isVisibleForTesting: executable.isVisibleForTesting,
          referringLibraryUri: draft.libraryUri,
        );
      }
      if (draft.extraHierarchyType != null) {
        _recordTypeUsage(
          apiType: draft.extraHierarchyType!,
          localDeclarationsByName: localDeclarationsByName,
          interfaceDrafts: interfaceDraftsWithAliasEntrypoints,
          typeUsagesByDeclaration: typeUsagesByDeclaration,
          kind: TypeUsageKind.hierarchy,
          referringElementName: draft.name,
          referringLibraryUri: draft.libraryUri,
        );
      }
    }

    for (final executable in rootExecutables.values.where(
      (declaration) => (declaration.entryPoints ?? const {}).isNotEmpty,
    )) {
      _recordExecutableTypeUsagesFromExecutableModel(
        declaration: executable,
        localDeclarationsByName: localDeclarationsByName,
        interfaceDrafts: interfaceDraftsWithAliasEntrypoints,
        typeUsagesByDeclaration: typeUsagesByDeclaration,
        referringLibraryUri: _packageLibraryUri(executable.relativePath),
      );
    }
    final rootFields = rootFieldAccumulators.values
        .map((field) => field.build())
        .toList();
    for (final field in rootFields.where(
      (declaration) => (declaration.entryPoints ?? const {}).isNotEmpty,
    )) {
      _recordTypeUsageByName(
        typeName: field.typeName,
        typeFullLibraryName: field.typeFullLibraryName,
        localDeclarationsByName: localDeclarationsByName,
        interfaceDrafts: interfaceDraftsWithAliasEntrypoints,
        typeUsagesByDeclaration: typeUsagesByDeclaration,
        kind: TypeUsageKind.output,
        referringElementName: field.name,
        referringLibraryUri: _packageLibraryUri(field.relativePath),
      );
      if (field.isWriteable) {
        _recordTypeUsageByName(
          typeName: field.typeName,
          typeFullLibraryName: field.typeFullLibraryName,
          localDeclarationsByName: localDeclarationsByName,
          interfaceDrafts: interfaceDraftsWithAliasEntrypoints,
          typeUsagesByDeclaration: typeUsagesByDeclaration,
          kind: TypeUsageKind.input,
          referringElementName: field.name,
          referringLibraryUri: _packageLibraryUri(field.relativePath),
        );
      }
    }
    for (final typeAliasEntry in rootTypeAliases.entries.where(
      (entry) => (entry.value.entryPoints ?? const {}).isNotEmpty,
    )) {
      final typeAlias = typeAliasEntry.value;
      final aliasedType = rootTypeAliasTargets[typeAliasEntry.key];
      if (aliasedType == null) {
        continue;
      }
      _recordTypeUsage(
        apiType: aliasedType,
        localDeclarationsByName: localDeclarationsByName,
        interfaceDrafts: interfaceDraftsWithAliasEntrypoints,
        typeUsagesByDeclaration: typeUsagesByDeclaration,
        kind: TypeUsageKind.hierarchy,
        referringElementName: typeAlias.name,
        referringLibraryUri: _packageLibraryUri(typeAlias.relativePath),
      );
    }

    // Existing diff semantics treat an input-position type as accepting any of
    // its base types too. Keep propagating that through the summarized hierarchy.
    var propagatedInputToBaseTypes = true;
    while (propagatedInputToBaseTypes) {
      propagatedInputToBaseTypes = false;
      for (final entry in interfaceDraftsWithAliasEntrypoints.entries) {
        final usages =
            typeUsagesByDeclaration[entry.key] ?? const <TypeUsage>{};
        if (!usages.any((usage) => usage.kind == TypeUsageKind.input)) {
          continue;
        }
        final usageCountBefore = _typeUsageCount(typeUsagesByDeclaration);
        for (final baseType in entry.value.baseTypes) {
          _recordTypeUsage(
            apiType: baseType,
            localDeclarationsByName: localDeclarationsByName,
            interfaceDrafts: interfaceDraftsWithAliasEntrypoints,
            typeUsagesByDeclaration: typeUsagesByDeclaration,
            kind: TypeUsageKind.input,
            referringElementName: entry.value.name,
            referringLibraryUri: entry.value.libraryUri,
          );
        }
        propagatedInputToBaseTypes =
            propagatedInputToBaseTypes ||
            _typeUsageCount(typeUsagesByDeclaration) > usageCountBefore;
      }
    }

    final filteredInterfaceEntries = interfaceDraftsWithAliasEntrypoints.entries
        .where((entry) {
          if (entry.value.entryPoints.isNotEmpty) {
            return true;
          }
          // Keep hidden interfaces only when they are part of a public signature.
          final usages =
              typeUsagesByDeclaration[entry.key] ?? const <TypeUsage>{};
          return usages.any((usage) => usage.kind != TypeUsageKind.hierarchy);
        });

    return _AdaptedApiSummary(
      interfaceDeclarations: filteredInterfaceEntries
          .map(
            (entry) => entry.value.toInterfaceDeclaration(
              typeUsagesByDeclaration[entry.key] ?? const {},
            ),
          )
          .toList(),
      executableDeclarations: rootExecutables.values
          .where(
            (declaration) => (declaration.entryPoints ?? const {}).isNotEmpty,
          )
          .toList(),
      fieldDeclarations: rootFields
          .where(
            (declaration) => (declaration.entryPoints ?? const {}).isNotEmpty,
          )
          .toList(),
      typeAliasDeclarations: rootTypeAliases.values
          .where(
            (declaration) => (declaration.entryPoints ?? const {}).isNotEmpty,
          )
          .toList(),
      typeHierarchy: typeHierarchy,
    );
  }

  int _typeUsageCount(
    Map<_DeclarationKey, Set<TypeUsage>> typeUsagesByDeclaration,
  ) {
    return typeUsagesByDeclaration.values.fold<int>(
      0,
      (sum, usages) => sum + usages.length,
    );
  }

  void _addInterfaceDraft(
    Map<_DeclarationKey, _InterfaceDraft> drafts,
    _DeclarationKey key,
    _InterfaceDraft draft,
  ) {
    drafts.update(
      key,
      (existing) => existing.mergeWith(draft),
      ifAbsent: () => draft,
    );
  }

  Set<String> _entryPointsForDeclaration(
    api_summary.ApiDeclaration declaration,
    api_summary.ApiLibrary library, {
    required bool hasSinglePublicEntrypoint,
  }) {
    if (declaration.status != api_summary.ApiDeclarationStatus.public) {
      return const <String>{};
    }
    return _entryPointsForLibrary(
      library,
      hasSinglePublicEntrypoint: hasSinglePublicEntrypoint,
    );
  }

  String _declarationLibraryUri(
    api_summary.ApiDeclaration declaration,
    String fallbackLibraryUri,
  ) {
    return _normalizeLibraryUri(declaration.locationUri) ??
        _normalizeLibraryUri(fallbackLibraryUri)!;
  }

  Set<String> _entryPointsForLibrary(
    api_summary.ApiLibrary library, {
    required bool hasSinglePublicEntrypoint,
  }) {
    if (!_isConsideredEntrypointLibrary(library)) {
      return const <String>{};
    }
    final relativePath = _relativePathFromLibraryUri(library.uri);
    return {
      _canonicalEntrypointPath(
        relativePath,
        hasSingleRootEntrypoint: hasSinglePublicEntrypoint,
      ),
    };
  }

  bool _isConsideredEntrypointLibrary(api_summary.ApiLibrary library) {
    if (!library.isPublicEntryPoint) {
      return false;
    }
    if (doConsiderNonSrcAsEntryPoints) {
      return true;
    }
    return !path
            .split(_relativePathFromLibraryUri(library.uri))
            .contains('src') &&
        !path
            .split(_relativePathFromLibraryUri(library.uri))
            .skip(1)
            .isNotEmpty;
  }

  String _canonicalEntrypointPath(
    String relativePath, {
    required bool hasSingleRootEntrypoint,
  }) {
    if (!hasSingleRootEntrypoint || relativePath.contains(path.separator)) {
      return relativePath;
    }
    final fileName = path.basename(relativePath);
    final canonicalFileName = '$packageName.dart';
    if (fileName == canonicalFileName) {
      return relativePath;
    }
    return canonicalFileName;
  }

  ExecutableDeclaration _mergeExecutableDeclaration(
    ExecutableDeclaration existing,
    ExecutableDeclaration incoming,
  ) {
    return existing.copyWith(
      entryPoints: {...?existing.entryPoints, ...?incoming.entryPoints},
    );
  }

  TypeAliasDeclaration _mergeTypeAliasDeclaration(
    TypeAliasDeclaration existing,
    TypeAliasDeclaration incoming,
  ) {
    return existing.copyWith(
      entryPoints: {...?existing.entryPoints, ...?incoming.entryPoints},
    );
  }

  Map<_DeclarationKey, _InterfaceDraft> _flattenMixedInMembers(
    Map<_DeclarationKey, _InterfaceDraft> interfaceDrafts,
  ) {
    final localDeclarationsByName = <String, List<_DeclarationKey>>{};
    for (final key in interfaceDrafts.keys) {
      localDeclarationsByName.putIfAbsent(key.name, () => []).add(key);
    }

    final flattenedDrafts = <_DeclarationKey, _InterfaceDraft>{};
    final activeKeys = <_DeclarationKey>{};

    _InterfaceDraft flattenDraft(_DeclarationKey key) {
      final cached = flattenedDrafts[key];
      if (cached != null) {
        return cached;
      }

      final current = interfaceDrafts[key]!;
      if ((current.mixedInTypes.isEmpty && current.superClassType == null) ||
          !activeKeys.add(key)) {
        return current;
      }

      var flattened = current;
      final superClassType = current.superClassType;
      if (superClassType != null) {
        final superClassKey = _resolveDeclarationKey(
          typeName: _renderType(superClassType),
          typeFullLibraryName: _libraryUriFromType(superClassType),
          localDeclarationsByName: localDeclarationsByName,
          interfaceDrafts: interfaceDrafts,
        );
        if (superClassKey != null) {
          final superClassDraft = flattenDraft(superClassKey);
          flattened = flattened.flattenMixedInMembersFrom(superClassDraft);
        }
      }
      for (final mixedInType in current.mixedInTypes) {
        final mixedInKey = _resolveDeclarationKey(
          typeName: _renderType(mixedInType),
          typeFullLibraryName: _libraryUriFromType(mixedInType),
          localDeclarationsByName: localDeclarationsByName,
          interfaceDrafts: interfaceDrafts,
        );
        if (mixedInKey == null) {
          continue;
        }
        final mixedInDraft = flattenDraft(mixedInKey);
        flattened = flattened.flattenMixedInMembersFrom(mixedInDraft);
      }

      activeKeys.remove(key);
      flattenedDrafts[key] = flattened;
      return flattened;
    }

    for (final key in interfaceDrafts.keys) {
      flattenedDrafts[key] = flattenDraft(key);
    }

    return flattenedDrafts;
  }

  _InterfaceDraft _adaptClassLikeDeclaration({
    required api_summary.ApiClass declaration,
    required String relativePath,
    required String libraryUri,
    required Set<String> entryPoints,
    required TypeHierarchy typeHierarchy,
  }) {
    final executableDeclarations = <ExecutableDeclaration>[];
    final fieldAccumulators = <String, _FieldAccumulator>{};

    for (final constructor in declaration.constructors) {
      executableDeclarations.add(
        _adaptExecutableDeclaration(
          declaration: constructor,
          relativePath: relativePath,
          entryPoints: entryPoints,
        ),
      );
    }
    for (final method in declaration.methods) {
      if (_isObjectToStringOverride(method)) {
        continue;
      }
      if (_isFieldLikeExecutable(method.kind)) {
        final fieldName = _fieldNameForExecutable(method.name);
        fieldAccumulators
            .putIfAbsent(
              fieldName,
              () => _FieldAccumulator(
                name: fieldName,
                relativePath: relativePath,
                entryPoints: entryPoints,
              ),
            )
            .addExecutable(method);
      } else {
        executableDeclarations.add(
          _adaptExecutableDeclaration(
            declaration: method,
            relativePath: relativePath,
            entryPoints: entryPoints,
          ),
        );
      }
    }

    final baseTypes = <api_summary.ApiType>[
      if (declaration.supertype != null) declaration.supertype!,
      ...declaration.interfaces,
      ...declaration.mixins,
      ...declaration.superclassConstraints,
    ];
    final usageBaseTypes = <api_summary.ApiType>[
      if (declaration.supertype != null) declaration.supertype!,
      ...declaration.interfaces,
      ...declaration.superclassConstraints,
    ];

    typeHierarchy.registerType(
      TypeIdentifier.fromNameAndLibraryPath(
        typeName: declaration.name,
        libraryPath: libraryUri,
      ),
      baseTypes
          .map(_typeIdentifierFromApiType)
          .whereType<TypeIdentifier>()
          .toSet(),
    );

    return _InterfaceDraft(
      name: declaration.name,
      isDeprecated: declaration.isDeprecated,
      isExperimental: declaration.isExperimental,
      isSealed: declaration.modifiers.contains(
        api_summary.ApiClassModifier.isSealed,
      ),
      isAbstract: declaration.modifiers.contains(
        api_summary.ApiClassModifier.isAbstract,
      ),
      typeParameterNames: _typeParameterNames(declaration.typeParameters),
      superTypeNames: baseTypes.map(_renderType).toSet(),
      executableDeclarations: executableDeclarations,
      fieldDeclarations: fieldAccumulators.values
          .map((field) => field.build())
          .toList(),
      entryPoints: entryPoints,
      relativePath: relativePath,
      libraryUri: libraryUri,
      sourceExecutables: [
        ...declaration.constructors.map(
          (constructor) => _SourceExecutableData(
            declaration: constructor,
            referringElementName: constructor.name,
            isVisibleForTesting: constructor.isVisibleForTesting,
          ),
        ),
        ...declaration.methods.map(
          (method) => _SourceExecutableData(
            declaration: method,
            referringElementName: method.name,
            isVisibleForTesting: method.isVisibleForTesting,
          ),
        ),
      ],
      baseTypes: usageBaseTypes,
      superClassType: declaration.supertype,
      mixedInTypes: declaration.mixins,
    );
  }

  _InterfaceDraft _adaptExtensionDeclaration({
    required api_summary.ApiExtension declaration,
    required String relativePath,
    required String libraryUri,
    required Set<String> entryPoints,
    required TypeHierarchy typeHierarchy,
  }) {
    final executableDeclarations = <ExecutableDeclaration>[];
    final fieldAccumulators = <String, _FieldAccumulator>{};

    for (final method in declaration.methods) {
      if (_isFieldLikeExecutable(method.kind)) {
        final fieldName = _fieldNameForExecutable(method.name);
        fieldAccumulators
            .putIfAbsent(
              fieldName,
              () => _FieldAccumulator(
                name: fieldName,
                relativePath: relativePath,
                entryPoints: entryPoints,
              ),
            )
            .addExecutable(method);
      } else {
        executableDeclarations.add(
          _adaptExecutableDeclaration(
            declaration: method,
            relativePath: relativePath,
            entryPoints: entryPoints,
          ),
        );
      }
    }

    typeHierarchy.registerType(
      TypeIdentifier.fromNameAndLibraryPath(
        typeName: declaration.name,
        libraryPath: libraryUri,
      ),
      const {},
    );

    return _InterfaceDraft(
      name: declaration.name,
      isDeprecated: declaration.isDeprecated,
      isExperimental: declaration.isExperimental,
      isSealed: false,
      isAbstract: false,
      typeParameterNames: _typeParameterNames(declaration.typeParameters),
      superTypeNames: const {},
      executableDeclarations: executableDeclarations,
      fieldDeclarations: fieldAccumulators.values
          .map((field) => field.build())
          .toList(),
      entryPoints: entryPoints,
      relativePath: relativePath,
      libraryUri: libraryUri,
      sourceExecutables: declaration.methods
          .map(
            (method) => _SourceExecutableData(
              declaration: method,
              referringElementName: method.name,
              isVisibleForTesting: method.isVisibleForTesting,
            ),
          )
          .toList(),
      baseTypes: const [],
      extraHierarchyType: declaration.extendedType,
    );
  }

  _InterfaceDraft _adaptExtensionTypeDeclaration({
    required api_summary.ApiExtensionType declaration,
    required String relativePath,
    required String libraryUri,
    required Set<String> entryPoints,
    required TypeHierarchy typeHierarchy,
  }) {
    final executableDeclarations = <ExecutableDeclaration>[];
    final fieldAccumulators = <String, _FieldAccumulator>{};

    for (final constructor in declaration.constructors) {
      executableDeclarations.add(
        _adaptExecutableDeclaration(
          declaration: constructor,
          relativePath: relativePath,
          entryPoints: entryPoints,
        ),
      );
    }
    for (final method in declaration.methods) {
      if (_isFieldLikeExecutable(method.kind)) {
        final fieldName = _fieldNameForExecutable(method.name);
        fieldAccumulators
            .putIfAbsent(
              fieldName,
              () => _FieldAccumulator(
                name: fieldName,
                relativePath: relativePath,
                entryPoints: entryPoints,
              ),
            )
            .addExecutable(method);
      } else {
        executableDeclarations.add(
          _adaptExecutableDeclaration(
            declaration: method,
            relativePath: relativePath,
            entryPoints: entryPoints,
          ),
        );
      }
    }

    final baseTypes = <api_summary.ApiType>[
      declaration.representationType,
      ...declaration.interfaces,
    ];

    typeHierarchy.registerType(
      TypeIdentifier.fromNameAndLibraryPath(
        typeName: declaration.name,
        libraryPath: libraryUri,
      ),
      baseTypes
          .map(_typeIdentifierFromApiType)
          .whereType<TypeIdentifier>()
          .toSet(),
    );

    return _InterfaceDraft(
      name: declaration.name,
      isDeprecated: declaration.isDeprecated,
      isExperimental: declaration.isExperimental,
      isSealed: false,
      isAbstract: false,
      typeParameterNames: _typeParameterNames(declaration.typeParameters),
      superTypeNames: baseTypes.map(_renderType).toSet(),
      executableDeclarations: executableDeclarations,
      fieldDeclarations: fieldAccumulators.values
          .map((field) => field.build())
          .toList(),
      entryPoints: entryPoints,
      relativePath: relativePath,
      libraryUri: libraryUri,
      sourceExecutables: [
        ...declaration.constructors.map(
          (constructor) => _SourceExecutableData(
            declaration: constructor,
            referringElementName: constructor.name,
            isVisibleForTesting: constructor.isVisibleForTesting,
          ),
        ),
        ...declaration.methods.map(
          (method) => _SourceExecutableData(
            declaration: method,
            referringElementName: method.name,
            isVisibleForTesting: method.isVisibleForTesting,
          ),
        ),
      ],
      baseTypes: baseTypes,
    );
  }

  ExecutableDeclaration _adaptExecutableDeclaration({
    required api_summary.ApiExecutable declaration,
    required String relativePath,
    required Set<String> entryPoints,
  }) {
    return ExecutableDeclaration(
      returnTypeName: _renderType(declaration.returnType),
      returnTypeFullLibraryName: _libraryUriFromType(declaration.returnType),
      name: _adaptExecutableName(declaration),
      isDeprecated: declaration.isDeprecated,
      isExperimental: declaration.isExperimental,
      parameters: declaration.parameters
          .map(
            (parameter) => ExecutableParameterDeclaration(
              isRequired: parameter.isRequired,
              isNamed: parameter.isNamed,
              name: parameter.name,
              isDeprecated: parameter.isDeprecated,
              isExperimental: false,
              typeName: _renderType(parameter.type),
              typeFullLibraryName: _libraryUriFromType(parameter.type),
              relativePath: relativePath,
            ),
          )
          .toList(),
      typeParameterNames: _typeParameterNames(declaration.typeParameters),
      type: declaration.kind == api_summary.ApiExecutableKind.constructor
          ? ExecutableType.constructor
          : ExecutableType.method,
      isStatic: declaration.isStatic,
      entryPoints: entryPoints,
      relativePath: relativePath,
    );
  }

  bool _isObjectToStringOverride(api_summary.ApiExecutable declaration) {
    return declaration.kind == api_summary.ApiExecutableKind.method &&
        declaration.name == 'toString' &&
        declaration.parameters.isEmpty &&
        _renderType(declaration.returnType) == 'String';
  }

  String _adaptExecutableName(api_summary.ApiExecutable declaration) {
    if (declaration.kind != api_summary.ApiExecutableKind.method ||
        !_dartOperatorNames.contains(declaration.name)) {
      return declaration.name;
    }
    final prefix = declaration.parameters.isEmpty ? 'unary' : 'binary';
    if (declaration.name.startsWith(prefix)) {
      return declaration.name;
    }
    return '$prefix${declaration.name}';
  }

  void _recordExecutableTypeUsages({
    required api_summary.ApiExecutable declaration,
    required Map<String, List<_DeclarationKey>> localDeclarationsByName,
    required Map<_DeclarationKey, _InterfaceDraft> interfaceDrafts,
    required Map<_DeclarationKey, Set<TypeUsage>> typeUsagesByDeclaration,
    required String referringElementName,
    required bool isVisibleForTesting,
    required String referringLibraryUri,
  }) {
    if (declaration.kind != api_summary.ApiExecutableKind.constructor) {
      _recordTypeUsage(
        apiType: declaration.returnType,
        localDeclarationsByName: localDeclarationsByName,
        interfaceDrafts: interfaceDrafts,
        typeUsagesByDeclaration: typeUsagesByDeclaration,
        kind: TypeUsageKind.output,
        referringElementName: referringElementName,
        isVisibleForTesting: isVisibleForTesting,
        referringLibraryUri: referringLibraryUri,
      );
    }
    for (final parameter in declaration.parameters) {
      _recordTypeUsage(
        apiType: parameter.type,
        localDeclarationsByName: localDeclarationsByName,
        interfaceDrafts: interfaceDrafts,
        typeUsagesByDeclaration: typeUsagesByDeclaration,
        kind: TypeUsageKind.input,
        referringElementName: referringElementName,
        isVisibleForTesting: isVisibleForTesting,
        referringLibraryUri: referringLibraryUri,
      );
    }
    for (final typeParameterBound
        in declaration.typeParameters.values.whereType<api_summary.ApiType>()) {
      _recordTypeUsage(
        apiType: typeParameterBound,
        localDeclarationsByName: localDeclarationsByName,
        interfaceDrafts: interfaceDrafts,
        typeUsagesByDeclaration: typeUsagesByDeclaration,
        kind: TypeUsageKind.hierarchy,
        referringElementName: referringElementName,
        isVisibleForTesting: isVisibleForTesting,
        referringLibraryUri: referringLibraryUri,
      );
    }
  }

  void _recordExecutableTypeUsagesFromExecutableModel({
    required ExecutableDeclaration declaration,
    required Map<String, List<_DeclarationKey>> localDeclarationsByName,
    required Map<_DeclarationKey, _InterfaceDraft> interfaceDrafts,
    required Map<_DeclarationKey, Set<TypeUsage>> typeUsagesByDeclaration,
    required String referringLibraryUri,
  }) {
    _recordTypeUsageByName(
      typeName: declaration.returnTypeName,
      typeFullLibraryName: declaration.returnTypeFullLibraryName,
      localDeclarationsByName: localDeclarationsByName,
      interfaceDrafts: interfaceDrafts,
      typeUsagesByDeclaration: typeUsagesByDeclaration,
      kind: TypeUsageKind.output,
      referringElementName: declaration.name,
      referringLibraryUri: referringLibraryUri,
    );
    for (final parameter in declaration.parameters) {
      _recordTypeUsageByName(
        typeName: parameter.typeName,
        typeFullLibraryName: parameter.typeFullLibraryName,
        localDeclarationsByName: localDeclarationsByName,
        interfaceDrafts: interfaceDrafts,
        typeUsagesByDeclaration: typeUsagesByDeclaration,
        kind: TypeUsageKind.input,
        referringElementName: declaration.name,
        referringLibraryUri: referringLibraryUri,
      );
    }
  }

  void _recordTypeUsage({
    required api_summary.ApiType apiType,
    required Map<String, List<_DeclarationKey>> localDeclarationsByName,
    required Map<_DeclarationKey, _InterfaceDraft> interfaceDrafts,
    required Map<_DeclarationKey, Set<TypeUsage>> typeUsagesByDeclaration,
    required TypeUsageKind kind,
    required String referringElementName,
    bool isVisibleForTesting = false,
    String? referringLibraryUri,
    Set<_DeclarationKey> visitedTypeAliases = const {},
  }) {
    final libraryUri = _libraryUriFromType(apiType);
    final typeName = _renderType(apiType);
    _recordTypeUsageByName(
      typeName: typeName,
      typeFullLibraryName: libraryUri,
      localDeclarationsByName: localDeclarationsByName,
      interfaceDrafts: interfaceDrafts,
      typeUsagesByDeclaration: typeUsagesByDeclaration,
      kind: kind,
      referringElementName: referringElementName,
      isVisibleForTesting: isVisibleForTesting,
      referringLibraryUri: referringLibraryUri,
    );

    final typeAliasKey = _resolveTypeAliasKey(
      typeName: typeName,
      typeFullLibraryName: libraryUri,
    );
    if (typeAliasKey != null && !visitedTypeAliases.contains(typeAliasKey)) {
      final aliasedType = _typeAliasTargets[typeAliasKey];
      if (aliasedType != null) {
        _recordTypeUsage(
          apiType: aliasedType,
          localDeclarationsByName: localDeclarationsByName,
          interfaceDrafts: interfaceDrafts,
          typeUsagesByDeclaration: typeUsagesByDeclaration,
          kind: kind,
          referringElementName: referringElementName,
          isVisibleForTesting: isVisibleForTesting,
          referringLibraryUri: referringLibraryUri,
          visitedTypeAliases: {...visitedTypeAliases, typeAliasKey},
        );
      }
    }

    switch (apiType) {
      case api_summary.ApiInterfaceType(:final typeArguments):
        for (final typeArgument in typeArguments) {
          _recordTypeUsage(
            apiType: typeArgument,
            localDeclarationsByName: localDeclarationsByName,
            interfaceDrafts: interfaceDrafts,
            typeUsagesByDeclaration: typeUsagesByDeclaration,
            kind: kind,
            referringElementName: referringElementName,
            isVisibleForTesting: isVisibleForTesting,
            referringLibraryUri: referringLibraryUri,
          );
        }
      case api_summary.ApiFunctionType(
        :final returnType,
        :final typeParameters,
        :final parameters,
      ):
        _recordTypeUsage(
          apiType: returnType,
          localDeclarationsByName: localDeclarationsByName,
          interfaceDrafts: interfaceDrafts,
          typeUsagesByDeclaration: typeUsagesByDeclaration,
          kind: TypeUsageKind.output,
          referringElementName: referringElementName,
          isVisibleForTesting: isVisibleForTesting,
          referringLibraryUri: referringLibraryUri,
        );
        for (final parameter in parameters) {
          _recordTypeUsage(
            apiType: parameter.type,
            localDeclarationsByName: localDeclarationsByName,
            interfaceDrafts: interfaceDrafts,
            typeUsagesByDeclaration: typeUsagesByDeclaration,
            kind: TypeUsageKind.input,
            referringElementName: referringElementName,
            isVisibleForTesting: isVisibleForTesting,
            referringLibraryUri: referringLibraryUri,
          );
        }
        for (final bound
            in typeParameters.values.whereType<api_summary.ApiType>()) {
          _recordTypeUsage(
            apiType: bound,
            localDeclarationsByName: localDeclarationsByName,
            interfaceDrafts: interfaceDrafts,
            typeUsagesByDeclaration: typeUsagesByDeclaration,
            kind: TypeUsageKind.hierarchy,
            referringElementName: referringElementName,
            isVisibleForTesting: isVisibleForTesting,
            referringLibraryUri: referringLibraryUri,
          );
        }
      case api_summary.ApiRecordType(
        :final positionalFields,
        :final namedFields,
      ):
        for (final field in positionalFields) {
          _recordTypeUsage(
            apiType: field,
            localDeclarationsByName: localDeclarationsByName,
            interfaceDrafts: interfaceDrafts,
            typeUsagesByDeclaration: typeUsagesByDeclaration,
            kind: kind,
            referringElementName: referringElementName,
            isVisibleForTesting: isVisibleForTesting,
            referringLibraryUri: referringLibraryUri,
          );
        }
        for (final field in namedFields) {
          _recordTypeUsage(
            apiType: field.type,
            localDeclarationsByName: localDeclarationsByName,
            interfaceDrafts: interfaceDrafts,
            typeUsagesByDeclaration: typeUsagesByDeclaration,
            kind: kind,
            referringElementName: referringElementName,
            isVisibleForTesting: isVisibleForTesting,
            referringLibraryUri: referringLibraryUri,
          );
        }
      default:
        break;
    }
  }

  void _recordTypeUsageByName({
    required String typeName,
    required String? typeFullLibraryName,
    required Map<String, List<_DeclarationKey>> localDeclarationsByName,
    required Map<_DeclarationKey, _InterfaceDraft> interfaceDrafts,
    required Map<_DeclarationKey, Set<TypeUsage>> typeUsagesByDeclaration,
    required TypeUsageKind kind,
    required String referringElementName,
    bool isVisibleForTesting = false,
    String? referringLibraryUri,
  }) {
    final declarationKey = _resolveDeclarationKey(
      typeName: typeName,
      typeFullLibraryName: typeFullLibraryName,
      localDeclarationsByName: localDeclarationsByName,
      interfaceDrafts: interfaceDrafts,
    );
    if (declarationKey == null) {
      return;
    }
    typeUsagesByDeclaration
        .putIfAbsent(declarationKey, () => <TypeUsage>{})
        .add(
          TypeUsage(
            kind: kind,
            referringElementName: referringElementName,
            isVisibleForTesting: isVisibleForTesting,
          ),
        );
  }

  _DeclarationKey? _resolveDeclarationKey({
    required String typeName,
    required String? typeFullLibraryName,
    required Map<String, List<_DeclarationKey>> localDeclarationsByName,
    required Map<_DeclarationKey, _InterfaceDraft> interfaceDrafts,
  }) {
    if (typeName.isEmpty) {
      return null;
    }
    final bareTypeName = _stripTypeSuffixes(typeName);
    final normalizedLibraryUri = _normalizeLibraryUri(typeFullLibraryName);
    if (normalizedLibraryUri != null) {
      final candidate = _DeclarationKey(
        name: bareTypeName,
        libraryUri: normalizedLibraryUri,
      );
      if (interfaceDrafts.containsKey(candidate)) {
        return candidate;
      }
    }
    final candidates = localDeclarationsByName[bareTypeName];
    if (candidates == null || candidates.length != 1) {
      return null;
    }
    return candidates.single;
  }

  _DeclarationKey? _resolveTypeAliasKey({
    required String typeName,
    required String? typeFullLibraryName,
  }) {
    if (typeName.isEmpty) {
      return null;
    }
    final bareTypeName = _stripTypeSuffixes(typeName);
    final normalizedLibraryUri = _normalizeLibraryUri(typeFullLibraryName);
    if (normalizedLibraryUri != null) {
      final candidate = _DeclarationKey(
        name: bareTypeName,
        libraryUri: normalizedLibraryUri,
      );
      if (_typeAliasTargets.containsKey(candidate)) {
        return candidate;
      }
    }
    final candidates = _localTypeAliasesByName[bareTypeName];
    if (candidates == null || candidates.length != 1) {
      return null;
    }
    return candidates.single;
  }

  bool _isFieldLikeExecutable(api_summary.ApiExecutableKind kind) {
    return kind == api_summary.ApiExecutableKind.getter ||
        kind == api_summary.ApiExecutableKind.setter;
  }

  String _fieldNameForExecutable(String name) {
    return name.endsWith('=') ? name.substring(0, name.length - 1) : name;
  }

  String _packageLibraryUri(String relativePath) {
    return 'package:$packageName/$relativePath';
  }

  String _relativePathFromLibraryUri(String libraryUri) {
    final normalizedUri = _normalizeLibraryUri(libraryUri);
    if (normalizedUri == null) {
      return libraryUri;
    }
    if (normalizedUri.startsWith('package:$packageName/')) {
      return normalizedUri.substring('package:$packageName/'.length);
    }
    final uri = Uri.tryParse(normalizedUri);
    if (uri != null && uri.scheme == 'file') {
      final libPath = path.join(packagePath, 'lib');
      final filePath = path.normalize(uri.toFilePath());
      if (path.isWithin(libPath, filePath) || filePath == libPath) {
        return path.relative(filePath, from: libPath);
      }
    }
    return normalizedUri;
  }

  List<String> _typeParameterNames(
    Map<String, api_summary.ApiType?> typeParameters,
  ) {
    return typeParameters.keys.toList();
  }

  TypeIdentifier? _typeIdentifierFromApiType(api_summary.ApiType type) {
    final libraryUri = _libraryUriFromType(type);
    final typeName = _renderType(type);
    if (typeName.isEmpty) {
      return null;
    }
    return TypeIdentifier.fromNameAndLibraryPath(
      typeName: typeName,
      libraryPath: libraryUri,
    );
  }
}
