import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';

import '../class_declaration.dart';
import '../executable_declaration.dart';
import '../field_declaration.dart';
import 'internal_declaration.dart';
import 'internal_declaration_utils.dart';

/// Internal extension of [ClassDeclaration] that adds the [id] and [parentClassId] that is not stable between runs
class InternalClassDeclaration implements InternalDeclaration {
  @override
  final int id;
  @override
  final int? parentClassId;

  // class declaration data
  final String name;
  final String? namespace;
  final bool isPrivate;
  final bool isDeprecated;
  final List<String> typeParameterNames;
  final List<String> superTypeNames;
  final List<ExecutableDeclaration> executableDeclarations;
  final List<FieldDeclaration> fieldDeclarations;
  @override
  final Set<String>? entryPoints;
  final List<int> superClassIds;

  InternalClassDeclaration._({
    required this.id,
    this.parentClassId,
    required this.name,
    required this.namespace,
    required this.isPrivate,
    required this.isDeprecated,
    required this.typeParameterNames,
    required this.superTypeNames,
    required this.executableDeclarations,
    required this.fieldDeclarations,
    required this.entryPoints,
    required this.superClassIds,
  });

  InternalClassDeclaration.fromInterfaceElement(
      InterfaceElement interfaceElement,
      {String? namespace})
      : this._(
          id: InternalDeclarationUtils.getIdFromElement(interfaceElement)!,
          parentClassId: InternalDeclarationUtils.getIdFromParentElement(
              interfaceElement.enclosingElement3),
          name: interfaceElement.name,
          namespace: namespace,
          isPrivate: interfaceElement.isPrivate,
          isDeprecated: interfaceElement.hasDeprecated,
          typeParameterNames: InternalDeclarationUtils.computeTypeParameters(
              interfaceElement.typeParameters),
          superTypeNames: InternalDeclarationUtils.computeSuperTypeNames(
              interfaceElement.allSupertypes),
          executableDeclarations: [],
          fieldDeclarations: [],
          entryPoints: {},
          superClassIds: interfaceElement.allSupertypes
              .map((e) => InternalDeclarationUtils.getIdFromElement(e.element2))
              .whereNotNull()
              .toList(),
        );

  InternalClassDeclaration.fromExtensionElement(
      ExtensionElement extensionElement,
      {String? namespace})
      : this._(
          id: InternalDeclarationUtils.getIdFromElement(extensionElement)!,
          parentClassId: InternalDeclarationUtils.getIdFromParentElement(
              extensionElement.enclosingElement3),
          name: extensionElement.name ?? extensionElement.displayName,
          namespace: namespace,
          isPrivate: extensionElement.isPrivate,
          isDeprecated: extensionElement.hasDeprecated,
          typeParameterNames: InternalDeclarationUtils.computeTypeParameters(
              extensionElement.typeParameters),
          superTypeNames: const [],
          executableDeclarations: [],
          fieldDeclarations: [],
          entryPoints: {},
          superClassIds: [],
        );

  ClassDeclaration toClassDeclaration() {
    final namespacePrefix = namespace == null ? '' : '$namespace.';
    return ClassDeclaration(
      name: '$namespacePrefix$name',
      isDeprecated: isDeprecated,
      typeParameterNames: typeParameterNames,
      superTypeNames: superTypeNames,
      executableDeclarations: executableDeclarations,
      fieldDeclarations: fieldDeclarations,
      entryPoints: entryPoints,
    );
  }
}
