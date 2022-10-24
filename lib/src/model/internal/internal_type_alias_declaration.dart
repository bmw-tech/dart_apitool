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

  @override
  Set<String>? entryPoints;

  InternalTypeAliasDeclaration._({
    required this.id,
    this.parentClassId,
    required this.name,
    required this.namespace,
    required this.aliasedTypeName,
    required this.isDeprecated,
    required this.entryPoints,
  });

  InternalTypeAliasDeclaration.fromTypeAliasElement(
      TypeAliasElement typeAliasElement,
      {String? namespace})
      : this._(
            id: InternalDeclarationUtils.getIdFromElement(typeAliasElement)!,
            parentClassId: typeAliasElement.enclosingElement3 is ClassElement ||
                    typeAliasElement.enclosingElement3 is ExtensionElement
                ? InternalDeclarationUtils.getIdFromElement(
                    typeAliasElement.enclosingElement3)
                : null,
            name: typeAliasElement.name,
            namespace: namespace,
            aliasedTypeName: typeAliasElement.aliasedType
                .getDisplayString(withNullability: true),
            isDeprecated: typeAliasElement.hasDeprecated,
            entryPoints: {});

  TypeAliasDeclaration toTypeAliasDeclaration() {
    final namespacePrefix = namespace == null ? '' : '$namespace.';
    return TypeAliasDeclaration(
      name: '$namespacePrefix$name',
      aliasedTypeName: aliasedTypeName,
      isDeprecated: isDeprecated,
      entryPoints: entryPoints,
    );
  }
}
