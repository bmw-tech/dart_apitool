import 'dart:math';

import 'package:collection/collection.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:stack/stack.dart';
import 'package:tuple/tuple.dart';

import '../model/model.dart';
import '../errors/errors.dart';
import 'api_change.dart';
import 'api_change_code.dart';
import 'api_change_type.dart';
import 'package_api_diff_result.dart';
import 'package_api_differ_options.dart';

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
        ..._calculateInterfacesDiff(
          oldApi.interfaceDeclarations,
          newApi.interfaceDeclarations,
          Stack<Declaration>(),
          isExperimental: false,
          typeHierarchy: newApi.typeHierarchy,
        ),
        ..._calculateExecutablesDiff(
          oldApi.executableDeclarations,
          newApi.executableDeclarations,
          Stack<Declaration>(),
          isExperimental: false,
          typeHierarchy: newApi.typeHierarchy,
        ),
        ..._calculateFieldsDiff(
          oldApi.fieldDeclarations,
          newApi.fieldDeclarations,
          Stack<Declaration>(),
          isExperimental: false,
          typeHierarchy: newApi.typeHierarchy,
        ),
        ..._calculateIOSPlatformConstraintsDiff(
          oldApi.iosPlatformConstraints,
          newApi.iosPlatformConstraints,
          isExperimental: false,
        ),
        ..._calculateAndroidPlatformConstraintsDiff(
          oldApi.androidPlatformConstraints,
          newApi.androidPlatformConstraints,
          isExperimental: false,
        ),
        ..._calculateSdkDiff(
          oldApi,
          newApi,
          isExperimental: false,
          doCheckSdkVersion: options.doCheckSdkVersion,
        ),
        ..._calculatePackageDependenciesDiff(
          oldApi,
          newApi,
          isExperimental: false,
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
    Stack<Declaration> context, {
    required bool isExperimental,
    required TypeHierarchy typeHierarchy,
  }) {
    final interfaceListDiff = _diffIterables<InterfaceDeclaration>(
      oldInterfaces,
      newInterfaces,
      (oldInterface, newInterface) {
        // if the names are not the same, we already have a mismatch
        if (oldInterface.name != newInterface.name) {
          return false;
        }

        // we need to do additional checks as we might have naming conflicts otherwise

        // if the entry points are the same, then we can assume that the interfaces are the same (independent of their relative path)
        if (SetEquality<String>()
            .equals(oldInterface.entryPoints, newInterface.entryPoints)) {
          return true;
        }

        // here the name is equal but we have different entry points.
        // to support detection of entry point changes we consider the interfaces equal if they have the same relative path
        // (only works for top level elements)
        if (context.isEmpty &&
            oldInterface.relativePath == newInterface.relativePath) {
          return true;
        }

        // if we are here then we only consider the interfaces equal (by name) if they are not top-level
        return context.isNotEmpty;
      },
    );
    final changes = <ApiChange>[];
    for (final oldInterface in interfaceListDiff.matches.keys) {
      final newInterface = interfaceListDiff.matches[oldInterface]!;
      changes.addAll(_calculateInterfaceDiff(
        oldInterface,
        newInterface,
        context,
        isExperimental: newInterface.isExperimental || isExperimental,
        typeHierarchy: typeHierarchy,
      ));
    }
    for (final removedInterface in interfaceListDiff.remainingOld) {
      changes.add(ApiChange(
        changeCode: ApiChangeCode.ci01,
        affectedDeclaration: removedInterface,
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.remove,
        isExperimental: isExperimental,
        changeDescription: 'Interface "${removedInterface.name}" removed',
      ));
    }
    for (final addedInterface in interfaceListDiff.remainingNew) {
      changes.add(ApiChange(
        changeCode: ApiChangeCode.ci02,
        affectedDeclaration: addedInterface,
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.addCompatibleMinor,
        isExperimental: isExperimental,
        changeDescription: 'Interface "${addedInterface.name}" added',
      ));
    }
    return changes;
  }

  List<ApiChange> _calculateInterfaceDiff(
    InterfaceDeclaration oldInterface,
    InterfaceDeclaration newInterface,
    Stack<Declaration> context, {
    required bool isExperimental,
    required TypeHierarchy typeHierarchy,
  }) {
    return _executeInContext(context, newInterface, (context) {
      // we treat the new interface as required if it is and we do not ignore the requiredness of interfaces
      final treatNewInterfaceAsRequired =
          newInterface.isRequired && !options.doIgnoreRequiredness;
      final changes = [
        ..._calculateExecutablesDiff(
          oldInterface.executableDeclarations,
          newInterface.executableDeclarations,
          context,
          isInterfaceRequired: treatNewInterfaceAsRequired,
          isExperimental: isExperimental,
          typeHierarchy: typeHierarchy,
        ),
        ..._calculateFieldsDiff(
          oldInterface.fieldDeclarations,
          newInterface.fieldDeclarations,
          context,
          isInterfaceRequired: treatNewInterfaceAsRequired,
          isExperimental: isExperimental,
          typeHierarchy: typeHierarchy,
        ),
        ..._calculateSuperTypesDiff(
          oldInterface.superTypeNames,
          newInterface.superTypeNames,
          context,
          isExperimental: isExperimental,
        ),
        ..._calculateTypeParametersDiff(
          oldInterface.typeParameterNames,
          newInterface.typeParameterNames,
          context,
          isInterfaceRequired: treatNewInterfaceAsRequired,
          isExperimental: isExperimental,
        ),
        ..._calculateEntryPointsDiff(
          oldInterface.entryPoints,
          newInterface.entryPoints,
          context,
          isExperimental: isExperimental,
        )
      ];

      _comparePropertiesAndAddChange(
        oldInterface.isDeprecated,
        newInterface.isDeprecated,
        context,
        newInterface,
        'Deprecated Flag changed. ${oldInterface.isDeprecated} -> ${newInterface.isDeprecated}',
        changes,
        isCompatibleChange: true,
        changeCode: ApiChangeCode.ci09,
        isExperimental: isExperimental,
      );
      _comparePropertiesAndAddChange(
        oldInterface.isExperimental,
        newInterface.isExperimental,
        context,
        newInterface,
        'Experimental Flag changed. ${oldInterface.isExperimental} -> ${newInterface.isExperimental}',
        changes,
        isCompatibleChange: !newInterface
            .isExperimental, //this is only non-breaking if the experimental flag is removed or the interface is experimental
        changeCode: ApiChangeCode.ci10,
        isExperimental:
            false, //we don't pass the experimental flag here because this would cause in a non-breaking change when the flag is added
      );
      _comparePropertiesAndAddChange(
        oldInterface.isSealed,
        newInterface.isSealed,
        context,
        newInterface,
        'Sealed Flag changed. ${oldInterface.isSealed} -> ${newInterface.isSealed}',
        changes,
        isCompatibleChange: !newInterface
            .isSealed, //this is only non-breaking if the sealed flag is removed
        changeCode: ApiChangeCode.ci11,
        isExperimental: isExperimental,
      );

      return changes;
    });
  }

  List<ApiChange> _calculateExecutablesDiff(
    List<ExecutableDeclaration> oldExecutables,
    List<ExecutableDeclaration> newExecutables,
    Stack<Declaration> context, {
    bool? isInterfaceRequired,
    required bool isExperimental,
    required TypeHierarchy typeHierarchy,
  }) {
    final executableListDiff = _diffIterables<ExecutableDeclaration>(
      oldExecutables,
      newExecutables,
      (oldEx, newEx) =>
          // for top level elements we have to consider the path as well as we might run into duplicate namings otherwise
          oldEx.name == newEx.name &&
          (context.isNotEmpty || oldEx.relativePath == newEx.relativePath),
    );
    final changes = <ApiChange>[];
    for (final oldEx in executableListDiff.matches.keys) {
      final newEx = executableListDiff.matches[oldEx]!;
      changes.addAll(
        _calculateExecutableDiff(
          oldEx,
          newEx,
          context,
          isInterfaceRequired: isInterfaceRequired,
          isExperimental: newEx.isExperimental || isExperimental,
          typeHierarchy: typeHierarchy,
        ),
      );
    }
    for (final removedExecutable in executableListDiff.remainingOld) {
      changes.add(
        ApiChange(
          changeCode: ApiChangeCode.ce10,
          affectedDeclaration: removedExecutable,
          contextTrace: _contextTraceFromStack(context),
          type: ApiChangeType.remove,
          isExperimental: isExperimental,
          changeDescription:
              '${_getExecutableTypeName(removedExecutable.type, context.isNotEmpty)} "${removedExecutable.name}" removed',
        ),
      );
    }
    for (final addedExecutable in executableListDiff.remainingNew) {
      changes.add(
        ApiChange(
          changeCode: ApiChangeCode.ce11,
          affectedDeclaration: addedExecutable,
          contextTrace: _contextTraceFromStack(context),
          type: (isInterfaceRequired ?? false) && !addedExecutable.isStatic
              ? ApiChangeType.addBreaking
              : ApiChangeType.addCompatibleMinor,
          isExperimental: isExperimental,
          changeDescription:
              '${_getExecutableTypeName(addedExecutable.type, context.isNotEmpty)} "${addedExecutable.name}" added${(isInterfaceRequired ?? false) ? ' (required)' : ''}',
        ),
      );
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
    Stack<Declaration> context, {
    bool? isInterfaceRequired,
    required bool isExperimental,
    required TypeHierarchy typeHierarchy,
  }) {
    return _executeInContext(context, newExecutable, (context) {
      final changes = [
        ..._calculateParametersDiff(
          oldExecutable.parameters,
          newExecutable.parameters,
          context,
          isInterfaceRequired: isInterfaceRequired,
          isExperimental: isExperimental,
          typeHierarchy: typeHierarchy,
        ),
        ..._calculateTypeParametersDiff(
          oldExecutable.typeParameterNames,
          newExecutable.typeParameterNames,
          context,
          isExperimental: isExperimental,
        ),
      ];
      _comparePropertiesAndAddChange(
        oldExecutable.isDeprecated,
        newExecutable.isDeprecated,
        context,
        newExecutable,
        'Deprecated Flag changed. ${oldExecutable.isDeprecated} -> ${newExecutable.isDeprecated}',
        changes,
        isCompatibleChange: true,
        changeCode: ApiChangeCode.ce13,
        isExperimental: isExperimental,
      );
      _comparePropertiesAndAddChange(
        oldExecutable.isExperimental,
        newExecutable.isExperimental,
        context,
        newExecutable,
        'Experimental Flag changed. ${oldExecutable.isExperimental} -> ${newExecutable.isExperimental}',
        changes,
        isCompatibleChange: !newExecutable
            .isExperimental, //this is only non-breaking if the experimental flag is removed or if we are in an experimental context
        changeCode: ApiChangeCode.ce15,
        isExperimental:
            false, //we don't pass the experimental flag here because this would cause in a non-breaking change when the flag is added
      );

      _comparePropertiesAndAddChange(
        oldExecutable.returnTypeName,
        newExecutable.returnTypeName,
        context,
        newExecutable,
        'Return type changed. ${oldExecutable.returnTypeName} -> ${newExecutable.returnTypeName}',
        changes,
        isCompatibleChange: typeHierarchy.isCompatibleReplacement(
          oldTypeIdentifier: TypeIdentifier.fromNameAndLibraryPath(
            typeName: oldExecutable.returnTypeName,
            libraryPath: oldExecutable.returnTypeFullLibraryName,
          ),
          newTypeIdentifier: TypeIdentifier.fromNameAndLibraryPath(
            typeName: newExecutable.returnTypeName,
            libraryPath: newExecutable.returnTypeFullLibraryName,
          ),
          isTypePassedIn: false,
        ),
        changeCode: ApiChangeCode.ce09,
        isExperimental: isExperimental,
      );
      _comparePropertiesAndAddChange(
        oldExecutable.isStatic,
        newExecutable.isStatic,
        context,
        newExecutable,
        'Static specifier changed. ${oldExecutable.isStatic} -> ${newExecutable.isStatic}',
        changes,
        isCompatibleChange: false,
        changeCode: ApiChangeCode.ce14,
        isExperimental: isExperimental,
      );
      changes.addAll(_calculateEntryPointsDiff(
        oldExecutable.entryPoints,
        newExecutable.entryPoints,
        context,
        isExperimental: isExperimental,
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
    Stack<Declaration> context, {
    bool? isInterfaceRequired,
    required bool isExperimental,
    required TypeHierarchy typeHierarchy,
  }) {
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
        _calculateParameterDiff(
          matchingOldParam,
          matchingNewParam,
          context,
          isExperimental: matchingNewParam.isExperimental,
          typeHierarchy: typeHierarchy,
        ),
      );
    }

    // the remaining old parameters have most probably be removed and the remaining
    // new parameters have most probably been added as parameters with equal name
    // already got matched by [_findMatchingParameters]
    for (final removedParameter in oldParametersCopy) {
      changes.add(ApiChange(
        changeCode: ApiChangeCode.ce01,
        affectedDeclaration: context.top(),
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.remove,
        isExperimental: isExperimental,
        changeDescription: 'Parameter "${removedParameter.name}" removed',
      ));
    }
    for (final addedParameter in newParametersCopy) {
      changes.add(ApiChange(
        changeCode: ApiChangeCode.ce02,
        affectedDeclaration: context.top(),
        contextTrace: _contextTraceFromStack(context),
        type: (isInterfaceRequired ?? false) || addedParameter.isRequired
            ? ApiChangeType.addBreaking
            : ApiChangeType.addCompatibleMinor,
        isExperimental: isExperimental,
        changeDescription:
            'Parameter "${addedParameter.name}" added${(isInterfaceRequired ?? false) ? ' (required)' : ''}',
      ));
    }

    if (reordered) {
      changes.add(ApiChange(
        changeCode: ApiChangeCode.ce04,
        affectedDeclaration: context.top(),
        contextTrace: _contextTraceFromStack(context),
        type: ApiChangeType.changeBreaking,
        isExperimental: isExperimental,
        changeDescription: 'Order of parameters changed',
      ));
    }

    return changes;
  }

  List<ApiChange> _calculateParameterDiff(
    ExecutableParameterDeclaration oldParam,
    ExecutableParameterDeclaration newParam,
    Stack<Declaration> context, {
    required bool isExperimental,
    required TypeHierarchy typeHierarchy,
  }) {
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
      changeCode: ApiChangeCode.ce03,
      isExperimental: isExperimental,
    );
    _comparePropertiesAndAddChange(
      oldParam.isDeprecated,
      newParam.isDeprecated,
      context,
      newParam,
      'Deprecated Flag of parameter "${oldParam.name}" changed. ${oldParam.isDeprecated ? 'deprecated' : 'not deprecated'} -> ${newParam.isDeprecated ? 'deprecated' : 'not deprecated'}',
      changes,
      isCompatibleChange: true,
      changeCode: ApiChangeCode.ce06,
      isExperimental: isExperimental,
    );
    _comparePropertiesAndAddChange(
      oldParam.isExperimental,
      newParam.isExperimental,
      context,
      newParam,
      'Experimental Flag changed. ${oldParam.isExperimental} -> ${newParam.isExperimental}',
      changes,
      isCompatibleChange: !newParam
          .isExperimental, //this is only non-breaking if the experimental flag is removed
      changeCode: ApiChangeCode.ce16,
      isExperimental:
          false, //we don't pass the experimental flag here because this would cause in a non-breaking change when the flag is added
    );
    _comparePropertiesAndAddChange(
      oldParam.isNamed,
      newParam.isNamed,
      context,
      newParam,
      'Kind of parameter "${oldParam.name}" changed. ${oldParam.isNamed ? 'named' : 'not named'} -> ${newParam.isNamed ? 'named' : 'not named'}',
      changes,
      changeCode: ApiChangeCode.ce07,
      isExperimental: isExperimental,
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
      changeCode: ApiChangeCode.ce05,
      isExperimental: isExperimental,
    );
    _compareParameterTypesAndAddChange(
      TypeIdentifier.fromNameAndLibraryPath(
        typeName: oldParam.typeName,
        libraryPath: oldParam.typeFullLibraryName,
      ),
      TypeIdentifier.fromNameAndLibraryPath(
        typeName: newParam.typeName,
        libraryPath: newParam.typeFullLibraryName,
      ),
      context,
      newParam,
      'Type of parameter "${oldParam.name}" changed. ${oldParam.typeName} -> ${newParam.typeName}',
      changes,
      changeCode: ApiChangeCode.ce08,
      isExperimental: isExperimental,
      typeHierarchy: typeHierarchy,
    );
    return changes;
  }

  List<ApiChange> _calculateEntryPointsDiff(
    Set<String>? oldEntryPoints,
    Set<String>? newEntryPoints,
    Stack<Declaration> context, {
    required bool isExperimental,
  }) {
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
        changeCode: ApiChangeCode.cp01,
        contextTrace: _contextTraceFromStack(context),
        affectedDeclaration: context.top(),
        changeDescription: 'New entry point: $newEntryPoint',
        type: ApiChangeType.addCompatibleMinor,
        isExperimental: isExperimental,
      ));
    }
    for (final oldEntryPoint in diffResult.remainingOld) {
      changes.add(ApiChange(
        changeCode: ApiChangeCode.cp02,
        contextTrace: _contextTraceFromStack(context),
        affectedDeclaration: context.top(),
        changeDescription: 'Entry point removed: $oldEntryPoint',
        type: ApiChangeType.remove,
        isExperimental: isExperimental,
      ));
    }
    return changes;
  }

  List<ApiChange> _calculateTypeParametersDiff(
    List<String> oldTypeParameterNames,
    List<String> newTypeParameterNames,
    Stack<Declaration> context, {
    bool? isInterfaceRequired,
    required bool isExperimental,
  }) {
    if (options.ignoreTypeParameterNameChanges) {
      // we only care for the number of type parameters
      if (oldTypeParameterNames.length != newTypeParameterNames.length) {
        return [
          ApiChange(
            changeCode: ApiChangeCode.ci06,
            contextTrace: _contextTraceFromStack(context),
            affectedDeclaration: context.top(),
            type: (isInterfaceRequired ?? false) ||
                    oldTypeParameterNames.length < newTypeParameterNames.length
                ? ApiChangeType.addBreaking
                : ApiChangeType.remove,
            isExperimental: isExperimental,
            changeDescription:
                'Number of type parameters changed. Before: "${oldTypeParameterNames.join(', ')}" After: "${newTypeParameterNames.join(', ')}"${(isInterfaceRequired ?? false) ? ' (required)' : ''}',
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
            changeCode: ApiChangeCode.ci08,
            affectedDeclaration: context.top(),
            contextTrace: _contextTraceFromStack(context),
            type: ApiChangeType.remove,
            isExperimental: isExperimental,
            changeDescription:
                'Type Parameter "$removedTypeParameter" removed'));
      }
      for (final addedTypeParameter in tpnListDiff.remainingNew) {
        changes.add(ApiChange(
            changeCode: ApiChangeCode.ci07,
            affectedDeclaration: context.top(),
            contextTrace: _contextTraceFromStack(context),
            type: ApiChangeType.addBreaking,
            isExperimental: isExperimental,
            changeDescription: 'Type Parameter "$addedTypeParameter" added'));
      }
      return changes;
    }
    return const [];
  }

  List<ApiChange> _calculateSuperTypesDiff(
    Set<String> oldSuperTypes,
    Set<String> newSuperTypes,
    Stack<Declaration> context, {
    required bool isExperimental,
  }) {
    final stpnListDiff = _diffIterables<String>(
        oldSuperTypes, newSuperTypes, (oldStpn, newStpn) => oldStpn == newStpn);
    final changes = <ApiChange>[];
    for (final removedSuperType in stpnListDiff.remainingOld) {
      changes.add(ApiChange(
          changeCode: ApiChangeCode.ci05,
          affectedDeclaration: context.top(),
          contextTrace: _contextTraceFromStack(context),
          type: ApiChangeType.remove,
          isExperimental: isExperimental,
          changeDescription: 'Super Type "$removedSuperType" removed'));
    }
    for (final addedSuperType in stpnListDiff.remainingNew) {
      changes.add(ApiChange(
          changeCode: ApiChangeCode.ci04,
          affectedDeclaration: context.top(),
          contextTrace: _contextTraceFromStack(context),
          type: ApiChangeType.addCompatibleMinor,
          isExperimental: isExperimental,
          changeDescription: 'Super Type "$addedSuperType" added'));
    }
    return changes;
  }

  List<ApiChange> _calculateFieldsDiff(
    List<FieldDeclaration> oldFieldDeclarations,
    List<FieldDeclaration> newFieldDeclarations,
    Stack<Declaration> context, {
    bool? isInterfaceRequired,
    required isExperimental,
    required TypeHierarchy typeHierarchy,
  }) {
    final fieldsDiff = _diffIterables<FieldDeclaration>(
      oldFieldDeclarations,
      newFieldDeclarations,
      (oldField, newField) =>
          // for top level elements we have to consider the path as well as we might run into duplicate namings otherwise
          oldField.name == newField.name &&
          (context.isNotEmpty ||
              oldField.relativePath == newField.relativePath),
    );
    final changes = <ApiChange>[];
    for (final oldField in fieldsDiff.matches.keys) {
      final newField = fieldsDiff.matches[oldField]!;
      changes.addAll(
        _calculateFieldDiff(
          oldField,
          newField,
          context,
          isExperimental: newField.isExperimental || isExperimental,
          typeHierarchy: typeHierarchy,
        ),
      );
    }
    for (final removedField in fieldsDiff.remainingOld) {
      changes.add(ApiChange(
          changeCode: ApiChangeCode.cf01,
          affectedDeclaration: removedField,
          contextTrace: _contextTraceFromStack(context),
          type: ApiChangeType.remove,
          isExperimental: isExperimental,
          changeDescription: 'Field "${removedField.name}" removed'));
    }
    for (final addedField in fieldsDiff.remainingNew) {
      changes.add(ApiChange(
          changeCode: ApiChangeCode.cf02,
          affectedDeclaration: addedField,
          contextTrace: _contextTraceFromStack(context),
          type: (isInterfaceRequired ?? false) &&
                  !addedField.isStatic &&
                  !addedField.isConst
              ? ApiChangeType.addBreaking
              : ApiChangeType.addCompatibleMinor,
          isExperimental: isExperimental,
          changeDescription:
              'Field "${addedField.name}" added${(isInterfaceRequired ?? false) ? ' (required)' : ''}'));
    }
    return changes;
  }

  List<ApiChange> _calculateFieldDiff(
    FieldDeclaration oldField,
    FieldDeclaration newField,
    Stack<Declaration> context, {
    required bool isExperimental,
    required TypeHierarchy typeHierarchy,
  }) {
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
        changeCode: ApiChangeCode.cf03,
        isExperimental: isExperimental,
      );
      _comparePropertiesAndAddChange(
        oldField.isExperimental,
        newField.isExperimental,
        context,
        newField,
        'Experimental Flag changed. ${oldField.isExperimental} -> ${newField.isExperimental}',
        changes,
        isCompatibleChange: !newField
            .isExperimental, //this is only non-breaking if the experimental flag is removed
        changeCode: ApiChangeCode.cf06,
        isExperimental:
            false, //we don't pass the experimental flag here because this would cause in a non-breaking change when the flag is added
      );
      final oldTypeIdentifier = TypeIdentifier.fromNameAndLibraryPath(
        typeName: oldField.typeName,
        libraryPath: oldField.typeFullLibraryName,
      );
      final newTypeIdentifier = TypeIdentifier.fromNameAndLibraryPath(
        typeName: newField.typeName,
        libraryPath: newField.typeFullLibraryName,
      );
      _comparePropertiesAndAddChange(
        oldField.typeName,
        newField.typeName,
        context,
        newField,
        'Type of field changed. ${oldField.typeName} -> ${newField.typeName}',
        changes,
        changeCode: ApiChangeCode.cf04,
        isExperimental: isExperimental,
        // field type change is compatible if the type change is compatible if passed in and out
        isCompatibleChange: typeHierarchy.isCompatibleReplacement(
              oldTypeIdentifier: oldTypeIdentifier,
              newTypeIdentifier: newTypeIdentifier,
              isTypePassedIn: true,
            ) &&
            typeHierarchy.isCompatibleReplacement(
              oldTypeIdentifier: oldTypeIdentifier,
              newTypeIdentifier: newTypeIdentifier,
              isTypePassedIn: false,
            ),
      );
      _comparePropertiesAndAddChange(
        oldField.isStatic,
        newField.isStatic,
        context,
        newField,
        'Static specifier changed. ${oldField.isStatic} -> ${newField.isStatic}',
        changes,
        changeCode: ApiChangeCode.cf05,
        isExperimental: isExperimental,
      );
      changes.addAll(_calculateEntryPointsDiff(
        oldField.entryPoints,
        newField.entryPoints,
        context,
        isExperimental: isExperimental,
      ));
      _comparePropertiesAndAddChange(
        oldField.isReadable,
        newField.isReadable,
        context,
        newField,
        'Readablility changed. ${oldField.isReadable} -> ${newField.isReadable}',
        changes,
        changeCode: ApiChangeCode.cf07,
        isExperimental: isExperimental,
        // the change is compatible if the field gained readablility
        isCompatibleChange: newField.isReadable,
      );
      _comparePropertiesAndAddChange(
        oldField.isWriteable,
        newField.isWriteable,
        context,
        newField,
        'Writability changed. ${oldField.isWriteable} -> ${newField.isWriteable}',
        changes,
        changeCode: ApiChangeCode.cf08,
        isExperimental: isExperimental,
        // the change is compatible if the field gained writability
        isCompatibleChange: newField.isWriteable,
      );

      return changes;
    });
  }

  List<ApiChange> _calculateIOSPlatformConstraintsDiff(
    IOSPlatformConstraints? oldConstraints,
    IOSPlatformConstraints? newConstraints, {
    required bool isExperimental,
  }) {
    if (oldConstraints == null && newConstraints == null) {
      return [];
    }
    if (oldConstraints == null) {
      return [
        ApiChange(
          changeCode: ApiChangeCode.cpi01,
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.addBreaking,
          isExperimental: isExperimental,
          changeDescription: 'iOS platform added',
        ),
      ];
    }
    if (newConstraints == null) {
      return [
        ApiChange(
          changeCode: ApiChangeCode.cpi02,
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.remove,
          isExperimental: isExperimental,
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
          changeCode: ApiChangeCode.cpi03,
          affectedDeclaration: null,
          contextTrace: [],
          type: isBreaking
              ? ApiChangeType.changeBreaking
              : ApiChangeType.changeCompatibleMinor,
          isExperimental: isExperimental,
          changeDescription:
              'iOS platform minimum version changed from ${oldConstraints.minimumOsVersion} to ${newConstraints.minimumOsVersion}',
        ),
      ];
    }
    return [];
  }

  List<ApiChange> _calculateAndroidPlatformConstraintsDiff(
    AndroidPlatformConstraints? oldConstraints,
    AndroidPlatformConstraints? newConstraints, {
    required bool isExperimental,
  }) {
    if (oldConstraints == null && newConstraints == null) {
      return [];
    }
    if (oldConstraints == null) {
      return [
        ApiChange(
          changeCode: ApiChangeCode.cpa01,
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.addBreaking,
          isExperimental: isExperimental,
          changeDescription: 'Android platform added',
        ),
      ];
    }
    if (newConstraints == null) {
      return [
        ApiChange(
          changeCode: ApiChangeCode.cpa02,
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.remove,
          isExperimental: isExperimental,
          changeDescription: 'Android platform removed',
        ),
      ];
    }

    addIfChanged(
      int? oldVal,
      int? newVal,
      String valName,
      List<ApiChange> changes, {
      required ApiChangeCode changeCodeAdd,
      required ApiChangeCode changeCodeRemove,
      required ApiChangeCode changeCodeChanged,
    }) {
      if (oldVal == newVal) {
        return;
      }
      if (oldVal == null) {
        changes.add(ApiChange(
          changeCode: changeCodeAdd,
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.addBreaking,
          isExperimental: isExperimental,
          changeDescription: 'Android platform $valName added',
        ));
        return;
      }
      if (newVal == null) {
        changes.add(ApiChange(
          changeCode: changeCodeRemove,
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.remove,
          isExperimental: isExperimental,
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
        changeCode: changeCodeChanged,
        affectedDeclaration: null,
        contextTrace: [],
        type: isBreaking
            ? ApiChangeType.changeBreaking
            : ApiChangeType.changeCompatibleMinor,
        isExperimental: isExperimental,
        changeDescription:
            'Android platform $valName changed from $oldVal to $newVal',
      ));
    }

    List<ApiChange> changes = [];

    addIfChanged(
      oldConstraints.minSdkVersion,
      newConstraints.minSdkVersion,
      'minSdkVersion',
      changes,
      changeCodeAdd: ApiChangeCode.cpa03,
      changeCodeRemove: ApiChangeCode.cpa04,
      changeCodeChanged: ApiChangeCode.cpa05,
    );
    addIfChanged(
      oldConstraints.targetSdkVersion,
      newConstraints.targetSdkVersion,
      'targetSdkVersion',
      changes,
      changeCodeAdd: ApiChangeCode.cpa06,
      changeCodeRemove: ApiChangeCode.cpa07,
      changeCodeChanged: ApiChangeCode.cpa08,
    );
    addIfChanged(
      oldConstraints.compileSdkVersion,
      newConstraints.compileSdkVersion,
      'compileSdkVersion',
      changes,
      changeCodeAdd: ApiChangeCode.cpa09,
      changeCodeRemove: ApiChangeCode.cpa10,
      changeCodeChanged: ApiChangeCode.cpa11,
    );

    return changes;
  }

  List<ApiChange> _calculateSdkDiff(
    PackageApi oldApi,
    PackageApi newApi, {
    required bool isExperimental,
    required bool doCheckSdkVersion,
  }) {
    final result = <ApiChange>[];
    if (oldApi.sdkType != newApi.sdkType) {
      result.add(
        ApiChange(
          changeCode: ApiChangeCode.csdk01,
          affectedDeclaration: null,
          contextTrace: [],
          type: ApiChangeType.changeBreaking,
          isExperimental: isExperimental,
          changeDescription:
              'SDK type changed from ${oldApi.sdkType} to ${newApi.sdkType}',
        ),
      );
    }
    if (doCheckSdkVersion) {
      // lowering the version is no problem => check if new version is higher
      if (oldApi.minSdkVersion < newApi.minSdkVersion) {
        result.add(
          ApiChange(
            changeCode: ApiChangeCode.csdk02,
            affectedDeclaration: null,
            contextTrace: [],
            type: ApiChangeType.changeBreaking,
            isExperimental: isExperimental,
            changeDescription:
                'Minimum SDK version changed from ${oldApi.minSdkVersion} to ${newApi.minSdkVersion}',
          ),
        );
      }
    }
    return result;
  }

  List<ApiChange> _calculatePackageDependenciesDiff(
      PackageApi oldApi, PackageApi newApi,
      {required bool isExperimental}) {
    final result = <ApiChange>[];
    final oldDependencies = oldApi.packageDependencies;
    final newDependencies = newApi.packageDependencies;
    final oldDependenciesMap =
        Map.fromEntries(oldDependencies.map((d) => MapEntry(d.packageName, d)));
    final newDependenciesMap =
        Map.fromEntries(newDependencies.map((d) => MapEntry(d.packageName, d)));
    final allDependencies = oldDependenciesMap.keys.toSet()
      ..addAll(newDependenciesMap.keys);

    for (final dependencyName in allDependencies) {
      final oldDependency = oldDependenciesMap[dependencyName];
      final newDependency = newDependenciesMap[dependencyName];

      // dependency is new => breaking change (if not overwritten via options)
      if (oldDependency == null) {
        result.add(
          ApiChange(
            changeCode: ApiChangeCode.cd01,
            affectedDeclaration: null,
            contextTrace: [],
            type: ApiChangeType.addCompatibleMinor,
            isExperimental: isExperimental,
            changeDescription: 'Package dependency added: "$dependencyName"',
          ),
        );
        continue;
      }

      // dependency is removed => non-breaking change
      if (newDependency == null) {
        result.add(
          ApiChange(
            changeCode: ApiChangeCode.cd02,
            affectedDeclaration: null,
            contextTrace: [],
            type: ApiChangeType.changeCompatiblePatch,
            isExperimental: isExperimental,
            changeDescription: 'Package dependency removed: "$dependencyName"',
          ),
        );
        continue;
      }

      // dependency is present in old and new API => check version
      if (oldDependency.packageVersion != newDependency.packageVersion) {
        // only check the version if it is not null (which means the package to compare with has a path or git dependency instead)
        // this can happen if the API is checked on a version that will be tweaked before publishing (e.g. turn path dependencies into pub refs)
        if (oldDependency.packageVersion == null ||
            newDependency.packageVersion == null) {
          logWarning(
              'Package dependency "$dependencyName" has a git or path dependency in one of the APIs. Skipping version check.');
          continue;
        }
        final oldVersion =
            VersionConstraint.parse(oldDependency.packageVersion!);
        final newVersion =
            VersionConstraint.parse(newDependency.packageVersion!);

        final isNonBreakingVersionChange = oldVersion.allowsAny(newVersion);
        result.add(
          ApiChange(
            changeCode: ApiChangeCode.cd03,
            affectedDeclaration: null,
            contextTrace: [],
            type: !isNonBreakingVersionChange
                ? ApiChangeType.changeCompatibleMinor
                : ApiChangeType.changeCompatiblePatch,
            isExperimental: isExperimental,
            changeDescription:
                'Package dependency "$dependencyName" version changed from "${oldDependency.packageVersion}" to "${newDependency.packageVersion}"',
          ),
        );
      }
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

  _compareParameterTypesAndAddChange(
    TypeIdentifier oldTypeidentifier,
    TypeIdentifier newTypeIdentifier,
    Stack<Declaration> context,
    Declaration affectedDeclaration,
    String changeDescription,
    List<ApiChange> changes, {
    required ApiChangeCode changeCode,
    required bool isExperimental,
    required TypeHierarchy typeHierarchy,
  }) {
    if (oldTypeidentifier.packageAndTypeName !=
        newTypeIdentifier.packageAndTypeName) {
      final isBreaking = !typeHierarchy.isCompatibleReplacement(
        oldTypeIdentifier: oldTypeidentifier,
        newTypeIdentifier: newTypeIdentifier,
        isTypePassedIn: true,
      );
      changes.add(ApiChange(
        changeCode: changeCode,
        affectedDeclaration: affectedDeclaration,
        contextTrace: _contextTraceFromStack(context),
        type: isBreaking
            ? ApiChangeType.changeBreaking
            : ApiChangeType.changeCompatibleMinor,
        changeDescription: changeDescription,
        isExperimental: isExperimental,
      ));
    }
  }

  _comparePropertiesAndAddChange<T>(
    T oldValue,
    T newValue,
    Stack<Declaration> context,
    Declaration affectedDeclaration,
    String changeDescription,
    List<ApiChange> changes, {
    bool isCompatibleChange = false,
    required ApiChangeCode changeCode,
    required bool isExperimental,
  }) {
    if (oldValue != newValue) {
      changes.add(ApiChange(
        changeCode: changeCode,
        affectedDeclaration: affectedDeclaration,
        contextTrace: _contextTraceFromStack(context),
        type: isCompatibleChange
            ? ApiChangeType.changeCompatibleMinor
            : ApiChangeType.changeBreaking,
        changeDescription: changeDescription,
        isExperimental: isExperimental,
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
