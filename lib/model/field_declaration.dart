import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_declaration.freezed.dart';
part 'field_declaration.g.dart';

/// represents a found FieldDeclaration
@freezed
class FieldDeclaration with _$FieldDeclaration {
  const FieldDeclaration._();

  /// the signature of this field declaration.
  ///
  /// Contains the type (including type parameters and nullability) as well as the name of this field
  String get signature => _computeSignature();

  const factory FieldDeclaration({
    required String typeName,
    required String name,
  }) = _FieldDeclaration;

  factory FieldDeclaration.fromJson(Map<String, Object?> json) =>
      _$FieldDeclarationFromJson(json);

  /// helper to compute the signature of a field
  String _computeSignature() {
    return '$typeName $name';
  }
}
