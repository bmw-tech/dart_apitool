// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'platform_constraints.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IOSPlatformConstraints {
  num? get minimumOsVersion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IOSPlatformConstraintsCopyWith<IOSPlatformConstraints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IOSPlatformConstraintsCopyWith<$Res> {
  factory $IOSPlatformConstraintsCopyWith(IOSPlatformConstraints value,
          $Res Function(IOSPlatformConstraints) then) =
      _$IOSPlatformConstraintsCopyWithImpl<$Res>;
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class _$IOSPlatformConstraintsCopyWithImpl<$Res>
    implements $IOSPlatformConstraintsCopyWith<$Res> {
  _$IOSPlatformConstraintsCopyWithImpl(this._value, this._then);

  final IOSPlatformConstraints _value;
  // ignore: unused_field
  final $Res Function(IOSPlatformConstraints) _then;

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
abstract class _$$_IOSPlatformConstraintsCopyWith<$Res>
    implements $IOSPlatformConstraintsCopyWith<$Res> {
  factory _$$_IOSPlatformConstraintsCopyWith(_$_IOSPlatformConstraints value,
          $Res Function(_$_IOSPlatformConstraints) then) =
      __$$_IOSPlatformConstraintsCopyWithImpl<$Res>;
  @override
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class __$$_IOSPlatformConstraintsCopyWithImpl<$Res>
    extends _$IOSPlatformConstraintsCopyWithImpl<$Res>
    implements _$$_IOSPlatformConstraintsCopyWith<$Res> {
  __$$_IOSPlatformConstraintsCopyWithImpl(_$_IOSPlatformConstraints _value,
      $Res Function(_$_IOSPlatformConstraints) _then)
      : super(_value, (v) => _then(v as _$_IOSPlatformConstraints));

  @override
  _$_IOSPlatformConstraints get _value =>
      super._value as _$_IOSPlatformConstraints;

  @override
  $Res call({
    Object? minimumOsVersion = freezed,
  }) {
    return _then(_$_IOSPlatformConstraints(
      minimumOsVersion: minimumOsVersion == freezed
          ? _value.minimumOsVersion
          : minimumOsVersion // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc

class _$_IOSPlatformConstraints implements _IOSPlatformConstraints {
  const _$_IOSPlatformConstraints({required this.minimumOsVersion});

  @override
  final num? minimumOsVersion;

  @override
  String toString() {
    return 'IOSPlatformConstraints(minimumOsVersion: $minimumOsVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IOSPlatformConstraints &&
            const DeepCollectionEquality()
                .equals(other.minimumOsVersion, minimumOsVersion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(minimumOsVersion));

  @JsonKey(ignore: true)
  @override
  _$$_IOSPlatformConstraintsCopyWith<_$_IOSPlatformConstraints> get copyWith =>
      __$$_IOSPlatformConstraintsCopyWithImpl<_$_IOSPlatformConstraints>(
          this, _$identity);
}

abstract class _IOSPlatformConstraints implements IOSPlatformConstraints {
  const factory _IOSPlatformConstraints(
      {required final num? minimumOsVersion}) = _$_IOSPlatformConstraints;

  @override
  num? get minimumOsVersion;
  @override
  @JsonKey(ignore: true)
  _$$_IOSPlatformConstraintsCopyWith<_$_IOSPlatformConstraints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AndroidPlatformConstraints {
  int? get minSdkVersion => throw _privateConstructorUsedError;
  int? get compileSdkVersion => throw _privateConstructorUsedError;
  int? get targetSdkVersion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AndroidPlatformConstraintsCopyWith<AndroidPlatformConstraints>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AndroidPlatformConstraintsCopyWith<$Res> {
  factory $AndroidPlatformConstraintsCopyWith(AndroidPlatformConstraints value,
          $Res Function(AndroidPlatformConstraints) then) =
      _$AndroidPlatformConstraintsCopyWithImpl<$Res>;
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class _$AndroidPlatformConstraintsCopyWithImpl<$Res>
    implements $AndroidPlatformConstraintsCopyWith<$Res> {
  _$AndroidPlatformConstraintsCopyWithImpl(this._value, this._then);

  final AndroidPlatformConstraints _value;
  // ignore: unused_field
  final $Res Function(AndroidPlatformConstraints) _then;

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
abstract class _$$_AndroidPlatformConstraintsCopyWith<$Res>
    implements $AndroidPlatformConstraintsCopyWith<$Res> {
  factory _$$_AndroidPlatformConstraintsCopyWith(
          _$_AndroidPlatformConstraints value,
          $Res Function(_$_AndroidPlatformConstraints) then) =
      __$$_AndroidPlatformConstraintsCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class __$$_AndroidPlatformConstraintsCopyWithImpl<$Res>
    extends _$AndroidPlatformConstraintsCopyWithImpl<$Res>
    implements _$$_AndroidPlatformConstraintsCopyWith<$Res> {
  __$$_AndroidPlatformConstraintsCopyWithImpl(
      _$_AndroidPlatformConstraints _value,
      $Res Function(_$_AndroidPlatformConstraints) _then)
      : super(_value, (v) => _then(v as _$_AndroidPlatformConstraints));

  @override
  _$_AndroidPlatformConstraints get _value =>
      super._value as _$_AndroidPlatformConstraints;

  @override
  $Res call({
    Object? minSdkVersion = freezed,
    Object? compileSdkVersion = freezed,
    Object? targetSdkVersion = freezed,
  }) {
    return _then(_$_AndroidPlatformConstraints(
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

class _$_AndroidPlatformConstraints implements _AndroidPlatformConstraints {
  const _$_AndroidPlatformConstraints(
      {required this.minSdkVersion,
      required this.compileSdkVersion,
      required this.targetSdkVersion});

  @override
  final int? minSdkVersion;
  @override
  final int? compileSdkVersion;
  @override
  final int? targetSdkVersion;

  @override
  String toString() {
    return 'AndroidPlatformConstraints(minSdkVersion: $minSdkVersion, compileSdkVersion: $compileSdkVersion, targetSdkVersion: $targetSdkVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AndroidPlatformConstraints &&
            const DeepCollectionEquality()
                .equals(other.minSdkVersion, minSdkVersion) &&
            const DeepCollectionEquality()
                .equals(other.compileSdkVersion, compileSdkVersion) &&
            const DeepCollectionEquality()
                .equals(other.targetSdkVersion, targetSdkVersion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(minSdkVersion),
      const DeepCollectionEquality().hash(compileSdkVersion),
      const DeepCollectionEquality().hash(targetSdkVersion));

  @JsonKey(ignore: true)
  @override
  _$$_AndroidPlatformConstraintsCopyWith<_$_AndroidPlatformConstraints>
      get copyWith => __$$_AndroidPlatformConstraintsCopyWithImpl<
          _$_AndroidPlatformConstraints>(this, _$identity);
}

abstract class _AndroidPlatformConstraints
    implements AndroidPlatformConstraints {
  const factory _AndroidPlatformConstraints(
      {required final int? minSdkVersion,
      required final int? compileSdkVersion,
      required final int? targetSdkVersion}) = _$_AndroidPlatformConstraints;

  @override
  int? get minSdkVersion;
  @override
  int? get compileSdkVersion;
  @override
  int? get targetSdkVersion;
  @override
  @JsonKey(ignore: true)
  _$$_AndroidPlatformConstraintsCopyWith<_$_AndroidPlatformConstraints>
      get copyWith => throw _privateConstructorUsedError;
}
