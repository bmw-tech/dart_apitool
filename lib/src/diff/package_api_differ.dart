import 'dart:math';

import 'package:collection/collection.dart';
import 'package:stack/stack.dart';
import 'package:tuple/tuple.dart';

import '../model/model.dart';
import '../errors/errors.dart';
import '../model/package_api_semantics.dart';

/// can calculate a diff between two PackageApis
class PackageApiDiffer {
  final PackageApiDifferOptions options;

  PackageApiDiffer({
    this.options = const PackageApiDifferOptions(
      ignoreTypeParameterNameChanges: true,
    ),
  });

  /// calculates a diff between [oldApi] and [newApi]
  PackageApiDiffResult diff({
    required PackageApi oldApi,
    required PackageApi newApi,
  }) {
    if (oldApi.packageName != newApi.packageName) {
      throw PackageApiDiffError(
          message:
              'Got different packages. Can\'t create diff. Old Package = "${oldApi.packageName}", New Package = "${newApi.packageName}"');
    }

    if (!SetEquality<PackageApiSemantics>()
        .equals(oldApi.semantics, newApi.semantics)) {
      throw PackageApiDiffError(
          message:
              'Given models have different semantics. Old Package: ${oldApi.semantics}, New Package: ${newApi.semantics}');
    }

    try {
      final changes = [
        ..._calculateInterfacesDiff(oldApi.interfaceDeclarations,
            newApi.interfaceDeclarations, Stack<Declaration>()),
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
        ..._calculateIOSPlatformConstraintsDiff(
          oldApi.iosPlatformConstraints,
          newApi.iosPlatformConstraints,
        ),
        ..._calculateAndroidPlatformConstraintsDiff(
          oldApi.androidPlatformConstraints,
          newApi.androidPlatformConstraints,
        ),
        if (options.doCheckSdkVersion)
          ..._calculateSdkDiff(
            oldApi,
            newApi,
          ),
      ];

      return PackageApiDiffResult()..addApiChanges(changes);
    } on Object catch (e, t) {
      throw PackageApiDiffError(
          message: 'Error while creating the diff: $e $t');
    }
  }

  List<ApiChange> _calculateInterfacesDiff(
      List<InterfaceDeclaration> oldInterfaces,
      List<InterfaceDeclaration> newInterfaces,
      Stack<Declaration> context) {
    final interfaceListDiff = _diffIterables<InterfaceDeclaration>(
      oldInterfaces,
      newInterfaces,
      (oldInterface, newInterface) => oldInterface.name == newInterface.name,
    );
    final changes = <ApiChange>[];
    for (final oldInterface in interfaceListDiff.matches.keys) {
      changes.addAll(_calculateInterfaceDiff(
        oldInterface,
        interfaceListDiff.matches[oldInterface]!,
        context,
      ));
    }
    for (final removedInterface in interfaceListDiff.remainingOld) {
      changes.add(ApiChange(
        affectedDeclaration: removedInterface,
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.remove,
        changeDescription: 'Interface "${removedInterface.name}" removed',
      ));
    }
    for (final addedInterface in interfaceListDiff.remainingNew) {
      changes.add(ApiChange(
        affectedDeclaration: addedInterface,
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.addCompatible,
        changeDescription: 'Interface "${addedInterface.name}" added',
      ));
    }
    return changes;
  }

  List<ApiChange> _calculateInterfaceDiff(
    InterfaceDeclaration oldInterface,
    InterfaceDeclaration newInterface,
    Stack<Declaration> context,
  ) {
    return _executeInContext(context, newInterface, (context) {
      final changes = [
        ..._calculateExecutablesDiff(oldInterface.executableDeclarations,
            newInterface.executableDeclarations, context),
        ..._calculateFieldsDiff(oldInterface.fieldDeclarations,
            newInterface.fieldDeclarations, context),
        ..._calculateSuperTypesDiff(
            oldInterface.superTypeNames, newInterface.superTypeNames, context),
        ..._calculateTypeParametersDiff(oldInterface.typeParameterNames,
            newInterface.typeParameterNames, context),
        ..._calculateEntryPointsDiff(
            oldInterface.entryPoints, newInterface.entryPoints, context)
      ];

      _comparePropertiesAndAddChange(
        oldInterface.isDeprecated,
        newInterface.isDeprecated,
        context,
        newInterface,
        'Deprecated Flag changed. ${oldInterface.isDeprecated} -> ${newInterface.isDeprecated}',
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
    final executableListDiff = _diffIterables<ExecutableDeclaration>(
        oldExecutables,
        newExecutables,
        (oldEx, newEx) => oldEx.name == newEx.name);
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

  String _getExecutableTypeName(ExecutableType type, bool inInterfaceContext) {
    switch (type) {
      case ExecutableType.constructor:
        return 'Constructor';
      case ExecutableType.method:
        return inInterfaceContext ? 'Method' : 'Function';
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
      _comparePropertiesAndAddChange(
        oldExecutable.isStatic,
        newExecutable.isStatic,
        context,
        newExecutable,
        'Static specifier changed. ${oldExecutable.isStatic} -> ${newExecutable.isStatic}',
        changes,
      );
      changes.addAll(_calculateEntryPointsDiff(
        oldExecutable.entryPoints,
        newExecutable.entryPoints,
        context,
      ));

      return changes;
    });
  }

  /// returns a [Tuple2] containing
  /// - a [bool] indicating that the order between old and new changed amd
  /// - a [Map] between old parameters and new parameters that match
  Tuple2<bool,
          Map<ExecutableParameterDeclaration, ExecutableParameterDeclaration>>
      _findMatchesByName(
    List<ExecutableParameterDeclaration> oldParameters,
    List<ExecutableParameterDeclaration> newParameters,
  ) {
    bool reordered = false;
    final oldParametersWithoutNamed =
        oldParameters.where((oldParameter) => !oldParameter.isNamed).toList();
    final newParametersWithoutNamed =
        newParameters.where((newParameter) => !newParameter.isNamed).toList();

    final result =
        <ExecutableParameterDeclaration, ExecutableParameterDeclaration>{};

    for (final oldParameter in oldParameters) {
      for (final matchingNewParameter in newParameters
          .where((newParameter) => newParameter.name == oldParameter.name)) {
        // Only for positional arguments: check the order
        if (!oldParameter.isNamed &&
            !matchingNewParameter.isNamed &&
            oldParametersWithoutNamed.indexOf(oldParameter) !=
                newParametersWithoutNamed.indexOf(matchingNewParameter)) {
          reordered = true;
        }
        result[oldParameter] = matchingNewParameter;
      }
    }
    return Tuple2(reordered, result);
  }

  /// returns a [Map] between old parameters and new parameters that match
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
        // if we find a mismatch, immediately stop as we might face a reordering (but doesn't have to be, could also be a type change)
        return result;
      }
      result[oldParameters[i]] = newParameters[i];
    }
    return result;
  }

  /// returns a [Tuple2] containing
  /// - a [bool] indicating that the order between old and new changed amd
  /// - a [Map] between old parameters and new parameters that match
  Tuple2<bool,
          Map<ExecutableParameterDeclaration, ExecutableParameterDeclaration>>
      _findMatchingParameters(
    List<ExecutableParameterDeclaration> oldParameters,
    List<ExecutableParameterDeclaration> newParameters,
  ) {
    final oldParametersCopy = [...oldParameters];
    final newParametersCopy = [...newParameters];
    // 1st, find matching names
    final matchedByNameTuple =
        _findMatchesByName(oldParametersCopy, newParametersCopy);
    final reordered = matchedByNameTuple.item1;
    final matchedByName = matchedByNameTuple.item2;
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
    return Tuple2(reordered, result);
  }

  List<ApiChange> _calculateParametersDiff(
    List<ExecutableParameterDeclaration> oldParameters,
    List<ExecutableParameterDeclaration> newParameters,
    Stack<Declaration> context,
  ) {
    final parameterMatchesTuple =
        _findMatchingParameters(oldParameters, newParameters);
    final parameterMatches = parameterMatchesTuple.item2;
    final reordered = parameterMatchesTuple.item1;

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

    // the remaining old parameters have most probably be removed and the remaining
    // new parameters have most probably been added as parameters with equal name
    // already got matched by [_findMatchingParameters]
    for (final removedParameter in oldParametersCopy) {
      changes.add(ApiChange(
        affectedDeclaration: context.top(),
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.remove,
        changeDescription: 'Parameter "${removedParameter.name}" removed',
      ));
    }
    for (final addedParameter in newParametersCopy) {
      changes.add(ApiChange(
        affectedDeclaration: context.top(),
        contextTrace: _contextTraceFromStack(context),
        type: addedParameter.isRequired
            ? ApiChangeType.addBreaking
            : ApiChangeType.addCompatible,
        changeDescription: 'Parameter "${addedParameter.name}" added',
      ));
    }

    if (reordered) {
      changes.add(ApiChange(
        affectedDeclaration: context.top(),
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.changeBreaking,
        changeDescription: 'Order of parameters changed',
      ));
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
      isCompatibleChange: oldParam
          .isRequired, // if we change from required to not required then this change is compatible
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

  List<ApiChange> _calculateEntryPointsDiff(Set<String>? oldEntryPoints,
      Set<String>? newEntryPoints, Stack<Declaration> context) {
    if (oldEntryPoints == null || newEntryPoints == null) {
      // either old or new entry points are not known => we can't compare them
      return [];
    }
    final changes = List<ApiChange>.empty(growable: true);
    final diffResult = _diffIterables(
      oldEntryPoints,
      newEntryPoints,
      (oldT, newT) => oldT == newT,
      doOrderBeforeComparing: true,
    );
    for (final newEntryPoint in diffResult.remainingNew) {
      changes.add(ApiChange(
        contextTrace: _contextTraceFromStack(context),
        affectedDeclaration: context.top(),
        changeDescription: 'New entry point: $newEntryPoint',
        type: ApiChangeType.addCompatible,
      ));
    }
    for (final oldEntryPoint in diffResult.remainingOld) {
      changes.add(ApiChange(
        contextTrace: _contextTraceFromStack(context),
        affectedDeclaration: context.top(),
        changeDescription: 'Entry point removed: $oldEntryPoint',
        type: ApiChangeType.remove,
      ));
    }
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
      final tpnListDiff = _diffIterables<String>(oldTypeParameterNames,
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
    final stpnListDiff = _diffIterables<String>(
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
    final fieldsDiff = _diffIterables<FieldDeclaration>(
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
      _comparePropertiesAndAddChange(
        oldField.isStatic,
        newField.isStatic,
        context,
        newField,
        'Static specifier changed. ${oldField.isStatic} -> ${newField.isStatic}',
        changes,
      );
      changes.addAll(_calculateEntryPointsDiff(
        oldField.entryPoints,
        newField.entryPoints,
        context,
      ));

      return changes;
    });
  }

  List<ApiChange> _calculateIOSPlatformConstraintsDiff(
      IOSPlatformConstraints? oldConstraints,
      IOSPlatformConstraints? newConstraints) {
    if (oldConstraints == null && newConstraints == null) {
      return [];
    }
    if (oldConstraints == null) {
      return [
        ApiChange(
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.addBreaking,
          changeDescription: 'iOS platform added',
        ),
      ];
    }
    if (newConstraints == null) {
      return [
        ApiChange(
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.remove,
          changeDescription: 'iOS platform removed',
        ),
      ];
    }
    if (oldConstraints.minimumOsVersion != newConstraints.minimumOsVersion) {
      bool isBreaking = true;
      // lowering the minimum OS version is not breaking. The rest is
      if (oldConstraints.minimumOsVersion != null &&
          newConstraints.minimumOsVersion != null &&
          oldConstraints.minimumOsVersion! > newConstraints.minimumOsVersion!) {
        isBreaking = false;
      }
      return [
        ApiChange(
          affectedDeclaration: null,
          contextTrace: [],
          type: isBreaking
              ? ApiChangeType.changeBreaking
              : ApiChangeType.changeCompatible,
          changeDescription:
              'iOS platform minimum version changed from ${oldConstraints.minimumOsVersion} to ${newConstraints.minimumOsVersion}',
        ),
      ];
    }
    return [];
  }

  List<ApiChange> _calculateAndroidPlatformConstraintsDiff(
      AndroidPlatformConstraints? oldConstraints,
      AndroidPlatformConstraints? newConstraints) {
    if (oldConstraints == null && newConstraints == null) {
      return [];
    }
    if (oldConstraints == null) {
      return [
        ApiChange(
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.addBreaking,
          changeDescription: 'Android platform added',
        ),
      ];
    }
    if (newConstraints == null) {
      return [
        ApiChange(
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.remove,
          changeDescription: 'Android platform removed',
        ),
      ];
    }

    addIfChanged(
        int? oldVal, int? newVal, String valName, List<ApiChange> changes) {
      if (oldVal == newVal) {
        return;
      }
      if (oldVal == null) {
        changes.add(ApiChange(
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.addBreaking,
          changeDescription: 'Android platform $valName added',
        ));
        return;
      }
      if (newVal == null) {
        changes.add(ApiChange(
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.remove,
          changeDescription: 'Android platform $valName removed',
        ));
        return;
      }
      bool isBreaking = true;
      // lowering the value is not breaking, the rest is
      if (oldVal > newVal) {
        isBreaking = false;
      }
      changes.add(ApiChange(
        affectedDeclaration: null,
        contextTrace: [],
        type: isBreaking
            ? ApiChangeType.changeBreaking
            : ApiChangeType.changeCompatible,
        changeDescription:
            'Android platform $valName changed from $oldVal to $newVal',
      ));
    }

    List<ApiChange> changes = [];

    addIfChanged(oldConstraints.minSdkVersion, newConstraints.minSdkVersion,
        'minSdkVersion', changes);
    addIfChanged(oldConstraints.targetSdkVersion,
        newConstraints.targetSdkVersion, 'targetSdkVersion', changes);
    addIfChanged(oldConstraints.compileSdkVersion,
        newConstraints.compileSdkVersion, 'compileSdkVersion', changes);

    return changes;
  }

  List<ApiChange> _calculateSdkDiff(PackageApi oldApi, PackageApi newApi) {
    final result = <ApiChange>[];
    if (oldApi.sdkType != newApi.sdkType) {
      result.add(
        ApiChange(
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.changeBreaking,
          changeDescription:
              'SDK type changed from ${oldApi.sdkType} to ${newApi.sdkType}',
        ),
      );
    }
    // lowering the version is no problem => check if new version is higher
    if (oldApi.minSdkVersion < newApi.minSdkVersion) {
      result.add(
        ApiChange(
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.changeBreaking,
          changeDescription:
              'Minimum SDK version changed from ${oldApi.minSdkVersion} to ${newApi.minSdkVersion}',
        ),
      );
    }
    return result;
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

  _ListDiffResult<T> _diffIterables<T>(
    Iterable<T> oldList,
    Iterable<T> newList,
    bool Function(T oldT, T newT) isSameFun, {
    bool doOrderBeforeComparing = false,
  }) {
    final remainingOld = [...oldList];
    final remainingNew = [...newList];
    if (doOrderBeforeComparing) {
      remainingOld.sort();
      remainingNew.sort();
    }
    final matches = <T, T>{};

    for (final oldItem in oldList) {
      final sameMatches =
          newList.where((newItem) => isSameFun(oldItem, newItem));
      if (sameMatches.isNotEmpty) {
        // if we encounter more than one element here then our whole algorithm crashes (multiple items treated as equal)
        // => we use `single` here to make sure that we crash if this happens
        final matchingNewItem = sameMatches.single;
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

/// Represents one API change
class ApiChange {
  /// the context of this change. This can be the class the changed method belongs to or the method the changed parameter belongs to.
  /// is null for situations where there is no context (like root level functions)
  final List<Declaration> contextTrace;

  /// The affected declaration. This is the declaration that got changed
  final Declaration? affectedDeclaration;

  /// Type of change
  final ApiChangeType type;

  /// A textual description of the change
  final String changeDescription;

  /// creates a new ApiChange instance
  ApiChange({
    required this.contextTrace,
    this.affectedDeclaration,
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

/// represents a tree node in the hierarchical change representation
class ApiChangeTreeNode {
  /// the declaration represented by this node
  final Declaration? nodeDeclaration;

  /// the changes [nodeDeclaration] has
  final List<ApiChange> changes;

  /// the children of this node
  final Map<Declaration, ApiChangeTreeNode> children;

  /// creates a new ApiChangeTreeNode instance
  ApiChangeTreeNode({
    required this.nodeDeclaration,
    List<ApiChange>? changes,
  })  : changes = changes ?? [],
        children = {};
}

/// represents the result of a diff run
class PackageApiDiffResult {
  /// API changes that the diff run detected
  final List<ApiChange> apiChanges;

  /// whether this diff result contains any changes
  bool get hasChanges {
    return apiChanges.isNotEmpty;
  }

  /// root node of the hierarchical representation of the changes
  final rootNode = ApiChangeTreeNode(nodeDeclaration: null);

  /// adds an API change. This is used by the [PackageApiDiffer] to add API changes.
  /// This method makes sure that the change is added to the list of changes as well as getting inserted into the hierarchical representation
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

  /// calls [addApiChange] for all [ApiChange]s in [changes]
  void addApiChanges(Iterable<ApiChange> changes) {
    for (final change in changes) {
      addApiChange(change);
    }
  }

  PackageApiDiffResult() : apiChanges = [];
}

/// represents options for the [PackageApiDiffer]
class PackageApiDifferOptions {
  /// whether to ignore type parameter changes
  final bool ignoreTypeParameterNameChanges;

  /// whether to ignore sdk version changes
  final bool doCheckSdkVersion;

  /// creates a new PackageApiDifferOptions instance
  const PackageApiDifferOptions({
    this.ignoreTypeParameterNameChanges = true,
    this.doCheckSdkVersion = true,
  });
}
