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
  final String typeName;
  final String name;
  final String? namespace;
  final bool isDeprecated;
  final bool isExperimental;
  final bool isStatic;
  @override
  final Set<String>? entryPoints;
  @override
  final String relativePath;

  InternalFieldDeclaration._({
    required this.id,
    this.parentClassId,
    required this.typeName,
    required this.name,
    required this.namespace,
    required this.isDeprecated,
    required this.isExperimental,
    required this.isStatic,
    required this.entryPoints,
    required this.relativePath,
  });

  InternalFieldDeclaration.fromPropertyInducingElement(
      PropertyInducingElement fieldElement,
      {String? namespace})
      : this._(
          id: InternalDeclarationUtils.getIdFromElement(fieldElement)!,
          parentClassId: InternalDeclarationUtils.getIdFromParentElement(
              fieldElement.enclosingElement),
          typeName: fieldElement.type.getDisplayString(withNullability: true),
          name: fieldElement.name,
          namespace: namespace,
          isDeprecated: fieldElement.hasDeprecated,
          isExperimental:
              InternalDeclarationUtils.hasExperimental(fieldElement),
          isStatic: fieldElement.isStatic,
          entryPoints: {},
          relativePath: InternalDeclarationUtils.getRelativePath(fieldElement),
        );

  FieldDeclaration toFieldDeclaration() {
    final namespacePrefix = namespace == null ? '' : '$namespace.';
    return FieldDeclaration(
      typeName: typeName,
      name: '$namespacePrefix$name',
      isDeprecated: isDeprecated,
      isExperimental: isExperimental,
      isStatic: isStatic,
      entryPoints: entryPoints,
      relativePath: relativePath,
    );
  }
}
