import 'package:freezed_annotation/freezed_annotation.dart';

import 'declaration.dart';

part 'type_alias_declaration.freezed.dart';

/// represents a found TypeAliasDeclaration
@freezed
sealed class TypeAliasDeclaration
    with _$TypeAliasDeclaration
    implements Declaration {
  const TypeAliasDeclaration._();

  /// the signature of this type alias declaration.
  ///
  /// Contains the type (including type parameters and nullability) as well as the name of this field
  String get signature => _computeSignature();

  @Implements<Declaration>()
  const factory TypeAliasDeclaration({
    /// name of this type alias
    required String name,

    /// name of the aliased type
    required String aliasedTypeName,

    /// whether this type alias is deprecated
    required bool isDeprecated,

    /// whether this type alias is experimental
    required bool isExperimental,

    /// entry points this type alias is reachable through
    Set<String>? entryPoints,

    /// the relative path of the library
    required String relativePath,
  }) = _TypeAliasDeclaration;

  /// helper to compute the signature of a field
  String _computeSignature() {
    return '$name = $aliasedTypeName';
  }
}
