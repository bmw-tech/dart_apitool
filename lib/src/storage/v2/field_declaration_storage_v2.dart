import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'field_declaration_storage_v2.freezed.dart';
part 'field_declaration_storage_v2.g.dart';

/// represents a found FieldDeclaration
@freezed
class FieldDeclarationStorageV2 with _$FieldDeclarationStorageV2 {
  const FieldDeclarationStorageV2._();

  const factory FieldDeclarationStorageV2({
    required String typeName,
    required String name,
    required bool isDeprecated,
    required bool isStatic,
    Set<String>? entryPoints,
  }) = _FieldDeclarationStorageV2;

  factory FieldDeclarationStorageV2.fromJson(Map<String, Object?> json) =>
      _$FieldDeclarationStorageV2FromJson(json);

  FieldDeclaration toFieldDeclaration() {
    return FieldDeclaration(
      typeName: typeName,
      name: name,
      isDeprecated: isDeprecated,
      isStatic: isStatic,
      entryPoints: entryPoints,
    );
  }

  static FieldDeclarationStorageV2 fromFieldDeclaration(
      FieldDeclaration fieldDeclaration) {
    return FieldDeclarationStorageV2(
      typeName: fieldDeclaration.typeName,
      name: fieldDeclaration.name,
      isDeprecated: fieldDeclaration.isDeprecated,
      isStatic: fieldDeclaration.isStatic,
      entryPoints: fieldDeclaration.entryPoints,
    );
  }
}
