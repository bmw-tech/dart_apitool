import 'dart:math';

import 'package:stack/stack.dart';

import '../model/model.dart';

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
      ..._calculateClassesDiff(oldApi.classDeclarations,
          newApi.classDeclarations, Stack<Declaration>()),
      ..._calculateExecutablesDiff(
        oldApi.executableDeclarations,
        newApi.executableDeclarations,
        Stack<Declaration>(),
      ),
      ..._calculateFieldsDiff(
        oldApi.fieldDeclarations,
        newApi.fieldDeclarations,
        Stack<Declaration>(),
      ),
    ];

    return PackageApiDifResult()..addApiChanges(changes);
  }

  List<ApiChange> _calculateClassesDiff(List<ClassDeclaration> oldClasses,
      List<ClassDeclaration> newClasses, Stack<Declaration> context) {
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
        context,
      ));
    }
    for (final removedClass in classListDiff.remainingOld) {
      changes.add(ApiChange(
        affectedDeclaration: removedClass,
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.remove,
        changeDescription: 'Class "${removedClass.name}" removed',
      ));
    }
    for (final addedClass in classListDiff.remainingNew) {
      changes.add(ApiChange(
        affectedDeclaration: addedClass,
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.addCompatible,
        changeDescription: 'Class "${addedClass.name}" added',
      ));
    }
    return changes;
  }

  List<ApiChange> _calculateClassDiff(
    ClassDeclaration oldClass,
    ClassDeclaration newClass,
    Stack<Declaration> context,
  ) {
    return _executeInContext(context, newClass, (context) {
      final changes = [
        ..._calculateExecutablesDiff(oldClass.executableDeclarations,
            newClass.executableDeclarations, context),
        ..._calculateFieldsDiff(
            oldClass.fieldDeclarations, newClass.fieldDeclarations, context),
        ..._calculateSuperTypesDiff(
            oldClass.superTypeNames, newClass.superTypeNames, context),
        ..._calculateTypeParametersDiff(
            oldClass.typeParameterNames, newClass.typeParameterNames, context),
      ];

      _comparePropertiesAndAddChange(
        oldClass.isDeprecated,
        newClass.isDeprecated,
        context,
        newClass,
        'Deprecated Flag changed. ${oldClass.isDeprecated} -> ${newClass.isDeprecated}',
        changes,
        isCompatibleChange: true,
      );

      return changes;
    });
  }

  List<ApiChange> _calculateExecutablesDiff(
    List<ExecutableDeclaration> oldExecutables,
    List<ExecutableDeclaration> newExecutables,
    Stack<Declaration> context,
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
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.remove,
        changeDescription:
            '${_getExecutableTypeName(removedExecutable.type, context.isNotEmpty)} "${removedExecutable.name}" removed',
      ));
    }
    for (final addedExecutable in executableListDiff.remainingNew) {
      changes.add(ApiChange(
        affectedDeclaration: addedExecutable,
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.addCompatible,
        changeDescription:
            '${_getExecutableTypeName(addedExecutable.type, context.isNotEmpty)} "${addedExecutable.name}" added',
      ));
    }
    return changes;
  }

  String _getExecutableTypeName(ExecutableType type, bool inClassContext) {
    switch (type) {
      case ExecutableType.constructor:
        return 'Constructor';
      case ExecutableType.method:
        return inClassContext ? 'Method' : 'Function';
    }
  }

  List<ApiChange> _calculateExecutableDiff(
    ExecutableDeclaration oldExecutable,
    ExecutableDeclaration newExecutable,
    Stack<Declaration> context,
  ) {
    return _executeInContext(context, newExecutable, (context) {
      final changes = [
        ..._calculateParametersDiff(
            oldExecutable.parameters, newExecutable.parameters, context),
        ..._calculateTypeParametersDiff(oldExecutable.typeParameterNames,
            newExecutable.typeParameterNames, context),
      ];
      _comparePropertiesAndAddChange(
        oldExecutable.isDeprecated,
        newExecutable.isDeprecated,
        context,
        newExecutable,
        'Deprecated Flag changed. ${oldExecutable.isDeprecated} -> ${newExecutable.isDeprecated}',
        changes,
        isCompatibleChange: true,
      );
      _comparePropertiesAndAddChange(
        oldExecutable.returnTypeName,
        newExecutable.returnTypeName,
        context,
        newExecutable,
        'Return type changed. ${oldExecutable.returnTypeName} -> ${newExecutable.returnTypeName}',
        changes,
      );

      return changes;
    });
  }

  Map<ExecutableParameterDeclaration, ExecutableParameterDeclaration>
      _findMatchesByName(
    List<ExecutableParameterDeclaration> oldParameters,
    List<ExecutableParameterDeclaration> newParameters,
  ) {
    final result =
        <ExecutableParameterDeclaration, ExecutableParameterDeclaration>{};
    for (final oldParameter in oldParameters) {
      for (final matchingNewParameter in newParameters
          .where((newParameter) => newParameter.name == oldParameter.name)) {
        result[oldParameter] = matchingNewParameter;
      }
    }
    return result;
  }

  Map<ExecutableParameterDeclaration, ExecutableParameterDeclaration>
      _findMatchesByTypeOrder(
    List<ExecutableParameterDeclaration> oldParameters,
    List<ExecutableParameterDeclaration> newParameters,
  ) {
    final result =
        <ExecutableParameterDeclaration, ExecutableParameterDeclaration>{};
    int length = min(oldParameters.length, newParameters.length);
    for (int i = 0; i < length; i++) {
      if (oldParameters[i].typeName != newParameters[i].typeName) {
        // if we find a mismatch, immediately stop as we might face a reordering
        return result;
      }
      result[oldParameters[i]] = newParameters[i];
    }
    return result;
  }

  Map<ExecutableParameterDeclaration, ExecutableParameterDeclaration>
      _findMatchingParameters(
    List<ExecutableParameterDeclaration> oldParameters,
    List<ExecutableParameterDeclaration> newParameters,
  ) {
    final oldParametersCopy = [...oldParameters];
    final newParametersCopy = [...newParameters];
    // 1st, find matching names
    final matchedByName =
        _findMatchesByName(oldParametersCopy, newParametersCopy);
    // 2. remove them from the list
    for (final matchedOldParameter in matchedByName.keys) {
      oldParametersCopy.remove(matchedOldParameter);
      newParametersCopy.remove(matchedByName[matchedOldParameter]!);
    }
    // 2. find matching types in order
    final matchedByTypeOrder =
        _findMatchesByTypeOrder(oldParametersCopy, newParametersCopy);
    final result =
        <ExecutableParameterDeclaration, ExecutableParameterDeclaration>{};
    result.addAll(matchedByName);
    result.addAll(matchedByTypeOrder);
    return result;
  }

  List<ApiChange> _calculateParametersDiff(
    List<ExecutableParameterDeclaration> oldParameters,
    List<ExecutableParameterDeclaration> newParameters,
    Stack<Declaration> context,
  ) {
    final parameterMatches =
        _findMatchingParameters(oldParameters, newParameters);

    final changes = <ApiChange>[];
    final oldParametersCopy = [...oldParameters];
    final newParametersCopy = [...newParameters];

    for (final matchingOldParam in parameterMatches.keys) {
      final matchingNewParam = parameterMatches[matchingOldParam]!;
      oldParametersCopy.remove(matchingOldParam);
      newParametersCopy.remove(matchingNewParam);
      changes.addAll(
          _calculateParameterDiff(matchingOldParam, matchingNewParam, context));
    }

    // treat the rest classically
    final parametersListDiff = _diffLists<ExecutableParameterDeclaration>(
        oldParametersCopy,
        newParametersCopy,
        (oldParam, newParam) => oldParam.name == newParam.name);
    for (final oldParam in parametersListDiff.matches.keys) {
      changes.addAll(_calculateParameterDiff(
          oldParam, parametersListDiff.matches[oldParam]!, context));
    }
    for (final removedParameter in parametersListDiff.remainingOld) {
      changes.add(ApiChange(
        affectedDeclaration: context.top(),
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.remove,
        changeDescription: 'Parameter "${removedParameter.name}" removed',
      ));
    }
    for (final addedParameter in parametersListDiff.remainingNew) {
      changes.add(ApiChange(
        affectedDeclaration: context.top(),
        contextTrace: _contextTraceFromStack(context),
        type: addedParameter.isRequired
            ? ApiChangeType.addBreaking
            : ApiChangeType.addCompatible,
        changeDescription: 'Parameter "${addedParameter.name}" added',
      ));
    }

    final orderCheckOldParameters = [...oldParameters];
    final orderCheckNewParameters = [...newParameters];

    // remove removed parameters from oldParameters
    for (final removedParameter in parametersListDiff.remainingOld) {
      orderCheckOldParameters.remove(removedParameter);
    }
    // remove added parameters from newParameters
    for (final addedParameter in parametersListDiff.remainingNew) {
      orderCheckNewParameters.remove(addedParameter);
    }
    assert(orderCheckNewParameters.length == orderCheckOldParameters.length,
        'Huston, we have a problem. Something in the parameter matching is badly wrong');

    // check order
    for (int i = 0; i < orderCheckNewParameters.length; i++) {
      if (orderCheckNewParameters[i].name != orderCheckOldParameters[i].name) {
        if (orderCheckNewParameters[i].typeName ==
            orderCheckOldParameters[i].typeName) {
          // we assume a name change, order is unaffected
          continue;
        }
        changes.add(ApiChange(
          affectedDeclaration: context.top(),
          contextTrace: _contextTraceFromStack(context),
          type: ApiChangeType.changeBreaking,
          changeDescription: 'Order of parameters changed',
        ));
        break;
      }
    }

    return changes;
  }

  List<ApiChange> _calculateParameterDiff(
    ExecutableParameterDeclaration oldParam,
    ExecutableParameterDeclaration newParam,
    Stack<Declaration> context,
  ) {
    final changes = <ApiChange>[];
    _comparePropertiesAndAddChange(
      oldParam.name,
      newParam.name,
      context,
      newParam,
      'Name of parameter "${oldParam.name}" changed. ${oldParam.name} -> ${newParam.name}',
      changes,
      isCompatibleChange: !oldParam
          .isNamed, // as long as the parameter isn't named a name change is not breaking
    );
    _comparePropertiesAndAddChange(
      oldParam.isDeprecated,
      newParam.isDeprecated,
      context,
      newParam,
      'Deprecated Flag of parameter "${oldParam.name}" changed. ${oldParam.isDeprecated ? 'deprecated' : 'not deprecated'} -> ${newParam.isDeprecated ? 'deprecated' : 'not deprecated'}',
      changes,
      isCompatibleChange: true,
    );
    _comparePropertiesAndAddChange(
      oldParam.isNamed,
      newParam.isNamed,
      context,
      newParam,
      'Kind of parameter "${oldParam.name}" changed. ${oldParam.isNamed ? 'named' : 'not named'} -> ${newParam.isNamed ? 'named' : 'not named'}',
      changes,
    );
    _comparePropertiesAndAddChange(
      oldParam.isRequired,
      newParam.isRequired,
      context,
      newParam,
      'Requiredness of parameter "${oldParam.name}" changed. ${oldParam.isRequired ? 'required' : 'not required'} -> ${newParam.isRequired ? 'required' : 'not required'}',
      changes,
    );
    _comparePropertiesAndAddChange(
      oldParam.typeName,
      newParam.typeName,
      context,
      newParam,
      'Type of parameter "${oldParam.name}" changed. ${oldParam.typeName} -> ${newParam.typeName}',
      changes,
    );
    return changes;
  }

  List<ApiChange> _calculateTypeParametersDiff(
    List<String> oldTypeParameterNames,
    List<String> newTypeParameterNames,
    Stack<Declaration> context,
  ) {
    if (options.ignoreTypeParameterNameChanges) {
      // we only care for the number of type parameters
      if (oldTypeParameterNames.length != newTypeParameterNames.length) {
        return [
          ApiChange(
            contextTrace: _contextTraceFromStack(context),
            affectedDeclaration: context.top(),
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
            affectedDeclaration: context.top(),
            contextTrace: _contextTraceFromStack(context),
            type: ApiChangeType.remove,
            changeDescription:
                'Type Parameter "$removedTypeParameter" removed'));
      }
      for (final addedTypeParameter in tpnListDiff.remainingNew) {
        changes.add(ApiChange(
            affectedDeclaration: context.top(),
            contextTrace: _contextTraceFromStack(context),
            type: ApiChangeType.addBreaking,
            changeDescription: 'Type Parameter "$addedTypeParameter" added'));
      }
      return changes;
    }
    return const [];
  }

  List<ApiChange> _calculateSuperTypesDiff(
    List<String> oldSuperTypes,
    List<String> newSuperTypes,
    Stack<Declaration> context,
  ) {
    final stpnListDiff = _diffLists<String>(
        oldSuperTypes, newSuperTypes, (oldStpn, newStpn) => oldStpn == newStpn);
    final changes = <ApiChange>[];
    for (final removedSuperType in stpnListDiff.remainingOld) {
      changes.add(ApiChange(
          affectedDeclaration: context.top(),
          contextTrace: _contextTraceFromStack(context),
          type: ApiChangeType.remove,
          changeDescription: 'Super Type "$removedSuperType" removed'));
    }
    for (final addedSuperType in stpnListDiff.remainingNew) {
      changes.add(ApiChange(
          affectedDeclaration: context.top(),
          contextTrace: _contextTraceFromStack(context),
          type: ApiChangeType.addCompatible,
          changeDescription: 'Super Type "$addedSuperType" added'));
    }
    return changes;
  }

  List<ApiChange> _calculateFieldsDiff(
    List<FieldDeclaration> oldFieldDeclarations,
    List<FieldDeclaration> newFieldDeclarations,
    Stack<Declaration> context,
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
          contextTrace: _contextTraceFromStack(context),
          type: ApiChangeType.remove,
          changeDescription: 'Field "${removedField.name}" removed'));
    }
    for (final addedField in fieldsDiff.remainingNew) {
      changes.add(ApiChange(
          affectedDeclaration: addedField,
          contextTrace: _contextTraceFromStack(context),
          type: ApiChangeType.addCompatible,
          changeDescription: 'Field "${addedField.name}" added'));
    }
    return changes;
  }

  List<ApiChange> _calculateFieldDiff(
    FieldDeclaration oldField,
    FieldDeclaration newField,
    Stack<Declaration> context,
  ) {
    return _executeInContext(context, newField, (context) {
      final changes = <ApiChange>[];
      _comparePropertiesAndAddChange(
        oldField.isDeprecated,
        newField.isDeprecated,
        context,
        newField,
        'Deprecated Flag changed. ${oldField.isDeprecated} -> ${newField.isDeprecated}',
        changes,
        isCompatibleChange: true,
      );
      _comparePropertiesAndAddChange(
        oldField.typeName,
        newField.typeName,
        context,
        newField,
        'Type of field changed. ${oldField.typeName} -> ${newField.typeName}',
        changes,
      );
      return changes;
    });
  }

  List<Declaration> _contextTraceFromStack(Stack<Declaration> stack) {
    final reverseBackup = Stack<Declaration>();
    final result = <Declaration>[];
    while (stack.isNotEmpty) {
      final contextEntry = stack.pop();
      reverseBackup.push(contextEntry);
      result.add(contextEntry);
    }
    while (reverseBackup.isNotEmpty) {
      stack.push(reverseBackup.pop());
    }
    return result;
  }

  T _executeInContext<T>(Stack<Declaration> context, Declaration newContext,
      T Function(Stack<Declaration> context) fun) {
    context.push(newContext);
    final result = fun(context);
    context.pop();
    return result;
  }

  _comparePropertiesAndAddChange<T>(
    T oldValue,
    T newValue,
    Stack<Declaration> context,
    Declaration affectedDeclaration,
    String changeDescription,
    List<ApiChange> changes, {
    bool isCompatibleChange = false,
  }) {
    if (oldValue != newValue) {
      changes.add(ApiChange(
        affectedDeclaration: affectedDeclaration,
        contextTrace: _contextTraceFromStack(context),
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
  final List<Declaration> contextTrace;

  /// The affected declaration. This is the declaration that got changed
  final Declaration affectedDeclaration;

  /// Type of change
  final ApiChangeType type;

  /// A textual description of the change
  final String changeDescription;

  /// creates a new ApiChange instance
  ApiChange({
    required this.contextTrace,
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

class ApiChangeTreeNode {
  final Declaration? nodeDeclaration;
  final List<ApiChange> changes;
  final Map<Declaration, ApiChangeTreeNode> children;

  ApiChangeTreeNode({
    required this.nodeDeclaration,
    List<ApiChange>? changes,
  })  : changes = changes ?? [],
        children = {};
}

/// represents the result of a diff run
class PackageApiDifResult {
  /// API changes that the diff run detected
  final List<ApiChange> apiChanges;

  bool get hasChanges {
    return apiChanges.isNotEmpty;
  }

  final rootNode = ApiChangeTreeNode(nodeDeclaration: null);

  void addApiChange(ApiChange change) {
    var currentNode = rootNode;
    for (int i = change.contextTrace.length - 1; i >= 0; i--) {
      final currentContext = change.contextTrace[i];
      if (!currentNode.children.containsKey(currentContext)) {
        currentNode.children[currentContext] =
            ApiChangeTreeNode(nodeDeclaration: currentContext);
      }
      currentNode = currentNode.children[currentContext]!;
    }
    currentNode.changes.add(change);
    apiChanges.add(change);
  }

  void addApiChanges(Iterable<ApiChange> changes) {
    for (final change in changes) {
      addApiChange(change);
    }
  }

  PackageApiDifResult() : apiChanges = [];
}

class PackageApiDifferOptions {
  final bool ignoreTypeParameterNameChanges;

  const PackageApiDifferOptions({this.ignoreTypeParameterNameChanges = true});
}
