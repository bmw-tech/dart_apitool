import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:equatable/equatable.dart';

import '../utils/string_utils.dart';

/// Represents the type of executable found
enum ExecutableType {
  /// method declaration
  method,
  // constructor declaration
  constructor,
}

class ExecutablParameterDeclaration extends Equatable {
  final bool isRequired;
  final bool isNamed;
  final String name;
  final DartType type;

  const ExecutablParameterDeclaration(
      this.isRequired, this.isNamed, this.name, this.type);

  ExecutablParameterDeclaration.fromParameterElement(ParameterElement element)
      : isRequired = element.isRequired,
        isNamed = element.isNamed,
        name = element.name,
        type = element.type;

  @override
  List<Object?> get props => [
        isRequired,
        isNamed,
        name,
        type,
      ];
}

/// Represents an executable declaration
class ExecutableDeclaration extends Equatable {
  /// signature of the executable declaration.
  ///
  /// Contains the return type, name of the executable as well as all its parameters
  String get signature => _computeSignature();

  final DartType returnType;
  final String name;
  final List<ExecutablParameterDeclaration> parameters;
  final List<String> typeParameterNames;

  /// parent class name or [null] if there is none
  final String? parentClassName;

  /// type of executable (e.g. method or constructor)
  final ExecutableType type;

  const ExecutableDeclaration._(this.parentClassName, this.returnType,
      this.name, this.parameters, this.typeParameterNames, this.type);

  /// creates a new ExecutableDeclaration from the given [executableElement]
  ///
  /// [parentClassName] gets directly passed into [ExecutableDeclaration]
  ExecutableDeclaration.fromExecutableElement(
      String? parentClassName, ExecutableElement executableElement)
      : this._(
          parentClassName,
          executableElement.returnType,
          executableElement.name,
          _computeParameterList(executableElement.parameters),
          _computeTypeParameters(executableElement.typeParameters),
          _computeExecutableType(executableElement),
        );

  /// retrieves the type of executable from the given [executableElement]
  static ExecutableType _computeExecutableType(
      ExecutableElement executableElement) {
    if (executableElement is ConstructorElement) {
      return ExecutableType.constructor;
    }
    return ExecutableType.method;
  }

  static List<ExecutablParameterDeclaration> _computeParameterList(
      List<ParameterElement> parameterElementList) {
    return parameterElementList
        .map((e) => ExecutablParameterDeclaration.fromParameterElement(e))
        .toList();
  }

  static List<String> _computeTypeParameters(
      List<TypeParameterElement> paramList) {
    return paramList.map((pe) => pe.name).toList();
  }

  /// computes the executable signature.
  ///
  /// The signature contains all public facing aspects of the executable like return value, name and parameters
  String _computeSignature() {
    final returnTypeString = returnType.getDisplayString(withNullability: true);
    List<String> parameterStrings = [];
    List<String> namedParameterStrings = [];
    for (final parameter in parameters) {
      final paramTypeString =
          parameter.type.getDisplayString(withNullability: true);
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
    return '$returnTypeString $name$typeParameterSuffix(${parameters.join(', ')})';
  }

  @override
  List<Object?> get props => [
        parentClassName,
        returnType,
        name,
        parameters,
        typeParameterNames,
      ];
}
