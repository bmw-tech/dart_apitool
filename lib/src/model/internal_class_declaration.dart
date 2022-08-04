import 'package:analyzer/dart/element/element.dart';
import 'package:dart_apitool/model/class_declaration.dart';
import 'package:dart_apitool/model/field_declaration.dart';
import 'package:dart_apitool/model/executable_declaration.dart';
import 'package:dart_apitool/src/model/internal_declaration.dart';

import 'internal_declaration_utils.dart';

/// Internal extension of [ClassDeclaration] that adds the [id] and [parentClassId] that is not stable between runs
class InternalClassDeclaration implements InternalDeclaration {
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
              classElement.enclosingElement2),
          classDeclaration: ClassDeclaration(
            name: classElement.name,
            typeParameterNames: InternalDeclarationUtils.computeTypeParameters(
                classElement.typeParameters),
            superTypeNames: InternalDeclarationUtils.computeSuperTypeNames(
                classElement.allSupertypes),
            executableDeclarations: [],
            fieldDeclarations: [],
          ),
        );

  InternalClassDeclaration copyWith({
    List<ExecutableDeclaration>? executableDeclarations,
    List<FieldDeclaration>? fieldDeclarations,
  }) {
    return InternalClassDeclaration._(
      id: id,
      parentClassId: parentClassId,
      classDeclaration: classDeclaration.copyWith(
        executableDeclarations:
            executableDeclarations ?? classDeclaration.executableDeclarations,
        fieldDeclarations:
            fieldDeclarations ?? classDeclaration.fieldDeclarations,
      ),
    );
  }
}
