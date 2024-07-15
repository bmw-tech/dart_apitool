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
  final String returnTypeName;
  final String? returnTypeFullLibraryName;
  final String name;
  final String? namespace;
  final bool isDeprecated;
  final bool isExperimental;
  final List<ExecutableParameterDeclaration> parameters;
  final List<String> typeParameterNames;
  final ExecutableType type;
  final bool isStatic;
  @override
  final Set<String>? entryPoints;
  @override
  final String relativePath;

  InternalExecutableDeclaration._({
    required this.id,
    this.parentClassId,
    required this.returnTypeName,
    required this.returnTypeFullLibraryName,
    required this.name,
    required this.namespace,
    required this.isDeprecated,
    required this.isExperimental,
    required this.parameters,
    required this.typeParameterNames,
    required this.type,
    required this.isStatic,
    required this.entryPoints,
    required this.relativePath,
  });

  InternalExecutableDeclaration.fromExecutableElement(
    ExecutableElement executableElement, {
    String? namespace,
    required String rootPath,
  }) : this._(
          id: InternalDeclarationUtils.getIdFromElement(executableElement)!,
          parentClassId: InternalDeclarationUtils.getIdFromParentElement(
              executableElement.enclosingElement),
          returnTypeName: executableElement.returnType.getDisplayString() +
              InternalDeclarationUtils.getNullabilitySuffixString(
                executableElement.returnType.nullabilitySuffix,
              ),
          returnTypeFullLibraryName:
              executableElement.returnType.element?.librarySource?.fullName,
          name: executableElement.displayName,
          namespace: namespace,
          isDeprecated: executableElement.hasDeprecated,
          isExperimental:
              InternalDeclarationUtils.hasExperimental(executableElement),
          parameters: _computeParameterList(
            executableElement.parameters,
            InternalDeclarationUtils.getRelativePath(
                rootPath, executableElement),
            rootPath,
          ),
          typeParameterNames:
              _computeTypeParameters(executableElement.typeParameters),
          type: _computeExecutableType(executableElement),
          isStatic: executableElement.isStatic,
          entryPoints: {},
          relativePath: InternalDeclarationUtils.getRelativePath(
              rootPath, executableElement),
        );

  ExecutableDeclaration toExecutableDeclaration() {
    final namespacePrefix = namespace == null ? '' : '$namespace.';
    return ExecutableDeclaration(
      returnTypeName: returnTypeName,
      returnTypeFullLibraryName: returnTypeFullLibraryName,
      name: '$namespacePrefix$name',
      isDeprecated: isDeprecated,
      isExperimental: isExperimental,
      parameters: parameters,
      typeParameterNames: typeParameterNames,
      type: type,
      isStatic: isStatic,
      entryPoints: entryPoints,
      relativePath: relativePath,
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
      List<ParameterElement> parameterElementList,
      String relativePath,
      String rootPath) {
    return parameterElementList
        .map((e) => ExecutableParameterDeclaration(
              isRequired: e.isRequired,
              isNamed: e.isNamed,
              name: e.name,
              isDeprecated: e.hasDeprecated,
              isExperimental: InternalDeclarationUtils.hasExperimental(e),
              typeName: e.type.getDisplayString() +
                  InternalDeclarationUtils.getNullabilitySuffixString(
                      e.type.nullabilitySuffix),
              typeFullLibraryName: e.type.element?.librarySource?.fullName,
              relativePath: relativePath,
            ))
        .toList();
  }

  static List<String> _computeTypeParameters(
      List<TypeParameterElement> paramList) {
    return paramList.map((pe) => pe.name).toList();
  }
}
