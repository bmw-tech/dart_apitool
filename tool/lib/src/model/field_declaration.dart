import 'package:freezed_annotation/freezed_annotation.dart';

import 'declaration.dart';

part 'field_declaration.freezed.dart';

/// represents a found FieldDeclaration
@freezed
class FieldDeclaration with _$FieldDeclaration implements Declaration {
  const FieldDeclaration._();

  /// the signature of this field declaration.
  ///
  /// Contains the type (including type parameters and nullability) as well as the name of this field
  String get signature => _computeSignature();

  @Implements<Declaration>()
  const factory FieldDeclaration({
    required String typeName,
    required String name,
    required bool isDeprecated,
    required bool isStatic,
  }) = _FieldDeclaration;

  /// helper to compute the signature of a field
  String _computeSignature() {
    return '$typeName $name';
  }
}
