import 'package:analyzer/dart/element/element.dart';

import '../field_declaration.dart';
import 'internal_declaration.dart';
import 'internal_declaration_utils.dart';

class InternalFieldDeclaration implements InternalDeclaration {
  @override
  final int id;
  @override
  final int? parentClassId;

  final FieldDeclaration fieldDeclaration;

  InternalFieldDeclaration._({
    required this.id,
    this.parentClassId,
    required this.fieldDeclaration,
  });

  InternalFieldDeclaration.fromPropertyInducingElement(
      PropertyInducingElement fieldElement)
      : this._(
            id: InternalDeclarationUtils.getIdFromElement(fieldElement)!,
            parentClassId: InternalDeclarationUtils.getIdFromElement(
                fieldElement.enclosingElement3),
            fieldDeclaration: FieldDeclaration(
              typeName:
                  fieldElement.type.getDisplayString(withNullability: true),
              name: fieldElement.name,
              isDeprecated: fieldElement.hasDeprecated,
              isStatic: fieldElement.isStatic,
            ));

  InternalFieldDeclaration copyWith({
    FieldDeclaration? newFieldDeclaration,
  }) {
    final fd = newFieldDeclaration ?? fieldDeclaration;
    return InternalFieldDeclaration._(
      id: id,
      parentClassId: parentClassId,
      fieldDeclaration: fd,
    );
  }
}
