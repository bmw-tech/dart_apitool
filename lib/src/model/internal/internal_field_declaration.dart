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
  final String? typeFullLibraryName;
  final String name;
  final String? namespace;
  final bool isDeprecated;
  final bool isExperimental;
  final bool isStatic;
  final bool isConst;
  @override
  final Set<String>? entryPoints;
  @override
  final String relativePath;
  final bool isWriteable;
  final bool isReadable;

  InternalFieldDeclaration._({
    required this.id,
    this.parentClassId,
    required this.typeName,
    required this.typeFullLibraryName,
    required this.name,
    required this.namespace,
    required this.isDeprecated,
    required this.isExperimental,
    required this.isStatic,
    required this.isConst,
    required this.entryPoints,
    required this.relativePath,
    required this.isReadable,
    required this.isWriteable,
  });

  InternalFieldDeclaration.fromPropertyInducingElement(
    PropertyInducingElement fieldElement, {
    String? namespace,
    required String rootPath,
  }) : this._(
          id: InternalDeclarationUtils.getIdFromElement(fieldElement)!,
          parentClassId: InternalDeclarationUtils.getIdFromParentElement(
              fieldElement.enclosingElement),
          typeName: fieldElement.type.getDisplayString(withNullability: true),
          typeFullLibraryName:
              fieldElement.type.element?.librarySource?.fullName,
          name: fieldElement.name,
          namespace: namespace,
          isDeprecated: fieldElement.hasDeprecated,
          isExperimental:
              InternalDeclarationUtils.hasExperimental(fieldElement),
          isStatic: fieldElement.isStatic,
          isConst: fieldElement.isConst,
          entryPoints: {},
          relativePath:
              InternalDeclarationUtils.getRelativePath(rootPath, fieldElement),
          isReadable: fieldElement.getter != null,
          isWriteable: fieldElement.setter != null,
        );

  FieldDeclaration toFieldDeclaration() {
    final namespacePrefix = namespace == null ? '' : '$namespace.';
    return FieldDeclaration(
      typeName: typeName,
      typeFullLibraryName: typeFullLibraryName,
      name: '$namespacePrefix$name',
      isDeprecated: isDeprecated,
      isExperimental: isExperimental,
      isStatic: isStatic,
      isConst: isConst,
      entryPoints: entryPoints,
      relativePath: relativePath,
      isReadable: isReadable,
      isWriteable: isWriteable,
    );
  }
}
