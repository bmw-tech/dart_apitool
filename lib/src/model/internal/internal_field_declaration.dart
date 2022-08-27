import 'package:analyzer/dart/element/element.dart';

import '../field_declaration.dart';
import 'internal_declaration.dart';
import 'internal_declaration_utils.dart';

class InternalFieldDeclaration implements InternalDeclaration {
  @override
  final int id;
  @override
  final int? parentClassId;

  // field declaration data
  String typeName;
  String name;
  bool isDeprecated;
  bool isStatic;
  @override
  Set<String>? entryPoints;

  InternalFieldDeclaration._({
    required this.id,
    this.parentClassId,
    required this.typeName,
    required this.name,
    required this.isDeprecated,
    required this.isStatic,
    required this.entryPoints,
  });

  InternalFieldDeclaration.fromPropertyInducingElement(
      PropertyInducingElement fieldElement)
      : this._(
            id: InternalDeclarationUtils.getIdFromElement(fieldElement)!,
            parentClassId: InternalDeclarationUtils.getIdFromElement(
                fieldElement.enclosingElement3),
            typeName: fieldElement.type.getDisplayString(withNullability: true),
            name: fieldElement.name,
            isDeprecated: fieldElement.hasDeprecated,
            isStatic: fieldElement.isStatic,
            entryPoints: {});

  FieldDeclaration toFieldDeclaration() {
    return FieldDeclaration(
      typeName: typeName,
      name: name,
      isDeprecated: isDeprecated,
      isStatic: isStatic,
      entryPoints: {},
    );
  }
}
