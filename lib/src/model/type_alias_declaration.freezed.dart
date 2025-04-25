// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_alias_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TypeAliasDeclaration {
  /// name of this type alias
  String get name;

  /// name of the aliased type
  String get aliasedTypeName;

  /// whether this type alias is deprecated
  bool get isDeprecated;

  /// whether this type alias is experimental
  bool get isExperimental;

  /// entry points this type alias is reachable through
  Set<String>? get entryPoints;

  /// the relative path of the library
  String get relativePath;

  /// Create a copy of TypeAliasDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TypeAliasDeclarationCopyWith<TypeAliasDeclaration> get copyWith =>
      _$TypeAliasDeclarationCopyWithImpl<TypeAliasDeclaration>(
          this as TypeAliasDeclaration, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TypeAliasDeclaration &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.aliasedTypeName, aliasedTypeName) ||
                other.aliasedTypeName == aliasedTypeName) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            const DeepCollectionEquality()
                .equals(other.entryPoints, entryPoints) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      aliasedTypeName,
      isDeprecated,
      isExperimental,
      const DeepCollectionEquality().hash(entryPoints),
      relativePath);

  @override
  String toString() {
    return 'TypeAliasDeclaration(name: $name, aliasedTypeName: $aliasedTypeName, isDeprecated: $isDeprecated, isExperimental: $isExperimental, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class $TypeAliasDeclarationCopyWith<$Res> {
  factory $TypeAliasDeclarationCopyWith(TypeAliasDeclaration value,
          $Res Function(TypeAliasDeclaration) _then) =
      _$TypeAliasDeclarationCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      String aliasedTypeName,
      bool isDeprecated,
      bool isExperimental,
      Set<String>? entryPoints,
      String relativePath});
}

/// @nodoc
class _$TypeAliasDeclarationCopyWithImpl<$Res>
    implements $TypeAliasDeclarationCopyWith<$Res> {
  _$TypeAliasDeclarationCopyWithImpl(this._self, this._then);

  final TypeAliasDeclaration _self;
  final $Res Function(TypeAliasDeclaration) _then;

  /// Create a copy of TypeAliasDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aliasedTypeName = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? entryPoints = freezed,
    Object? relativePath = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aliasedTypeName: null == aliasedTypeName
          ? _self.aliasedTypeName
          : aliasedTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _self.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isExperimental: null == isExperimental
          ? _self.isExperimental
          : isExperimental // ignore: cast_nullable_to_non_nullable
              as bool,
      entryPoints: freezed == entryPoints
          ? _self.entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _TypeAliasDeclaration extends TypeAliasDeclaration
    implements Declaration {
  const _TypeAliasDeclaration(
      {required this.name,
      required this.aliasedTypeName,
      required this.isDeprecated,
      required this.isExperimental,
      final Set<String>? entryPoints,
      required this.relativePath})
      : _entryPoints = entryPoints,
        super._();

  /// name of this type alias
  @override
  final String name;

  /// name of the aliased type
  @override
  final String aliasedTypeName;

  /// whether this type alias is deprecated
  @override
  final bool isDeprecated;

  /// whether this type alias is experimental
  @override
  final bool isExperimental;

  /// entry points this type alias is reachable through
  final Set<String>? _entryPoints;

  /// entry points this type alias is reachable through
  @override
  Set<String>? get entryPoints {
    final value = _entryPoints;
    if (value == null) return null;
    if (_entryPoints is EqualUnmodifiableSetView) return _entryPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  /// the relative path of the library
  @override
  final String relativePath;

  /// Create a copy of TypeAliasDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypeAliasDeclarationCopyWith<_TypeAliasDeclaration> get copyWith =>
      __$TypeAliasDeclarationCopyWithImpl<_TypeAliasDeclaration>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TypeAliasDeclaration &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.aliasedTypeName, aliasedTypeName) ||
                other.aliasedTypeName == aliasedTypeName) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            const DeepCollectionEquality()
                .equals(other._entryPoints, _entryPoints) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      aliasedTypeName,
      isDeprecated,
      isExperimental,
      const DeepCollectionEquality().hash(_entryPoints),
      relativePath);

  @override
  String toString() {
    return 'TypeAliasDeclaration(name: $name, aliasedTypeName: $aliasedTypeName, isDeprecated: $isDeprecated, isExperimental: $isExperimental, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class _$TypeAliasDeclarationCopyWith<$Res>
    implements $TypeAliasDeclarationCopyWith<$Res> {
  factory _$TypeAliasDeclarationCopyWith(_TypeAliasDeclaration value,
          $Res Function(_TypeAliasDeclaration) _then) =
      __$TypeAliasDeclarationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      String aliasedTypeName,
      bool isDeprecated,
      bool isExperimental,
      Set<String>? entryPoints,
      String relativePath});
}

/// @nodoc
class __$TypeAliasDeclarationCopyWithImpl<$Res>
    implements _$TypeAliasDeclarationCopyWith<$Res> {
  __$TypeAliasDeclarationCopyWithImpl(this._self, this._then);

  final _TypeAliasDeclaration _self;
  final $Res Function(_TypeAliasDeclaration) _then;

  /// Create a copy of TypeAliasDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? aliasedTypeName = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? entryPoints = freezed,
    Object? relativePath = null,
  }) {
    return _then(_TypeAliasDeclaration(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aliasedTypeName: null == aliasedTypeName
          ? _self.aliasedTypeName
          : aliasedTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _self.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isExperimental: null == isExperimental
          ? _self.isExperimental
          : isExperimental // ignore: cast_nullable_to_non_nullable
              as bool,
      entryPoints: freezed == entryPoints
          ? _self._entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
