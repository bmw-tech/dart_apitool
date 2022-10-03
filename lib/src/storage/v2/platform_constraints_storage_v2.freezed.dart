// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'platform_constraints_storage_v2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IOSPlatformConstraintsStorageV2 _$IOSPlatformConstraintsStorageV2FromJson(
    Map<String, dynamic> json) {
  return _IOSPlatformConstraintsStorageV2.fromJson(json);
}

/// @nodoc
mixin _$IOSPlatformConstraintsStorageV2 {
  num? get minimumOsVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IOSPlatformConstraintsStorageV2CopyWith<IOSPlatformConstraintsStorageV2>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IOSPlatformConstraintsStorageV2CopyWith<$Res> {
  factory $IOSPlatformConstraintsStorageV2CopyWith(
          IOSPlatformConstraintsStorageV2 value,
          $Res Function(IOSPlatformConstraintsStorageV2) then) =
      _$IOSPlatformConstraintsStorageV2CopyWithImpl<$Res>;
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class _$IOSPlatformConstraintsStorageV2CopyWithImpl<$Res>
    implements $IOSPlatformConstraintsStorageV2CopyWith<$Res> {
  _$IOSPlatformConstraintsStorageV2CopyWithImpl(this._value, this._then);

  final IOSPlatformConstraintsStorageV2 _value;
  // ignore: unused_field
  final $Res Function(IOSPlatformConstraintsStorageV2) _then;

  @override
  $Res call({
    Object? minimumOsVersion = freezed,
  }) {
    return _then(_value.copyWith(
      minimumOsVersion: minimumOsVersion == freezed
          ? _value.minimumOsVersion
          : minimumOsVersion // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
abstract class _$$_IOSPlatformConstraintsStorageV2CopyWith<$Res>
    implements $IOSPlatformConstraintsStorageV2CopyWith<$Res> {
  factory _$$_IOSPlatformConstraintsStorageV2CopyWith(
          _$_IOSPlatformConstraintsStorageV2 value,
          $Res Function(_$_IOSPlatformConstraintsStorageV2) then) =
      __$$_IOSPlatformConstraintsStorageV2CopyWithImpl<$Res>;
  @override
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class __$$_IOSPlatformConstraintsStorageV2CopyWithImpl<$Res>
    extends _$IOSPlatformConstraintsStorageV2CopyWithImpl<$Res>
    implements _$$_IOSPlatformConstraintsStorageV2CopyWith<$Res> {
  __$$_IOSPlatformConstraintsStorageV2CopyWithImpl(
      _$_IOSPlatformConstraintsStorageV2 _value,
      $Res Function(_$_IOSPlatformConstraintsStorageV2) _then)
      : super(_value, (v) => _then(v as _$_IOSPlatformConstraintsStorageV2));

  @override
  _$_IOSPlatformConstraintsStorageV2 get _value =>
      super._value as _$_IOSPlatformConstraintsStorageV2;

  @override
  $Res call({
    Object? minimumOsVersion = freezed,
  }) {
    return _then(_$_IOSPlatformConstraintsStorageV2(
      minimumOsVersion: minimumOsVersion == freezed
          ? _value.minimumOsVersion
          : minimumOsVersion // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IOSPlatformConstraintsStorageV2
    extends _IOSPlatformConstraintsStorageV2 {
  const _$_IOSPlatformConstraintsStorageV2({required this.minimumOsVersion})
      : super._();

  factory _$_IOSPlatformConstraintsStorageV2.fromJson(
          Map<String, dynamic> json) =>
      _$$_IOSPlatformConstraintsStorageV2FromJson(json);

  @override
  final num? minimumOsVersion;

  @override
  String toString() {
    return 'IOSPlatformConstraintsStorageV2(minimumOsVersion: $minimumOsVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IOSPlatformConstraintsStorageV2 &&
            const DeepCollectionEquality()
                .equals(other.minimumOsVersion, minimumOsVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(minimumOsVersion));

  @JsonKey(ignore: true)
  @override
  _$$_IOSPlatformConstraintsStorageV2CopyWith<
          _$_IOSPlatformConstraintsStorageV2>
      get copyWith => __$$_IOSPlatformConstraintsStorageV2CopyWithImpl<
          _$_IOSPlatformConstraintsStorageV2>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IOSPlatformConstraintsStorageV2ToJson(
      this,
    );
  }
}

abstract class _IOSPlatformConstraintsStorageV2
    extends IOSPlatformConstraintsStorageV2 {
  const factory _IOSPlatformConstraintsStorageV2(
          {required final num? minimumOsVersion}) =
      _$_IOSPlatformConstraintsStorageV2;
  const _IOSPlatformConstraintsStorageV2._() : super._();

  factory _IOSPlatformConstraintsStorageV2.fromJson(Map<String, dynamic> json) =
      _$_IOSPlatformConstraintsStorageV2.fromJson;

  @override
  num? get minimumOsVersion;
  @override
  @JsonKey(ignore: true)
  _$$_IOSPlatformConstraintsStorageV2CopyWith<
          _$_IOSPlatformConstraintsStorageV2>
      get copyWith => throw _privateConstructorUsedError;
}

AndroidPlatformConstraintsStorageV2
    _$AndroidPlatformConstraintsStorageV2FromJson(Map<String, dynamic> json) {
  return _AndroidPlatformConstraintsStorageV2.fromJson(json);
}

/// @nodoc
mixin _$AndroidPlatformConstraintsStorageV2 {
  int? get minSdkVersion => throw _privateConstructorUsedError;
  int? get compileSdkVersion => throw _privateConstructorUsedError;
  int? get targetSdkVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AndroidPlatformConstraintsStorageV2CopyWith<
          AndroidPlatformConstraintsStorageV2>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AndroidPlatformConstraintsStorageV2CopyWith<$Res> {
  factory $AndroidPlatformConstraintsStorageV2CopyWith(
          AndroidPlatformConstraintsStorageV2 value,
          $Res Function(AndroidPlatformConstraintsStorageV2) then) =
      _$AndroidPlatformConstraintsStorageV2CopyWithImpl<$Res>;
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class _$AndroidPlatformConstraintsStorageV2CopyWithImpl<$Res>
    implements $AndroidPlatformConstraintsStorageV2CopyWith<$Res> {
  _$AndroidPlatformConstraintsStorageV2CopyWithImpl(this._value, this._then);

  final AndroidPlatformConstraintsStorageV2 _value;
  // ignore: unused_field
  final $Res Function(AndroidPlatformConstraintsStorageV2) _then;

  @override
  $Res call({
    Object? minSdkVersion = freezed,
    Object? compileSdkVersion = freezed,
    Object? targetSdkVersion = freezed,
  }) {
    return _then(_value.copyWith(
      minSdkVersion: minSdkVersion == freezed
          ? _value.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      compileSdkVersion: compileSdkVersion == freezed
          ? _value.compileSdkVersion
          : compileSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      targetSdkVersion: targetSdkVersion == freezed
          ? _value.targetSdkVersion
          : targetSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_AndroidPlatformConstraintsStorageV2CopyWith<$Res>
    implements $AndroidPlatformConstraintsStorageV2CopyWith<$Res> {
  factory _$$_AndroidPlatformConstraintsStorageV2CopyWith(
          _$_AndroidPlatformConstraintsStorageV2 value,
          $Res Function(_$_AndroidPlatformConstraintsStorageV2) then) =
      __$$_AndroidPlatformConstraintsStorageV2CopyWithImpl<$Res>;
  @override
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class __$$_AndroidPlatformConstraintsStorageV2CopyWithImpl<$Res>
    extends _$AndroidPlatformConstraintsStorageV2CopyWithImpl<$Res>
    implements _$$_AndroidPlatformConstraintsStorageV2CopyWith<$Res> {
  __$$_AndroidPlatformConstraintsStorageV2CopyWithImpl(
      _$_AndroidPlatformConstraintsStorageV2 _value,
      $Res Function(_$_AndroidPlatformConstraintsStorageV2) _then)
      : super(
            _value, (v) => _then(v as _$_AndroidPlatformConstraintsStorageV2));

  @override
  _$_AndroidPlatformConstraintsStorageV2 get _value =>
      super._value as _$_AndroidPlatformConstraintsStorageV2;

  @override
  $Res call({
    Object? minSdkVersion = freezed,
    Object? compileSdkVersion = freezed,
    Object? targetSdkVersion = freezed,
  }) {
    return _then(_$_AndroidPlatformConstraintsStorageV2(
      minSdkVersion: minSdkVersion == freezed
          ? _value.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      compileSdkVersion: compileSdkVersion == freezed
          ? _value.compileSdkVersion
          : compileSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      targetSdkVersion: targetSdkVersion == freezed
          ? _value.targetSdkVersion
          : targetSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AndroidPlatformConstraintsStorageV2
    extends _AndroidPlatformConstraintsStorageV2 {
  const _$_AndroidPlatformConstraintsStorageV2(
      {required this.minSdkVersion,
      required this.compileSdkVersion,
      required this.targetSdkVersion})
      : super._();

  factory _$_AndroidPlatformConstraintsStorageV2.fromJson(
          Map<String, dynamic> json) =>
      _$$_AndroidPlatformConstraintsStorageV2FromJson(json);

  @override
  final int? minSdkVersion;
  @override
  final int? compileSdkVersion;
  @override
  final int? targetSdkVersion;

  @override
  String toString() {
    return 'AndroidPlatformConstraintsStorageV2(minSdkVersion: $minSdkVersion, compileSdkVersion: $compileSdkVersion, targetSdkVersion: $targetSdkVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AndroidPlatformConstraintsStorageV2 &&
            const DeepCollectionEquality()
                .equals(other.minSdkVersion, minSdkVersion) &&
            const DeepCollectionEquality()
                .equals(other.compileSdkVersion, compileSdkVersion) &&
            const DeepCollectionEquality()
                .equals(other.targetSdkVersion, targetSdkVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(minSdkVersion),
      const DeepCollectionEquality().hash(compileSdkVersion),
      const DeepCollectionEquality().hash(targetSdkVersion));

  @JsonKey(ignore: true)
  @override
  _$$_AndroidPlatformConstraintsStorageV2CopyWith<
          _$_AndroidPlatformConstraintsStorageV2>
      get copyWith => __$$_AndroidPlatformConstraintsStorageV2CopyWithImpl<
          _$_AndroidPlatformConstraintsStorageV2>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AndroidPlatformConstraintsStorageV2ToJson(
      this,
    );
  }
}

abstract class _AndroidPlatformConstraintsStorageV2
    extends AndroidPlatformConstraintsStorageV2 {
  const factory _AndroidPlatformConstraintsStorageV2(
          {required final int? minSdkVersion,
          required final int? compileSdkVersion,
          required final int? targetSdkVersion}) =
      _$_AndroidPlatformConstraintsStorageV2;
  const _AndroidPlatformConstraintsStorageV2._() : super._();

  factory _AndroidPlatformConstraintsStorageV2.fromJson(
          Map<String, dynamic> json) =
      _$_AndroidPlatformConstraintsStorageV2.fromJson;

  @override
  int? get minSdkVersion;
  @override
  int? get compileSdkVersion;
  @override
  int? get targetSdkVersion;
  @override
  @JsonKey(ignore: true)
  _$$_AndroidPlatformConstraintsStorageV2CopyWith<
          _$_AndroidPlatformConstraintsStorageV2>
      get copyWith => throw _privateConstructorUsedError;
}
