import 'package:analyzer/dart/element/element.dart';

import '../executable_declaration.dart';
import 'internal_declaration.dart';
import 'internal_declaration_utils.dart';

class InternalExecutableDeclaration implements InternalDeclaration {
  @override
  final int? parentClassId;

  final ExecutableDeclaration executableDeclaration;

  InternalExecutableDeclaration._({
    this.parentClassId,
    required this.executableDeclaration,
  });

  InternalExecutableDeclaration.fromExecutableElement(
      ExecutableElement executableElement)
      : this._(
            parentClassId: InternalDeclarationUtils.getIdFromElement(
                executableElement.enclosingElement3),
            executableDeclaration: ExecutableDeclaration(
              returnTypeName: executableElement.returnType
                  .getDisplayString(withNullability: true),
              name: executableElement.displayName,
              isDeprecated: executableElement.hasDeprecated,
              parameters: _computeParameterList(executableElement.parameters),
              typeParameterNames:
                  _computeTypeParameters(executableElement.typeParameters),
              type: _computeExecutableType(executableElement),
              isStatic: executableElement.isStatic,
            ));

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
