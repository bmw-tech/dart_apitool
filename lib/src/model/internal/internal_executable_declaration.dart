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
          returnTypeName: executableElement.returnType.getDisplayString(),
          returnTypeFullLibraryName:
              executableElement.returnType.element?.library?.uri.toString(),
          // This is a fix for the only method overloading in Dart the `-` operator
          name: (executableElement is MethodElement &&
                  executableElement.isOperator)
              ? () {
                  final rawName =
                      executableElement.name ?? executableElement.displayName;
                  final prefix = executableElement.formalParameters.isEmpty
                      ? 'unary'
                      : 'binary';
                  // If the raw name already starts with the prefix then don't add it again
                  if (rawName.startsWith(prefix)) {
                    return rawName;
                  }
                  return prefix + rawName;
                }()
              : executableElement.name ?? executableElement.displayName,
          namespace: namespace,
          isDeprecated: executableElement.metadata.hasDeprecated,
          isExperimental:
              InternalDeclarationUtils.hasExperimental(executableElement),
          parameters: _computeParameterList(
            executableElement.formalParameters,
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
      List<FormalParameterElement> parameterElementList,
      String relativePath,
      String rootPath) {
    return parameterElementList
        .map((e) => ExecutableParameterDeclaration(
              isRequired: e.isRequired,
              isNamed: e.isNamed,
              name: e.name ?? e.displayName,
              isDeprecated: e.metadata.hasDeprecated,
              isExperimental: InternalDeclarationUtils.hasExperimental(e),
              typeName: e.type.getDisplayString(),
              typeFullLibraryName: e.type.element?.library?.uri.toString(),
              relativePath: relativePath,
            ))
        .toList();
  }

  static List<String> _computeTypeParameters(
      List<TypeParameterElement> paramList) {
    return paramList.map((pe) => pe.name ?? pe.displayName).toList();
  }
}
