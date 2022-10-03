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

  InternalClassDeclaration.fromClassElement(ClassElement classElement,
      {String? namespace})
      : this._(
          id: InternalDeclarationUtils.getIdFromElement(classElement)!,
          parentClassId: InternalDeclarationUtils.getIdFromElement(
              classElement.enclosingElement3),
          name: classElement.name,
          namespace: namespace,
          isPrivate: classElement.isPrivate,
          isDeprecated: classElement.hasDeprecated,
          typeParameterNames: InternalDeclarationUtils.computeTypeParameters(
              classElement.typeParameters),
          superTypeNames: InternalDeclarationUtils.computeSuperTypeNames(
              classElement.allSupertypes),
          executableDeclarations: [],
          fieldDeclarations: [],
          entryPoints: {},
          superClassIds: classElement.allSupertypes
              .map((e) => InternalDeclarationUtils.getIdFromElement(e.element2))
              .whereNotNull()
              .toList(),
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
