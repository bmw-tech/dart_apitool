import 'package:analyzer/dart/element/element.dart';

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
  final bool isDeprecated;
  final List<String> typeParameterNames;
  final List<String> superTypeNames;
  final List<ExecutableDeclaration> executableDeclarations;
  final List<FieldDeclaration> fieldDeclarations;
  @override
  final Set<String>? entryPoints;

  InternalClassDeclaration._({
    required this.id,
    this.parentClassId,
    required this.name,
    required this.isDeprecated,
    required this.typeParameterNames,
    required this.superTypeNames,
    required this.executableDeclarations,
    required this.fieldDeclarations,
    required this.entryPoints,
  });

  InternalClassDeclaration.fromClassElement(ClassElement classElement)
      : this._(
          id: InternalDeclarationUtils.getIdFromElement(classElement)!,
          parentClassId: InternalDeclarationUtils.getIdFromElement(
              classElement.enclosingElement3),
          name: classElement.name,
          isDeprecated: classElement.hasDeprecated,
          typeParameterNames: InternalDeclarationUtils.computeTypeParameters(
              classElement.typeParameters),
          superTypeNames: InternalDeclarationUtils.computeSuperTypeNames(
              classElement.allSupertypes),
          executableDeclarations: [],
          fieldDeclarations: [],
          entryPoints: {},
        );

  ClassDeclaration toClassDeclaration() {
    return ClassDeclaration(
      name: name,
      isDeprecated: isDeprecated,
      typeParameterNames: typeParameterNames,
      superTypeNames: superTypeNames,
      executableDeclarations: executableDeclarations,
      fieldDeclarations: fieldDeclarations,
    );
  }
}
