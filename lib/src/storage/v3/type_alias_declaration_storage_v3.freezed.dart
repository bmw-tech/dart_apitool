// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'type_alias_declaration_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TypeAliasDeclarationStorageV3 _$TypeAliasDeclarationStorageV3FromJson(
    Map<String, dynamic> json) {
  return _TypeAliasDeclarationStorageV3.fromJson(json);
}

/// @nodoc
mixin _$TypeAliasDeclarationStorageV3 {
  String get name => throw _privateConstructorUsedError;
  String get aliasedTypeName => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;
  Set<String> get entryPoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TypeAliasDeclarationStorageV3CopyWith<TypeAliasDeclarationStorageV3>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeAliasDeclarationStorageV3CopyWith<$Res> {
  factory $TypeAliasDeclarationStorageV3CopyWith(
          TypeAliasDeclarationStorageV3 value,
          $Res Function(TypeAliasDeclarationStorageV3) then) =
      _$TypeAliasDeclarationStorageV3CopyWithImpl<$Res>;
  $Res call(
      {String name,
      String aliasedTypeName,
      bool isDeprecated,
      Set<String> entryPoints});
}

/// @nodoc
class _$TypeAliasDeclarationStorageV3CopyWithImpl<$Res>
    implements $TypeAliasDeclarationStorageV3CopyWith<$Res> {
  _$TypeAliasDeclarationStorageV3CopyWithImpl(this._value, this._then);

  final TypeAliasDeclarationStorageV3 _value;
  // ignore: unused_field
  final $Res Function(TypeAliasDeclarationStorageV3) _then;

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
abstract class _$$_TypeAliasDeclarationStorageV3CopyWith<$Res>
    implements $TypeAliasDeclarationStorageV3CopyWith<$Res> {
  factory _$$_TypeAliasDeclarationStorageV3CopyWith(
          _$_TypeAliasDeclarationStorageV3 value,
          $Res Function(_$_TypeAliasDeclarationStorageV3) then) =
      __$$_TypeAliasDeclarationStorageV3CopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String aliasedTypeName,
      bool isDeprecated,
      Set<String> entryPoints});
}

/// @nodoc
class __$$_TypeAliasDeclarationStorageV3CopyWithImpl<$Res>
    extends _$TypeAliasDeclarationStorageV3CopyWithImpl<$Res>
    implements _$$_TypeAliasDeclarationStorageV3CopyWith<$Res> {
  __$$_TypeAliasDeclarationStorageV3CopyWithImpl(
      _$_TypeAliasDeclarationStorageV3 _value,
      $Res Function(_$_TypeAliasDeclarationStorageV3) _then)
      : super(_value, (v) => _then(v as _$_TypeAliasDeclarationStorageV3));

  @override
  _$_TypeAliasDeclarationStorageV3 get _value =>
      super._value as _$_TypeAliasDeclarationStorageV3;

  @override
  $Res call({
    Object? name = freezed,
    Object? aliasedTypeName = freezed,
    Object? isDeprecated = freezed,
    Object? entryPoints = freezed,
  }) {
    return _then(_$_TypeAliasDeclarationStorageV3(
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
class _$_TypeAliasDeclarationStorageV3 extends _TypeAliasDeclarationStorageV3 {
  const _$_TypeAliasDeclarationStorageV3(
      {required this.name,
      required this.aliasedTypeName,
      required this.isDeprecated,
      required final Set<String> entryPoints})
      : _entryPoints = entryPoints,
        super._();

  factory _$_TypeAliasDeclarationStorageV3.fromJson(
          Map<String, dynamic> json) =>
      _$$_TypeAliasDeclarationStorageV3FromJson(json);

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
    return 'TypeAliasDeclarationStorageV3(name: $name, aliasedTypeName: $aliasedTypeName, isDeprecated: $isDeprecated, entryPoints: $entryPoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TypeAliasDeclarationStorageV3 &&
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
  _$$_TypeAliasDeclarationStorageV3CopyWith<_$_TypeAliasDeclarationStorageV3>
      get copyWith => __$$_TypeAliasDeclarationStorageV3CopyWithImpl<
          _$_TypeAliasDeclarationStorageV3>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TypeAliasDeclarationStorageV3ToJson(
      this,
    );
  }
}

abstract class _TypeAliasDeclarationStorageV3
    extends TypeAliasDeclarationStorageV3 {
  const factory _TypeAliasDeclarationStorageV3(
          {required final String name,
          required final String aliasedTypeName,
          required final bool isDeprecated,
          required final Set<String> entryPoints}) =
      _$_TypeAliasDeclarationStorageV3;
  const _TypeAliasDeclarationStorageV3._() : super._();

  factory _TypeAliasDeclarationStorageV3.fromJson(Map<String, dynamic> json) =
      _$_TypeAliasDeclarationStorageV3.fromJson;

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
  _$$_TypeAliasDeclarationStorageV3CopyWith<_$_TypeAliasDeclarationStorageV3>
      get copyWith => throw _privateConstructorUsedError;
}
