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

  final ClassDeclaration classDeclaration;

  InternalClassDeclaration._({
    required this.id,
    this.parentClassId,
    required this.classDeclaration,
  });

  InternalClassDeclaration.fromClassElement(ClassElement classElement)
      : this._(
          id: InternalDeclarationUtils.getIdFromElement(classElement)!,
          parentClassId: InternalDeclarationUtils.getIdFromElement(
              classElement.enclosingElement3),
          classDeclaration: ClassDeclaration(
            name: classElement.name,
            isDeprecated: classElement.hasDeprecated,
            typeParameterNames: InternalDeclarationUtils.computeTypeParameters(
                classElement.typeParameters),
            superTypeNames: InternalDeclarationUtils.computeSuperTypeNames(
                classElement.allSupertypes),
            executableDeclarations: [],
            fieldDeclarations: [],
          ),
        );

  InternalClassDeclaration copyWith({
    List<ExecutableDeclaration>? newExecutableDeclarations,
    List<FieldDeclaration>? newFieldDeclarations,
    ClassDeclaration? newClassDeclaration,
  }) {
    final cd = newClassDeclaration ?? classDeclaration;
    return InternalClassDeclaration._(
      id: id,
      parentClassId: parentClassId,
      classDeclaration: cd.copyWith(
        executableDeclarations:
            newExecutableDeclarations ?? cd.executableDeclarations,
        fieldDeclarations: newFieldDeclarations ?? cd.fieldDeclarations,
      ),
    );
  }
}
