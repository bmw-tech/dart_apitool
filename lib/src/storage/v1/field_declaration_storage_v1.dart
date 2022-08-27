import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'field_declaration_storage_v1.freezed.dart';
part 'field_declaration_storage_v1.g.dart';

/// represents a found FieldDeclaration
@freezed
class FieldDeclarationStorageV1 with _$FieldDeclarationStorageV1 {
  const FieldDeclarationStorageV1._();

  const factory FieldDeclarationStorageV1({
    required String typeName,
    required String name,
    required bool isDeprecated,
    required bool isStatic,
    Set<String>? entryPoints,
  }) = _FieldDeclarationStorageV1;

  factory FieldDeclarationStorageV1.fromJson(Map<String, Object?> json) =>
      _$FieldDeclarationStorageV1FromJson(json);

  FieldDeclaration toFieldDeclaration() {
    return FieldDeclaration(
      typeName: typeName,
      name: name,
      isDeprecated: isDeprecated,
      isStatic: isStatic,
      entryPoints: entryPoints,
    );
  }

  static FieldDeclarationStorageV1 fromFieldDeclaration(
      FieldDeclaration fieldDeclaration) {
    return FieldDeclarationStorageV1(
      typeName: fieldDeclaration.typeName,
      name: fieldDeclaration.name,
      isDeprecated: fieldDeclaration.isDeprecated,
      isStatic: fieldDeclaration.isStatic,
      entryPoints: fieldDeclaration.entryPoints,
    );
  }
}
