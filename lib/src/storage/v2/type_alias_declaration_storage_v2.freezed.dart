// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'type_alias_declaration_storage_v2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TypeAliasDeclarationStorageV2 _$TypeAliasDeclarationStorageV2FromJson(
    Map<String, dynamic> json) {
  return _TypeAliasDeclarationStorageV2.fromJson(json);
}

/// @nodoc
mixin _$TypeAliasDeclarationStorageV2 {
  String get name => throw _privateConstructorUsedError;
  String get aliasedTypeName => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;
  Set<String> get entryPoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TypeAliasDeclarationStorageV2CopyWith<TypeAliasDeclarationStorageV2>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeAliasDeclarationStorageV2CopyWith<$Res> {
  factory $TypeAliasDeclarationStorageV2CopyWith(
          TypeAliasDeclarationStorageV2 value,
          $Res Function(TypeAliasDeclarationStorageV2) then) =
      _$TypeAliasDeclarationStorageV2CopyWithImpl<$Res>;
  $Res call(
      {String name,
      String aliasedTypeName,
      bool isDeprecated,
      Set<String> entryPoints});
}

/// @nodoc
class _$TypeAliasDeclarationStorageV2CopyWithImpl<$Res>
    implements $TypeAliasDeclarationStorageV2CopyWith<$Res> {
  _$TypeAliasDeclarationStorageV2CopyWithImpl(this._value, this._then);

  final TypeAliasDeclarationStorageV2 _value;
  // ignore: unused_field
  final $Res Function(TypeAliasDeclarationStorageV2) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? aliasedTypeName = freezed,
    Object? isDeprecated = freezed,
    Object? entryPoints = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aliasedTypeName: aliasedTypeName == freezed
          ? _value.aliasedTypeName
          : aliasedTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      entryPoints: entryPoints == freezed
          ? _value.entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_TypeAliasDeclarationStorageV2CopyWith<$Res>
    implements $TypeAliasDeclarationStorageV2CopyWith<$Res> {
  factory _$$_TypeAliasDeclarationStorageV2CopyWith(
          _$_TypeAliasDeclarationStorageV2 value,
          $Res Function(_$_TypeAliasDeclarationStorageV2) then) =
      __$$_TypeAliasDeclarationStorageV2CopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String aliasedTypeName,
      bool isDeprecated,
      Set<String> entryPoints});
}

/// @nodoc
class __$$_TypeAliasDeclarationStorageV2CopyWithImpl<$Res>
    extends _$TypeAliasDeclarationStorageV2CopyWithImpl<$Res>
    implements _$$_TypeAliasDeclarationStorageV2CopyWith<$Res> {
  __$$_TypeAliasDeclarationStorageV2CopyWithImpl(
      _$_TypeAliasDeclarationStorageV2 _value,
      $Res Function(_$_TypeAliasDeclarationStorageV2) _then)
      : super(_value, (v) => _then(v as _$_TypeAliasDeclarationStorageV2));

  @override
  _$_TypeAliasDeclarationStorageV2 get _value =>
      super._value as _$_TypeAliasDeclarationStorageV2;

  @override
  $Res call({
    Object? name = freezed,
    Object? aliasedTypeName = freezed,
    Object? isDeprecated = freezed,
    Object? entryPoints = freezed,
  }) {
    return _then(_$_TypeAliasDeclarationStorageV2(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aliasedTypeName: aliasedTypeName == freezed
          ? _value.aliasedTypeName
          : aliasedTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      entryPoints: entryPoints == freezed
          ? _value._entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TypeAliasDeclarationStorageV2 extends _TypeAliasDeclarationStorageV2 {
  const _$_TypeAliasDeclarationStorageV2(
      {required this.name,
      required this.aliasedTypeName,
      required this.isDeprecated,
      required final Set<String> entryPoints})
      : _entryPoints = entryPoints,
        super._();

  factory _$_TypeAliasDeclarationStorageV2.fromJson(
          Map<String, dynamic> json) =>
      _$$_TypeAliasDeclarationStorageV2FromJson(json);

  @override
  final String name;
  @override
  final String aliasedTypeName;
  @override
  final bool isDeprecated;
  final Set<String> _entryPoints;
  @override
  Set<String> get entryPoints {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_entryPoints);
  }

  @override
  String toString() {
    return 'TypeAliasDeclarationStorageV2(name: $name, aliasedTypeName: $aliasedTypeName, isDeprecated: $isDeprecated, entryPoints: $entryPoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TypeAliasDeclarationStorageV2 &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.aliasedTypeName, aliasedTypeName) &&
            const DeepCollectionEquality()
                .equals(other.isDeprecated, isDeprecated) &&
            const DeepCollectionEquality()
                .equals(other._entryPoints, _entryPoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(aliasedTypeName),
      const DeepCollectionEquality().hash(isDeprecated),
      const DeepCollectionEquality().hash(_entryPoints));

  @JsonKey(ignore: true)
  @override
  _$$_TypeAliasDeclarationStorageV2CopyWith<_$_TypeAliasDeclarationStorageV2>
      get copyWith => __$$_TypeAliasDeclarationStorageV2CopyWithImpl<
          _$_TypeAliasDeclarationStorageV2>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TypeAliasDeclarationStorageV2ToJson(
      this,
    );
  }
}

abstract class _TypeAliasDeclarationStorageV2
    extends TypeAliasDeclarationStorageV2 {
  const factory _TypeAliasDeclarationStorageV2(
          {required final String name,
          required final String aliasedTypeName,
          required final bool isDeprecated,
          required final Set<String> entryPoints}) =
      _$_TypeAliasDeclarationStorageV2;
  const _TypeAliasDeclarationStorageV2._() : super._();

  factory _TypeAliasDeclarationStorageV2.fromJson(Map<String, dynamic> json) =
      _$_TypeAliasDeclarationStorageV2.fromJson;

  @override
  String get name;
  @override
  String get aliasedTypeName;
  @override
  bool get isDeprecated;
  @override
  Set<String> get entryPoints;
  @override
  @JsonKey(ignore: true)
  _$$_TypeAliasDeclarationStorageV2CopyWith<_$_TypeAliasDeclarationStorageV2>
      get copyWith => throw _privateConstructorUsedError;
}
