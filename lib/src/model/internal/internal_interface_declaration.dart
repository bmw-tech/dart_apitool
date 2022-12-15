import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';

import '../interface_declaration.dart';
import '../executable_declaration.dart';
import '../field_declaration.dart';
import 'internal_declaration.dart';
import 'internal_declaration_utils.dart';

/// Internal extension of [InterfaceDeclaration] that adds the [id] and [parentClassId] that is not stable between runs
class InternalInterfaceDeclaration implements InternalDeclaration {
  @override
  final int id;
  @override
  final int? parentClassId;

  // class declaration data
  final String name;
  final String? namespace;
  final bool isPrivate;
  final bool isDeprecated;
  final bool isExperimental;
  final bool isAbstract;
  final List<String> typeParameterNames;
  final List<String> superTypeNames;
  final List<ExecutableDeclaration> executableDeclarations;
  final List<FieldDeclaration> fieldDeclarations;
  @override
  final Set<String>? entryPoints;
  final List<int> superClassIds;
  @override
  final String relativePath;

  InternalInterfaceDeclaration._({
    required this.id,
    this.parentClassId,
    required this.name,
    required this.namespace,
    required this.isPrivate,
    required this.isDeprecated,
    required this.isExperimental,
    required this.isAbstract,
    required this.typeParameterNames,
    required this.superTypeNames,
    required this.executableDeclarations,
    required this.fieldDeclarations,
    required this.entryPoints,
    required this.superClassIds,
    required this.relativePath,
  });

  InternalInterfaceDeclaration.fromInterfaceElement(
    InterfaceElement interfaceElement, {
    String? namespace,
    required String rootPath,
  }) : this._(
          id: InternalDeclarationUtils.getIdFromElement(interfaceElement)!,
          parentClassId: InternalDeclarationUtils.getIdFromParentElement(
              interfaceElement.enclosingElement),
          name: interfaceElement.name,
          namespace: namespace,
          isPrivate: interfaceElement.isPrivate,
          isDeprecated: interfaceElement.hasDeprecated,
          isExperimental:
              InternalDeclarationUtils.hasExperimental(interfaceElement),
          isAbstract:
              (interfaceElement is ClassElement) && interfaceElement.isAbstract,
          typeParameterNames: InternalDeclarationUtils.computeTypeParameters(
              interfaceElement.typeParameters),
          superTypeNames: InternalDeclarationUtils.computeSuperTypeNames(
              interfaceElement.allSupertypes),
          executableDeclarations: [],
          fieldDeclarations: [],
          entryPoints: {},
          relativePath: InternalDeclarationUtils.getRelativePath(
              rootPath, interfaceElement),
          superClassIds: interfaceElement.allSupertypes
              .map((e) => InternalDeclarationUtils.getIdFromElement(e.element))
              .whereNotNull()
              .toList(),
        );

  InternalInterfaceDeclaration.fromExtensionElement(
    ExtensionElement extensionElement, {
    String? namespace,
    required String rootPath,
  }) : this._(
          id: InternalDeclarationUtils.getIdFromElement(extensionElement)!,
          parentClassId: InternalDeclarationUtils.getIdFromParentElement(
              extensionElement.enclosingElement),
          name: extensionElement.name ?? extensionElement.displayName,
          namespace: namespace,
          isPrivate: extensionElement.isPrivate,
          isDeprecated: extensionElement.hasDeprecated,
          isExperimental:
              InternalDeclarationUtils.hasExperimental(extensionElement),
          isAbstract: false,
          typeParameterNames: InternalDeclarationUtils.computeTypeParameters(
              extensionElement.typeParameters),
          superTypeNames: const [],
          executableDeclarations: [],
          fieldDeclarations: [],
          entryPoints: {},
          relativePath: InternalDeclarationUtils.getRelativePath(
              rootPath, extensionElement),
          superClassIds: [],
        );

  InterfaceDeclaration toInterfaceDeclaration({required bool isRequired}) {
    final namespacePrefix = namespace == null ? '' : '$namespace.';
    return InterfaceDeclaration(
      name: '$namespacePrefix$name',
      isDeprecated: isDeprecated,
      isExperimental: isExperimental,
      typeParameterNames: typeParameterNames,
      superTypeNames: superTypeNames,
      executableDeclarations: executableDeclarations,
      fieldDeclarations: fieldDeclarations,
      entryPoints: entryPoints,
      isRequired: isRequired,
      relativePath: relativePath,
    );
  }
}
