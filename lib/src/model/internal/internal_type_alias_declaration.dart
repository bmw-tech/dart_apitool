import 'package:analyzer/dart/element/element.dart';
import 'package:dart_apitool/src/model/internal/internal_declaration.dart';
import 'package:dart_apitool/src/model/type_alias_declaration.dart';

import 'internal_declaration_utils.dart';

class InternalTypeAliasDeclaration implements InternalDeclaration {
  @override
  final int id;
  @override
  final int? parentClassId;

  final String name;
  final String? namespace;
  final String aliasedTypeName;
  final bool isDeprecated;
  final bool isExperimental;

  @override
  Set<String>? entryPoints;
  @override
  final String relativePath;

  InternalTypeAliasDeclaration._({
    required this.id,
    this.parentClassId,
    required this.name,
    required this.namespace,
    required this.aliasedTypeName,
    required this.isDeprecated,
    required this.isExperimental,
    required this.entryPoints,
    required this.relativePath,
  });

  InternalTypeAliasDeclaration.fromTypeAliasElement(
    TypeAliasElement typeAliasElement, {
    String? namespace,
    required String rootPath,
  }) : this._(
            id: InternalDeclarationUtils.getIdFromElement(typeAliasElement)!,
            parentClassId: InternalDeclarationUtils.getIdFromParentElement(
                typeAliasElement.enclosingElement),
            name: typeAliasElement.name,
            namespace: namespace,
            aliasedTypeName: typeAliasElement.aliasedType.getDisplayString(),
            isDeprecated: typeAliasElement.hasDeprecated,
            isExperimental:
                InternalDeclarationUtils.hasExperimental(typeAliasElement),
            entryPoints: {},
            relativePath: InternalDeclarationUtils.getRelativePath(
                rootPath, typeAliasElement));

  TypeAliasDeclaration toTypeAliasDeclaration() {
    final namespacePrefix = namespace == null ? '' : '$namespace.';
    return TypeAliasDeclaration(
      name: '$namespacePrefix$name',
      aliasedTypeName: aliasedTypeName,
      isDeprecated: isDeprecated,
      isExperimental: isExperimental,
      entryPoints: entryPoints,
      relativePath: relativePath,
    );
  }
}
