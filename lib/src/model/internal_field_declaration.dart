import 'package:analyzer/dart/element/element.dart';
import 'package:dart_apitool/model/field_declaration.dart';
import 'package:dart_apitool/src/model/internal_declaration.dart';

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
            ));
}
