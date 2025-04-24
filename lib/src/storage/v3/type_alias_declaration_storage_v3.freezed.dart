// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_alias_declaration_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TypeAliasDeclarationStorageV3 {
  String get name;
  String get aliasedTypeName;
  bool get isDeprecated;
  bool get isExperimental;
  Set<String> get entryPoints;
  String get relativePath;

  /// Create a copy of TypeAliasDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TypeAliasDeclarationStorageV3CopyWith<TypeAliasDeclarationStorageV3>
      get copyWith => _$TypeAliasDeclarationStorageV3CopyWithImpl<
              TypeAliasDeclarationStorageV3>(
          this as TypeAliasDeclarationStorageV3, _$identity);

  /// Serializes this TypeAliasDeclarationStorageV3 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TypeAliasDeclarationStorageV3 &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    return 'TypeAliasDeclarationStorageV3(name: $name, aliasedTypeName: $aliasedTypeName, isDeprecated: $isDeprecated, isExperimental: $isExperimental, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class $TypeAliasDeclarationStorageV3CopyWith<$Res> {
  factory $TypeAliasDeclarationStorageV3CopyWith(
          TypeAliasDeclarationStorageV3 value,
          $Res Function(TypeAliasDeclarationStorageV3) _then) =
      _$TypeAliasDeclarationStorageV3CopyWithImpl;
  @useResult
  $Res call(
      {String name,
      String aliasedTypeName,
      bool isDeprecated,
      bool isExperimental,
      Set<String> entryPoints,
      String relativePath});
}

/// @nodoc
class _$TypeAliasDeclarationStorageV3CopyWithImpl<$Res>
    implements $TypeAliasDeclarationStorageV3CopyWith<$Res> {
  _$TypeAliasDeclarationStorageV3CopyWithImpl(this._self, this._then);

  final TypeAliasDeclarationStorageV3 _self;
  final $Res Function(TypeAliasDeclarationStorageV3) _then;

  /// Create a copy of TypeAliasDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aliasedTypeName = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? entryPoints = null,
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
      entryPoints: null == entryPoints
          ? _self.entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TypeAliasDeclarationStorageV3 extends TypeAliasDeclarationStorageV3 {
  const _TypeAliasDeclarationStorageV3(
      {required this.name,
      required this.aliasedTypeName,
      required this.isDeprecated,
      required this.isExperimental,
      required final Set<String> entryPoints,
      required this.relativePath})
      : _entryPoints = entryPoints,
        super._();
  factory _TypeAliasDeclarationStorageV3.fromJson(Map<String, dynamic> json) =>
      _$TypeAliasDeclarationStorageV3FromJson(json);

  @override
  final String name;
  @override
  final String aliasedTypeName;
  @override
  final bool isDeprecated;
  @override
  final bool isExperimental;
  final Set<String> _entryPoints;
  @override
  Set<String> get entryPoints {
    if (_entryPoints is EqualUnmodifiableSetView) return _entryPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_entryPoints);
  }

  @override
  final String relativePath;

  /// Create a copy of TypeAliasDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypeAliasDeclarationStorageV3CopyWith<_TypeAliasDeclarationStorageV3>
      get copyWith => __$TypeAliasDeclarationStorageV3CopyWithImpl<
          _TypeAliasDeclarationStorageV3>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TypeAliasDeclarationStorageV3ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TypeAliasDeclarationStorageV3 &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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
    return 'TypeAliasDeclarationStorageV3(name: $name, aliasedTypeName: $aliasedTypeName, isDeprecated: $isDeprecated, isExperimental: $isExperimental, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class _$TypeAliasDeclarationStorageV3CopyWith<$Res>
    implements $TypeAliasDeclarationStorageV3CopyWith<$Res> {
  factory _$TypeAliasDeclarationStorageV3CopyWith(
          _TypeAliasDeclarationStorageV3 value,
          $Res Function(_TypeAliasDeclarationStorageV3) _then) =
      __$TypeAliasDeclarationStorageV3CopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      String aliasedTypeName,
      bool isDeprecated,
      bool isExperimental,
      Set<String> entryPoints,
      String relativePath});
}

/// @nodoc
class __$TypeAliasDeclarationStorageV3CopyWithImpl<$Res>
    implements _$TypeAliasDeclarationStorageV3CopyWith<$Res> {
  __$TypeAliasDeclarationStorageV3CopyWithImpl(this._self, this._then);

  final _TypeAliasDeclarationStorageV3 _self;
  final $Res Function(_TypeAliasDeclarationStorageV3) _then;

  /// Create a copy of TypeAliasDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? aliasedTypeName = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? entryPoints = null,
    Object? relativePath = null,
  }) {
    return _then(_TypeAliasDeclarationStorageV3(
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
      entryPoints: null == entryPoints
          ? _self._entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
