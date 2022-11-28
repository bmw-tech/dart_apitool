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
    /// type of this field
    required String typeName,

    /// name of this field
    required String name,

    /// whether this field is deprecated
    required bool isDeprecated,

    /// whether this field is static
    required bool isStatic,

    /// whether this field is experimental
    required bool isExperimental,

    /// entry points this field is reachable through
    Set<String>? entryPoints,
  }) = _FieldDeclaration;

  /// helper to compute the signature of a field
  String _computeSignature() {
    return '$typeName $name';
  }
}
