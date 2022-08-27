import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/string_utils.dart';
import 'declaration.dart';

part 'executable_declaration.freezed.dart';

/// Represents the type of executable found
enum ExecutableType {
  /// method declaration
  method,
  // constructor declaration
  constructor,
}

@freezed
class ExecutableParameterDeclaration
    with _$ExecutableParameterDeclaration
    implements Declaration {
  const ExecutableParameterDeclaration._();

  @Implements<Declaration>()
  const factory ExecutableParameterDeclaration({
    required bool isRequired,
    required bool isNamed,
    required String name,
    required bool isDeprecated,
    required String typeName,
    Set<String>? entryPoints,
  }) = _ExecutableParameterDeclaration;
}

/// Represents an executable declaration
@freezed
class ExecutableDeclaration
    with _$ExecutableDeclaration
    implements Declaration {
  const ExecutableDeclaration._();

  /// signature of the executable declaration.
  ///
  /// Contains the return type, name of the executable as well as all its parameters
  String get signature => _computeSignature();

  const factory ExecutableDeclaration({
    required String returnTypeName,
    required String name,
    required bool isDeprecated,
    required List<ExecutableParameterDeclaration> parameters,
    required List<String> typeParameterNames,
    required ExecutableType type,
    required bool isStatic,
    Set<String>? entryPoints,
  }) = _ExecutableDeclaration;

  /// computes the executable signature.
  ///
  /// The signature contains all public facing aspects of the executable like return value, name and parameters
  String _computeSignature() {
    List<String> parameterStrings = [];
    List<String> namedParameterStrings = [];
    for (final parameter in parameters) {
      final paramTypeString = parameter.typeName;
      final paramName = parameter.name;
      if (!parameter.isNamed) {
        parameterStrings.add('$paramTypeString $paramName');
      } else {
        String requiredPrefix = '';
        if (parameter.isRequired) {
          requiredPrefix = 'required ';
          namedParameterStrings
              .add('$requiredPrefix$paramTypeString $paramName');
        }
      }
    }
    if (namedParameterStrings.isNotEmpty) {
      parameterStrings.add('{${namedParameterStrings.join(', ')}}');
    }
    String typeParameterSuffix = getTypeParameterSuffix(typeParameterNames);
    return '$returnTypeName $name$typeParameterSuffix(${parameterStrings.join(', ')})';
  }
}
