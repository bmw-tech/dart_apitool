import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'type_alias_declaration_storage_v3.freezed.dart';
part 'type_alias_declaration_storage_v3.g.dart';

/// represents a found FieldDeclaration
@freezed
class TypeAliasDeclarationStorageV3 with _$TypeAliasDeclarationStorageV3 {
  const TypeAliasDeclarationStorageV3._();

  const factory TypeAliasDeclarationStorageV3({
    required String name,
    required String aliasedTypeName,
    required bool isDeprecated,
    required Set<String> entryPoints,
  }) = _TypeAliasDeclarationStorageV3;

  factory TypeAliasDeclarationStorageV3.fromJson(Map<String, Object?> json) =>
      _$TypeAliasDeclarationStorageV3FromJson(json);

  TypeAliasDeclaration toTypeAliasDeclaration() {
    return TypeAliasDeclaration(
      name: name,
      aliasedTypeName: aliasedTypeName,
      isDeprecated: isDeprecated,
      entryPoints: entryPoints,
    );
  }

  static TypeAliasDeclarationStorageV3 fromTypeAliasDeclaration(
      TypeAliasDeclaration typeAliasDeclaration) {
    return TypeAliasDeclarationStorageV3(
      name: typeAliasDeclaration.name,
      aliasedTypeName: typeAliasDeclaration.aliasedTypeName,
      isDeprecated: typeAliasDeclaration.isDeprecated,
      entryPoints: typeAliasDeclaration.entryPoints!,
    );
  }
}