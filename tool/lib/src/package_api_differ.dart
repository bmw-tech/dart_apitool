import 'model/model.dart';

/// can calculate a diff between two PackageApis
class PackageApiDiffer {
  final PackageApiDifferOptions options;

  PackageApiDiffer({
    this.options = const PackageApiDifferOptions(
      ignoreTypeParameterNameChanges: true,
    ),
  });

  /// calculates a diff between [oldApi] and [newApi]
  PackageApiDifResult diff({
    required PackageApi oldApi,
    required PackageApi newApi,
  }) {
    if (oldApi.packageName != newApi.packageName) {
      throw PackageApiDiffError(
          message:
              'Got different packages. Can\'t create diff. Old Package = "${oldApi.packageName}", New Package = "${newApi.packageName}"');
    }

    final changes = [
      ..._calculateClassesDiff(
          oldApi.classDeclarations, newApi.classDeclarations),
      ..._calculateExecutablesDiff(
        oldApi.executableDeclarations,
        newApi.executableDeclarations,
        null,
      ),
      ..._calculateFieldsDiff(
        oldApi.fieldDeclarations,
        newApi.fieldDeclarations,
        null,
      ),
    ];

    return PackageApiDifResult(changes);
  }

  List<ApiChange> _calculateClassesDiff(
      List<ClassDeclaration> oldClasses, List<ClassDeclaration> newClasses) {
    final classListDiff = _diffLists<ClassDeclaration>(
      oldClasses,
      newClasses,
      (oldClass, newClass) => oldClass.name == newClass.name,
    );
    final changes = <ApiChange>[];
    for (final oldClass in classListDiff.matches.keys) {
      changes.addAll(_calculateClassDiff(
        oldClass,
        classListDiff.matches[oldClass]!,
        null,
      ));
    }
    for (final removedClass in classListDiff.remainingOld) {
      changes.add(ApiChange(
        affectedDeclaration: removedClass,
        context: null,
        type: ApiChangeType.remove,
        changeDescription: 'Class ${removedClass.name} removed',
      ));
    }
    for (final addedClass in classListDiff.remainingNew) {
      changes.add(ApiChange(
        affectedDeclaration: addedClass,
        context: null,
        type: ApiChangeType.addCompatible,
        changeDescription: 'Class ${addedClass.name} added',
      ));
    }
    return changes;
  }

  List<ApiChange> _calculateClassDiff(
    ClassDeclaration oldClass,
    ClassDeclaration newClass,
    Declaration? context,
  ) {
    final changes = [
      ..._calculateExecutablesDiff(oldClass.executableDeclarations,
          newClass.executableDeclarations, newClass),
      ..._calculateFieldsDiff(
          oldClass.fieldDeclarations, newClass.fieldDeclarations, newClass),
      ..._calculateSuperTypesDiff(
          oldClass.superTypeNames, newClass.superTypeNames, newClass),
      ..._calculateTypeParametersDiff(
          oldClass.typeParameterNames, newClass.typeParameterNames, newClass),
    ];
    _comparePropertiesAndAddChange(
      oldClass.isDeprecated,
      newClass.isDeprecated,
      context,
      newClass,
      'Deprecated Flag of Class ${newClass.name} changed',
      changes,
      isCompatibleChange: true,
    );
    return changes;
  }

  List<ApiChange> _calculateExecutablesDiff(
    List<ExecutableDeclaration> oldExecutables,
    List<ExecutableDeclaration> newExecutables,
    Declaration? context,
  ) {
    final executableListDiff = _diffLists<ExecutableDeclaration>(oldExecutables,
        newExecutables, (oldEx, newEx) => oldEx.name == newEx.name);
    final changes = <ApiChange>[];
    for (final oldEx in executableListDiff.matches.keys) {
      changes.addAll(_calculateExecutableDiff(
        oldEx,
        executableListDiff.matches[oldEx]!,
        context,
      ));
    }
    for (final removedExecutable in executableListDiff.remainingOld) {
      changes.add(ApiChange(
        affectedDeclaration: removedExecutable,
        context: context,
        type: ApiChangeType.remove,
        changeDescription: 'Executable ${removedExecutable.name} removed',
      ));
    }
    for (final addedExecutable in executableListDiff.remainingNew) {
      changes.add(ApiChange(
        affectedDeclaration: addedExecutable,
        context: context,
        type: ApiChangeType.addCompatible,
        changeDescription: 'Executable ${addedExecutable.name} added',
      ));
    }
    return changes;
  }

  List<ApiChange> _calculateExecutableDiff(
    ExecutableDeclaration oldExecutable,
    ExecutableDeclaration newExecutable,
    Declaration? context,
  ) {
    final changes = [
      ..._calculateParametersDiff(
          oldExecutable.parameters, newExecutable.parameters, newExecutable),
      ..._calculateTypeParametersDiff(oldExecutable.typeParameterNames,
          newExecutable.typeParameterNames, newExecutable),
    ];
    _comparePropertiesAndAddChange(
      oldExecutable.isDeprecated,
      newExecutable.isDeprecated,
      context,
      newExecutable,
      'Deprecated Flag for Executable ${newExecutable.name} changed. ${oldExecutable.isDeprecated} -> ${newExecutable.isDeprecated}',
      changes,
      isCompatibleChange: true,
    );
    _comparePropertiesAndAddChange(
      oldExecutable.returnTypeName,
      newExecutable.returnTypeName,
      context,
      newExecutable,
      'Return type of Executable ${newExecutable.name} changed. ${oldExecutable.returnTypeName} -> ${newExecutable.returnTypeName}',
      changes,
    );
    return changes;
  }

  List<ApiChange> _calculateParametersDiff(
    List<ExecutableParameterDeclaration> oldParameters,
    List<ExecutableParameterDeclaration> newParameters,
    Declaration context,
  ) {
    final parametersListDiff = _diffLists<ExecutableParameterDeclaration>(
        oldParameters,
        newParameters,
        (oldParam, newParam) => oldParam.name == newParam.name);
    final changes = <ApiChange>[];
    for (final oldParam in parametersListDiff.matches.keys) {
      changes.addAll(_calculateParameterDiff(
          oldParam, parametersListDiff.matches[oldParam]!, context));
    }
    for (final removedParameter in parametersListDiff.remainingOld) {
      changes.add(ApiChange(
        affectedDeclaration: context,
        context: context,
        type: ApiChangeType.remove,
        changeDescription: 'Parameter ${removedParameter.name} removed',
      ));
    }
    for (final addedParameter in parametersListDiff.remainingNew) {
      changes.add(ApiChange(
        affectedDeclaration: context,
        context: context,
        type: addedParameter.isRequired
            ? ApiChangeType.addBreaking
            : ApiChangeType.addCompatible,
        changeDescription: 'Parameter ${addedParameter.name} added',
      ));
    }
    return changes;
  }

  List<ApiChange> _calculateParameterDiff(
    ExecutableParameterDeclaration oldParam,
    ExecutableParameterDeclaration newParam,
    Declaration? context,
  ) {
    final changes = <ApiChange>[];
    _comparePropertiesAndAddChange(
      oldParam.isDeprecated,
      newParam.isDeprecated,
      context,
      newParam,
      'Deprecated Flag of ${newParam.name} changed. ${oldParam.isDeprecated ? 'deprecated' : 'not deprecated'} -> ${newParam.isDeprecated ? 'deprecated' : 'not deprecated'}',
      changes,
      isCompatibleChange: true,
    );
    _comparePropertiesAndAddChange(
      oldParam.isNamed,
      newParam.isNamed,
      context,
      newParam,
      'Kind of parameter ${newParam.name} changed. ${oldParam.isNamed ? 'named' : 'not named'} -> ${newParam.isNamed ? 'named' : 'not named'}',
      changes,
    );
    _comparePropertiesAndAddChange(
      oldParam.isRequired,
      newParam.isRequired,
      context,
      newParam,
      'Requiredness of parameter ${newParam.name} changed. ${oldParam.isRequired ? 'required' : 'not required'} -> ${newParam.isRequired ? 'required' : 'not required'}',
      changes,
    );
    _comparePropertiesAndAddChange(
      oldParam.typeName,
      newParam.typeName,
      context,
      newParam,
      'Type of parameter ${newParam.name} changed. ${oldParam.typeName} -> ${newParam.typeName}',
      changes,
    );
    return changes;
  }

  List<ApiChange> _calculateTypeParametersDiff(
    List<String> oldTypeParameterNames,
    List<String> newTypeParameterNames,
    Declaration context,
  ) {
    if (options.ignoreTypeParameterNameChanges) {
      // we only care for the number of type parameters
      if (oldTypeParameterNames.length != newTypeParameterNames.length) {
        return [
          ApiChange(
            context: context,
            affectedDeclaration: context,
            changeDescription:
                'Number of type parameters changed. Before: "${oldTypeParameterNames.join(', ')}" After: "${newTypeParameterNames.join(', ')}"',
            type: oldTypeParameterNames.length < newTypeParameterNames.length
                ? ApiChangeType.addBreaking
                : ApiChangeType.remove,
          ),
        ];
      }
    } else {
      // we have an exact look at the type parameters and even only a name change leads to an API change
      final tpnListDiff = _diffLists<String>(oldTypeParameterNames,
          newTypeParameterNames, (oldTpn, newTpn) => oldTpn == newTpn);
      final changes = <ApiChange>[];
      for (final removedTypeParameter in tpnListDiff.remainingOld) {
        changes.add(ApiChange(
            affectedDeclaration: context,
            context: context,
            type: ApiChangeType.remove,
            changeDescription: 'Type Parameter $removedTypeParameter removed'));
      }
      for (final addedTypeParameter in tpnListDiff.remainingNew) {
        changes.add(ApiChange(
            affectedDeclaration: context,
            context: context,
            type: ApiChangeType.addBreaking,
            changeDescription: 'Type Parameter $addedTypeParameter added'));
      }
      return changes;
    }
    return const [];
  }

  List<ApiChange> _calculateSuperTypesDiff(
    List<String> oldSuperTypes,
    List<String> newSuperTypes,
    Declaration context,
  ) {
    final stpnListDiff = _diffLists<String>(
        oldSuperTypes, newSuperTypes, (oldStpn, newStpn) => oldStpn == newStpn);
    final changes = <ApiChange>[];
    for (final removedSuperType in stpnListDiff.remainingOld) {
      changes.add(ApiChange(
          affectedDeclaration: context,
          context: context,
          type: ApiChangeType.remove,
          changeDescription: 'Super Type $removedSuperType removed'));
    }
    for (final addedSuperType in stpnListDiff.remainingNew) {
      changes.add(ApiChange(
          affectedDeclaration: context,
          context: context,
          type: ApiChangeType.addCompatible,
          changeDescription: 'Super Type $addedSuperType added'));
    }
    return changes;
  }

  List<ApiChange> _calculateFieldsDiff(
    List<FieldDeclaration> oldFieldDeclarations,
    List<FieldDeclaration> newFieldDeclarations,
    Declaration? context,
  ) {
    final fieldsDiff = _diffLists<FieldDeclaration>(
        oldFieldDeclarations,
        newFieldDeclarations,
        (oldField, newField) => oldField.name == newField.name);
    final changes = <ApiChange>[];
    for (final oldField in fieldsDiff.matches.keys) {
      changes.addAll(_calculateFieldDiff(
          oldField, fieldsDiff.matches[oldField]!, context));
    }
    for (final removedField in fieldsDiff.remainingOld) {
      changes.add(ApiChange(
          affectedDeclaration: removedField,
          context: context,
          type: ApiChangeType.remove,
          changeDescription: 'Field ${removedField.name} removed'));
    }
    for (final addedField in fieldsDiff.remainingNew) {
      changes.add(ApiChange(
          affectedDeclaration: addedField,
          context: context,
          type: ApiChangeType.addCompatible,
          changeDescription: 'Field ${addedField.name} added'));
    }
    return changes;
  }

  List<ApiChange> _calculateFieldDiff(
    FieldDeclaration oldField,
    FieldDeclaration newField,
    Declaration? context,
  ) {
    final changes = <ApiChange>[];
    _comparePropertiesAndAddChange(
      oldField.isDeprecated,
      newField.isDeprecated,
      context,
      newField,
      'Deprecated Flag of field ${newField.name} changed',
      changes,
      isCompatibleChange: true,
    );
    _comparePropertiesAndAddChange(
      oldField.typeName,
      newField.typeName,
      context,
      newField,
      'Type of field ${newField.name} changed. ${oldField.typeName} -> ${newField.typeName}',
      changes,
    );
    return changes;
  }

  _comparePropertiesAndAddChange<T>(
    T oldValue,
    T newValue,
    Declaration? context,
    Declaration affectedDeclaration,
    String changeDescription,
    List<ApiChange> changes, {
    bool isCompatibleChange = false,
  }) {
    if (oldValue != newValue) {
      changes.add(ApiChange(
        affectedDeclaration: affectedDeclaration,
        context: context,
        type: isCompatibleChange
            ? ApiChangeType.changeCompatible
            : ApiChangeType.changeBreaking,
        changeDescription: changeDescription,
      ));
    }
  }

  _ListDiffResult<T> _diffLists<T>(List<T> oldList, List<T> newList,
      bool Function(T oldT, T newT) isSameFun) {
    final remainingOld = [...oldList];
    final remainingNew = [...newList];
    final matches = <T, T>{};

    for (final oldItem in oldList) {
      final sameMatches =
          newList.where((newItem) => isSameFun(oldItem, newItem));
      if (sameMatches.isNotEmpty) {
        final matchingNewItem = sameMatches.first;
        remainingOld.remove(oldItem);
        remainingNew.remove(matchingNewItem);

        matches[oldItem] = matchingNewItem;
      }
    }
    return _ListDiffResult(remainingOld, remainingNew, matches);
  }
}

class _ListDiffResult<T> {
  final List<T> remainingOld;
  final List<T> remainingNew;
  final Map<T, T> matches;

  _ListDiffResult(this.remainingOld, this.remainingNew, this.matches);
}

/// Error that gets thrown when an Error happens during diffing two [PackageApi]s
class PackageApiDiffError extends Error {
  final String message;

  PackageApiDiffError({required this.message});
}

/// Represents one API change
class ApiChange {
  /// the context of this change. This can be the class the changed method belongs to or the method the changed parameter belongs to.
  /// is null for situations where there is no context (like root level functions)
  Declaration? context;

  /// The affected declaration. This is the declaration that got changed
  Declaration affectedDeclaration;

  /// Type of change
  ApiChangeType type;

  /// A textual description of the change
  String changeDescription;

  /// creates a new ApiChange instance
  ApiChange({
    required this.context,
    required this.affectedDeclaration,
    required this.changeDescription,
    required this.type,
  });
}

/// represents the type of API change
enum ApiChangeType {
  /// breaking change
  changeBreaking(isBreaking: true),

  /// non-breaking change
  changeCompatible(isBreaking: false),

  /// removal (is always breaking)
  remove(isBreaking: true),

  /// non-breaking addition
  addCompatible(isBreaking: false),

  /// breaking addition (like adding a required parameter)
  addBreaking(isBreaking: true);

  final bool isBreaking;

  const ApiChangeType({required this.isBreaking});
}

/// represents the result of a diff run
class PackageApiDifResult {
  /// API changes that the diff run detected
  final List<ApiChange> apiChanges;

  PackageApiDifResult(this.apiChanges);
}

class PackageApiDifferOptions {
  final bool ignoreTypeParameterNameChanges;

  const PackageApiDifferOptions({this.ignoreTypeParameterNameChanges = true});
}
