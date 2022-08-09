import 'package:analyzer/dart/element/element.dart';

import '../field_declaration.dart';
import 'internal_declaration.dart';
import 'internal_declaration_utils.dart';

class InternalFieldDeclaration implements InternalDeclaration {
  @override
  final int? parentClassId;

  final FieldDeclaration fieldDeclaration;

  InternalFieldDeclaration._(
      {this.parentClassId, required this.fieldDeclaration});

  InternalFieldDeclaration.fromPropertyInducingElement(
      PropertyInducingElement fieldElement)
      : this._(
            parentClassId: InternalDeclarationUtils.getIdFromElement(
                fieldElement.enclosingElement2),
            fieldDeclaration: FieldDeclaration(
              typeName:
                  fieldElement.type.getDisplayString(withNullability: true),
              name: fieldElement.name,
              isDeprecated: fieldElement.hasDeprecated,
            ));
}
