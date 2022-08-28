// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'field_declaration_storage_v2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FieldDeclarationStorageV2 _$FieldDeclarationStorageV2FromJson(
    Map<String, dynamic> json) {
  return _FieldDeclarationStorageV2.fromJson(json);
}

/// @nodoc
mixin _$FieldDeclarationStorageV2 {
  String get typeName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;
  bool get isStatic => throw _privateConstructorUsedError;
  Set<String> get entryPoints => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldDeclarationStorageV2CopyWith<FieldDeclarationStorageV2> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldDeclarationStorageV2CopyWith<$Res> {
  factory $FieldDeclarationStorageV2CopyWith(FieldDeclarationStorageV2 value,
          $Res Function(FieldDeclarationStorageV2) then) =
      _$FieldDeclarationStorageV2CopyWithImpl<$Res>;
  $Res call(
      {String typeName,
      String name,
      bool isDeprecated,
      bool isStatic,
      Set<String> entryPoints});
}

/// @nodoc
class _$FieldDeclarationStorageV2CopyWithImpl<$Res>
    implements $FieldDeclarationStorageV2CopyWith<$Res> {
  _$FieldDeclarationStorageV2CopyWithImpl(this._value, this._then);

  final FieldDeclarationStorageV2 _value;
  // ignore: unused_field
  final $Res Function(FieldDeclarationStorageV2) _then;

  @override
  $Res call({
    Object? typeName = freezed,
    Object? name = freezed,
    Object? isDeprecated = freezed,
    Object? isStatic = freezed,
    Object? entryPoints = freezed,
  }) {
    return _then(_value.copyWith(
      typeName: typeName == freezed
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isStatic: isStatic == freezed
          ? _value.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
      entryPoints: entryPoints == freezed
          ? _value.entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_FieldDeclarationStorageV2CopyWith<$Res>
    implements $FieldDeclarationStorageV2CopyWith<$Res> {
  factory _$$_FieldDeclarationStorageV2CopyWith(
          _$_FieldDeclarationStorageV2 value,
          $Res Function(_$_FieldDeclarationStorageV2) then) =
      __$$_FieldDeclarationStorageV2CopyWithImpl<$Res>;
  @override
  $Res call(
      {String typeName,
      String name,
      bool isDeprecated,
      bool isStatic,
      Set<String> entryPoints});
}

/// @nodoc
class __$$_FieldDeclarationStorageV2CopyWithImpl<$Res>
    extends _$FieldDeclarationStorageV2CopyWithImpl<$Res>
    implements _$$_FieldDeclarationStorageV2CopyWith<$Res> {
  __$$_FieldDeclarationStorageV2CopyWithImpl(
      _$_FieldDeclarationStorageV2 _value,
      $Res Function(_$_FieldDeclarationStorageV2) _then)
      : super(_value, (v) => _then(v as _$_FieldDeclarationStorageV2));

  @override
  _$_FieldDeclarationStorageV2 get _value =>
      super._value as _$_FieldDeclarationStorageV2;

  @override
  $Res call({
    Object? typeName = freezed,
    Object? name = freezed,
    Object? isDeprecated = freezed,
    Object? isStatic = freezed,
    Object? entryPoints = freezed,
  }) {
    return _then(_$_FieldDeclarationStorageV2(
      typeName: typeName == freezed
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isStatic: isStatic == freezed
          ? _value.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
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
class _$_FieldDeclarationStorageV2 extends _FieldDeclarationStorageV2 {
  const _$_FieldDeclarationStorageV2(
      {required this.typeName,
      required this.name,
      required this.isDeprecated,
      required this.isStatic,
      required final Set<String> entryPoints})
      : _entryPoints = entryPoints,
        super._();

  factory _$_FieldDeclarationStorageV2.fromJson(Map<String, dynamic> json) =>
      _$$_FieldDeclarationStorageV2FromJson(json);

  @override
  final String typeName;
  @override
  final String name;
  @override
  final bool isDeprecated;
  @override
  final bool isStatic;
  final Set<String> _entryPoints;
  @override
  Set<String> get entryPoints {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_entryPoints);
  }

  @override
  String toString() {
    return 'FieldDeclarationStorageV2(typeName: $typeName, name: $name, isDeprecated: $isDeprecated, isStatic: $isStatic, entryPoints: $entryPoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FieldDeclarationStorageV2 &&
            const DeepCollectionEquality().equals(other.typeName, typeName) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.isDeprecated, isDeprecated) &&
            const DeepCollectionEquality().equals(other.isStatic, isStatic) &&
            const DeepCollectionEquality()
                .equals(other._entryPoints, _entryPoints));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(typeName),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(isDeprecated),
      const DeepCollectionEquality().hash(isStatic),
      const DeepCollectionEquality().hash(_entryPoints));

  @JsonKey(ignore: true)
  @override
  _$$_FieldDeclarationStorageV2CopyWith<_$_FieldDeclarationStorageV2>
      get copyWith => __$$_FieldDeclarationStorageV2CopyWithImpl<
          _$_FieldDeclarationStorageV2>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FieldDeclarationStorageV2ToJson(
      this,
    );
  }
}

abstract class _FieldDeclarationStorageV2 extends FieldDeclarationStorageV2 {
  const factory _FieldDeclarationStorageV2(
      {required final String typeName,
      required final String name,
      required final bool isDeprecated,
      required final bool isStatic,
      required final Set<String> entryPoints}) = _$_FieldDeclarationStorageV2;
  const _FieldDeclarationStorageV2._() : super._();

  factory _FieldDeclarationStorageV2.fromJson(Map<String, dynamic> json) =
      _$_FieldDeclarationStorageV2.fromJson;

  @override
  String get typeName;
  @override
  String get name;
  @override
  bool get isDeprecated;
  @override
  bool get isStatic;
  @override
  Set<String> get entryPoints;
  @override
  @JsonKey(ignore: true)
  _$$_FieldDeclarationStorageV2CopyWith<_$_FieldDeclarationStorageV2>
      get copyWith => throw _privateConstructorUsedError;
}
