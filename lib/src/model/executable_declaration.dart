import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/utils.dart';
import 'declaration.dart';

part 'executable_declaration.freezed.dart';

/// Represents the type of executable found
enum ExecutableType {
  /// method declaration
  method,
  // constructor declaration
  constructor,
}

/// Represents an executable parameter declaration
@freezed
sealed class ExecutableParameterDeclaration
    with _$ExecutableParameterDeclaration
    implements Declaration {
  const ExecutableParameterDeclaration._();

  @Implements<Declaration>()
  const factory ExecutableParameterDeclaration({
    /// whether the parameter is required
    required bool isRequired,

    /// whether the parameter is named
    required bool isNamed,

    /// the name of the parameter
    required String name,

    /// whether the parameter is deprecated
    required bool isDeprecated,

    /// whether the parameter is experimental
    required bool isExperimental,

    /// type name of this parameter
    required String typeName,

    /// the type library path
    required String? typeFullLibraryName,

    /// the relative path of the library
    required String relativePath,
  }) = _ExecutableParameterDeclaration;

  /// [ExecutableParameterDeclaration]s can't have entry points
  @override
  Set<String>? get entryPoints => null;
}

/// Represents an executable declaration
@freezed
sealed class ExecutableDeclaration
    with _$ExecutableDeclaration
    implements Declaration {
  const ExecutableDeclaration._();

  /// signature of the executable declaration.
  ///
  /// Contains the return type, name of the executable as well as all its parameters
  String get signature => _computeSignature();

  const factory ExecutableDeclaration({
    /// name of the return type
    required String returnTypeName,

    // full library name of the return type
    required String? returnTypeFullLibraryName,

    /// name of the executable
    required String name,

    /// whether the executable is deprecated
    required bool isDeprecated,

    /// whether the executable is experimental
    required bool isExperimental,

    /// list of the executables parameters ([ExecutableOParameterDeclaration]s)
    required List<ExecutableParameterDeclaration> parameters,

    /// type parameter names of this executable
    required List<String> typeParameterNames,

    /// type of the executable
    required ExecutableType type,

    /// whether the executable is a static method
    required bool isStatic,

    /// entry points for this executable
    Set<String>? entryPoints,

    /// the relative path of the library
    required String relativePath,
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
