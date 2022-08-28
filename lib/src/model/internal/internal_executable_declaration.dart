import 'package:analyzer/dart/element/element.dart';

import '../executable_declaration.dart';
import 'internal_declaration.dart';
import 'internal_declaration_utils.dart';

class InternalExecutableDeclaration implements InternalDeclaration {
  @override
  final int id;
  @override
  final int? parentClassId;

  // executable declaration data
  String returnTypeName;
  String name;
  bool isDeprecated;
  List<ExecutableParameterDeclaration> parameters;
  List<String> typeParameterNames;
  ExecutableType type;
  bool isStatic;
  @override
  Set<String>? entryPoints;

  InternalExecutableDeclaration._({
    required this.id,
    this.parentClassId,
    required this.returnTypeName,
    required this.name,
    required this.isDeprecated,
    required this.parameters,
    required this.typeParameterNames,
    required this.type,
    required this.isStatic,
    required this.entryPoints,
  });

  InternalExecutableDeclaration.fromExecutableElement(
      ExecutableElement executableElement)
      : this._(
            id: InternalDeclarationUtils.getIdFromElement(executableElement)!,
            parentClassId: executableElement.enclosingElement3 is ClassElement
                ? InternalDeclarationUtils.getIdFromElement(
                    executableElement.enclosingElement3)
                : null,
            returnTypeName: executableElement.returnType
                .getDisplayString(withNullability: true),
            name: executableElement.displayName,
            isDeprecated: executableElement.hasDeprecated,
            parameters: _computeParameterList(executableElement.parameters),
            typeParameterNames:
                _computeTypeParameters(executableElement.typeParameters),
            type: _computeExecutableType(executableElement),
            isStatic: executableElement.isStatic,
            entryPoints: {});

  ExecutableDeclaration toExecutableDeclaration() {
    return ExecutableDeclaration(
      returnTypeName: returnTypeName,
      name: name,
      isDeprecated: isDeprecated,
      parameters: parameters,
      typeParameterNames: typeParameterNames,
      type: type,
      isStatic: isStatic,
      entryPoints: entryPoints,
    );
  }

  /// retrieves the type of executable from the given [executableElement]
  static ExecutableType _computeExecutableType(
      ExecutableElement executableElement) {
    if (executableElement is ConstructorElement) {
      return ExecutableType.constructor;
    }
    return ExecutableType.method;
  }

  static List<ExecutableParameterDeclaration> _computeParameterList(
      List<ParameterElement> parameterElementList) {
    return parameterElementList
        .map((e) => ExecutableParameterDeclaration(
            isRequired: e.isRequired,
            isNamed: e.isNamed,
            name: e.name,
            isDeprecated: e.hasDeprecated,
            typeName: e.type.getDisplayString(withNullability: true)))
        .toList();
  }

  static List<String> _computeTypeParameters(
      List<TypeParameterElement> paramList) {
    return paramList.map((pe) => pe.name).toList();
  }
}
