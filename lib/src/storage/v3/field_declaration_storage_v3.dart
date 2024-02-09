import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'field_declaration_storage_v3.freezed.dart';
part 'field_declaration_storage_v3.g.dart';

/// represents a found FieldDeclaration
@freezed
class FieldDeclarationStorageV3 with _$FieldDeclarationStorageV3 {
  const FieldDeclarationStorageV3._();

  const factory FieldDeclarationStorageV3({
    required String typeName,
    required String name,
    required bool isDeprecated,
    required bool isExperimental,
    required bool isStatic,
    required Set<String> entryPoints,
    required String relativePath,
    required bool isReadable,
    required bool isWriteable,
  }) = _FieldDeclarationStorageV3;

  factory FieldDeclarationStorageV3.fromJson(Map<String, Object?> json) =>
      _$FieldDeclarationStorageV3FromJson(json);

  static FieldDeclarationStorageV3 fromFieldDeclaration(
      FieldDeclaration fieldDeclaration) {
    return FieldDeclarationStorageV3(
      typeName: fieldDeclaration.typeName,
      name: fieldDeclaration.name,
      isDeprecated: fieldDeclaration.isDeprecated,
      isExperimental: fieldDeclaration.isExperimental,
      isStatic: fieldDeclaration.isStatic,
      entryPoints: fieldDeclaration.entryPoints!,
      relativePath: fieldDeclaration.relativePath,
      isReadable: fieldDeclaration.isReadable,
      isWriteable: fieldDeclaration.isWriteable,
    );
  }
}
