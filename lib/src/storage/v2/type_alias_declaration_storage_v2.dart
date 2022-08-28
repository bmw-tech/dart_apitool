import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'type_alias_declaration_storage_v2.freezed.dart';
part 'type_alias_declaration_storage_v2.g.dart';

/// represents a found FieldDeclaration
@freezed
class TypeAliasDeclarationStorageV2 with _$TypeAliasDeclarationStorageV2 {
  const TypeAliasDeclarationStorageV2._();

  const factory TypeAliasDeclarationStorageV2({
    required String name,
    required String aliasedTypeName,
    required bool isDeprecated,
    Set<String>? entryPoints,
  }) = _TypeAliasDeclarationStorageV2;

  factory TypeAliasDeclarationStorageV2.fromJson(Map<String, Object?> json) =>
      _$TypeAliasDeclarationStorageV2FromJson(json);

  TypeAliasDeclaration toTypeAliasDeclaration() {
    return TypeAliasDeclaration(
      name: name,
      aliasedTypeName: aliasedTypeName,
      isDeprecated: isDeprecated,
      entryPoints: entryPoints,
    );
  }

  static TypeAliasDeclarationStorageV2 fromTypeAliasDeclaration(
      TypeAliasDeclaration typeAliasDeclaration) {
    return TypeAliasDeclarationStorageV2(
      name: typeAliasDeclaration.name,
      aliasedTypeName: typeAliasDeclaration.aliasedTypeName,
      isDeprecated: typeAliasDeclaration.isDeprecated,
      entryPoints: typeAliasDeclaration.entryPoints,
    );
  }
}
