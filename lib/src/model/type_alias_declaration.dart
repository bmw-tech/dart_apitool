import 'package:freezed_annotation/freezed_annotation.dart';

import 'declaration.dart';

part 'type_alias_declaration.freezed.dart';

/// represents a found TypeAliasDeclaration
@freezed
class TypeAliasDeclaration with _$TypeAliasDeclaration implements Declaration {
  const TypeAliasDeclaration._();

  /// the signature of this type alias declaration.
  ///
  /// Contains the type (including type parameters and nullability) as well as the name of this field
  String get signature => _computeSignature();

  @Implements<Declaration>()
  const factory TypeAliasDeclaration({
    required String name,
    required String aliasedTypeName,
    required bool isDeprecated,
    Set<String>? entryPoints,
  }) = _TypeAliasDeclaration;

  /// helper to compute the signature of a field
  String _computeSignature() {
    return '$name = $aliasedTypeName';
  }
}
