import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'type_alias_declaration_storage_v3.freezed.dart';
part 'type_alias_declaration_storage_v3.g.dart';

/// represents a found FieldDeclaration
@freezed
sealed class TypeAliasDeclarationStorageV3
    with _$TypeAliasDeclarationStorageV3 {
  const TypeAliasDeclarationStorageV3._();

  const factory TypeAliasDeclarationStorageV3({
    required String name,
    required String aliasedTypeName,
    required bool isDeprecated,
    required bool isExperimental,
    required Set<String> entryPoints,
    required String relativePath,
  }) = _TypeAliasDeclarationStorageV3;

  factory TypeAliasDeclarationStorageV3.fromJson(Map<String, Object?> json) =>
      _$TypeAliasDeclarationStorageV3FromJson(json);

  static TypeAliasDeclarationStorageV3 fromTypeAliasDeclaration(
      TypeAliasDeclaration typeAliasDeclaration) {
    return TypeAliasDeclarationStorageV3(
      name: typeAliasDeclaration.name,
      aliasedTypeName: typeAliasDeclaration.aliasedTypeName,
      isDeprecated: typeAliasDeclaration.isDeprecated,
      isExperimental: typeAliasDeclaration.isExperimental,
      entryPoints: typeAliasDeclaration.entryPoints!,
      relativePath: typeAliasDeclaration.relativePath,
    );
  }
}
