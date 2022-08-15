// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'field_declaration_storage_v1.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FieldDeclarationStorageV1 _$FieldDeclarationStorageV1FromJson(
    Map<String, dynamic> json) {
  return _FieldDeclarationStorageV1.fromJson(json);
}

/// @nodoc
mixin _$FieldDeclarationStorageV1 {
  String get typeName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldDeclarationStorageV1CopyWith<FieldDeclarationStorageV1> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldDeclarationStorageV1CopyWith<$Res> {
  factory $FieldDeclarationStorageV1CopyWith(FieldDeclarationStorageV1 value,
          $Res Function(FieldDeclarationStorageV1) then) =
      _$FieldDeclarationStorageV1CopyWithImpl<$Res>;
  $Res call({String typeName, String name, bool isDeprecated});
}

/// @nodoc
class _$FieldDeclarationStorageV1CopyWithImpl<$Res>
    implements $FieldDeclarationStorageV1CopyWith<$Res> {
  _$FieldDeclarationStorageV1CopyWithImpl(this._value, this._then);

  final FieldDeclarationStorageV1 _value;
  // ignore: unused_field
  final $Res Function(FieldDeclarationStorageV1) _then;

  @override
  $Res call({
    Object? typeName = freezed,
    Object? name = freezed,
    Object? isDeprecated = freezed,
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
    ));
  }
}

/// @nodoc
abstract class _$$_FieldDeclarationStorageV1CopyWith<$Res>
    implements $FieldDeclarationStorageV1CopyWith<$Res> {
  factory _$$_FieldDeclarationStorageV1CopyWith(
          _$_FieldDeclarationStorageV1 value,
          $Res Function(_$_FieldDeclarationStorageV1) then) =
      __$$_FieldDeclarationStorageV1CopyWithImpl<$Res>;
  @override
  $Res call({String typeName, String name, bool isDeprecated});
}

/// @nodoc
class __$$_FieldDeclarationStorageV1CopyWithImpl<$Res>
    extends _$FieldDeclarationStorageV1CopyWithImpl<$Res>
    implements _$$_FieldDeclarationStorageV1CopyWith<$Res> {
  __$$_FieldDeclarationStorageV1CopyWithImpl(
      _$_FieldDeclarationStorageV1 _value,
      $Res Function(_$_FieldDeclarationStorageV1) _then)
      : super(_value, (v) => _then(v as _$_FieldDeclarationStorageV1));

  @override
  _$_FieldDeclarationStorageV1 get _value =>
      super._value as _$_FieldDeclarationStorageV1;

  @override
  $Res call({
    Object? typeName = freezed,
    Object? name = freezed,
    Object? isDeprecated = freezed,
  }) {
    return _then(_$_FieldDeclarationStorageV1(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FieldDeclarationStorageV1 extends _FieldDeclarationStorageV1 {
  const _$_FieldDeclarationStorageV1(
      {required this.typeName, required this.name, required this.isDeprecated})
      : super._();

  factory _$_FieldDeclarationStorageV1.fromJson(Map<String, dynamic> json) =>
      _$$_FieldDeclarationStorageV1FromJson(json);

  @override
  final String typeName;
  @override
  final String name;
  @override
  final bool isDeprecated;

  @override
  String toString() {
    return 'FieldDeclarationStorageV1(typeName: $typeName, name: $name, isDeprecated: $isDeprecated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FieldDeclarationStorageV1 &&
            const DeepCollectionEquality().equals(other.typeName, typeName) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.isDeprecated, isDeprecated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(typeName),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(isDeprecated));

  @JsonKey(ignore: true)
  @override
  _$$_FieldDeclarationStorageV1CopyWith<_$_FieldDeclarationStorageV1>
      get copyWith => __$$_FieldDeclarationStorageV1CopyWithImpl<
          _$_FieldDeclarationStorageV1>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FieldDeclarationStorageV1ToJson(
      this,
    );
  }
}

abstract class _FieldDeclarationStorageV1 extends FieldDeclarationStorageV1 {
  const factory _FieldDeclarationStorageV1(
      {required final String typeName,
      required final String name,
      required final bool isDeprecated}) = _$_FieldDeclarationStorageV1;
  const _FieldDeclarationStorageV1._() : super._();

  factory _FieldDeclarationStorageV1.fromJson(Map<String, dynamic> json) =
      _$_FieldDeclarationStorageV1.fromJson;

  @override
  String get typeName;
  @override
  String get name;
  @override
  bool get isDeprecated;
  @override
  @JsonKey(ignore: true)
  _$$_FieldDeclarationStorageV1CopyWith<_$_FieldDeclarationStorageV1>
      get copyWith => throw _privateConstructorUsedError;
}
