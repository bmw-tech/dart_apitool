import 'model/model.dart';

class PackageApiDiffer {
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
        type: ApiChangeType.add,
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
        type: ApiChangeType.add,
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
      'Deprecation Flag for Executable ${newExecutable.name} changed. ${oldExecutable.isDeprecated} -> ${newExecutable.isDeprecated}',
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
    List<ExecutablParameterDeclaration> oldParameters,
    List<ExecutablParameterDeclaration> newParameters,
    Declaration context,
  ) {
    final parametersListDiff = _diffLists<ExecutablParameterDeclaration>(
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
        type: addedParameter.isRequired || !addedParameter.isNamed
            ? ApiChangeType.addRequired
            : ApiChangeType.add,
        changeDescription: 'Parameter ${addedParameter.name} added',
      ));
    }
    return changes;
  }

  List<ApiChange> _calculateParameterDiff(
    ExecutablParameterDeclaration oldParam,
    ExecutablParameterDeclaration newParam,
    Declaration? context,
  ) {
    final changes = <ApiChange>[];
    _comparePropertiesAndAddChange(
      oldParam.isDeprecated,
      newParam.isDeprecated,
      context,
      newParam,
      'Deprecation Flag of ${newParam.name} changed',
      changes,
      isCompatibleChange: true,
    );
    _comparePropertiesAndAddChange(
      oldParam.isNamed,
      newParam.isNamed,
      context,
      newParam,
      'Kind of parameter ${newParam.name} changed',
      changes,
    );
    _comparePropertiesAndAddChange(
      oldParam.isRequired,
      newParam.isRequired,
      context,
      newParam,
      'Requiredness of parameter ${newParam.name} changed',
      changes,
    );
    _comparePropertiesAndAddChange(
      oldParam.typeName,
      newParam.typeName,
      context,
      newParam,
      'Type of parameter ${newParam.name} changed',
      changes,
    );
    return changes;
  }

  List<ApiChange> _calculateTypeParametersDiff(
    List<String> oldTypeParameterNames,
    List<String> newTypeParameterNames,
    Declaration context,
  ) {
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
          type: ApiChangeType.addRequired,
          changeDescription: 'Type Parameter $addedTypeParameter added'));
    }
    return changes;
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
          type: ApiChangeType.add,
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
          type: ApiChangeType.add,
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
      'Deprecation Flag changed',
      changes,
      isCompatibleChange: true,
    );
    _comparePropertiesAndAddChange(
      oldField.typeName,
      newField.typeName,
      context,
      newField,
      'Type changed',
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
            : ApiChangeType.change,
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

class PackageApiDiffError extends Error {
  final String message;

  PackageApiDiffError({required this.message});
}

class ApiChange {
  Declaration? context;
  Declaration affectedDeclaration;
  ApiChangeType type;
  String changeDescription;

  ApiChange({
    required this.context,
    required this.affectedDeclaration,
    required this.changeDescription,
    required this.type,
  });
}

enum ApiChangeType {
  change,
  changeCompatible,
  remove,
  add,
  addRequired,
}

class PackageApiDifResult {
  final List<ApiChange> apiChanges;

  PackageApiDifResult(this.apiChanges);
}
