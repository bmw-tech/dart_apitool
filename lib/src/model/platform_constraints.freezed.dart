// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'platform_constraints.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$IOSPlatformConstraints {
  /// minimum iOS version
  num? get minimumOsVersion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IOSPlatformConstraintsCopyWith<IOSPlatformConstraints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IOSPlatformConstraintsCopyWith<$Res> {
  factory $IOSPlatformConstraintsCopyWith(IOSPlatformConstraints value,
          $Res Function(IOSPlatformConstraints) then) =
      _$IOSPlatformConstraintsCopyWithImpl<$Res, IOSPlatformConstraints>;
  @useResult
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class _$IOSPlatformConstraintsCopyWithImpl<$Res,
        $Val extends IOSPlatformConstraints>
    implements $IOSPlatformConstraintsCopyWith<$Res> {
  _$IOSPlatformConstraintsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minimumOsVersion = freezed,
  }) {
    return _then(_value.copyWith(
      minimumOsVersion: freezed == minimumOsVersion
          ? _value.minimumOsVersion
          : minimumOsVersion // ignore: cast_nullable_to_non_nullable
              as num?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IOSPlatformConstraintsImplCopyWith<$Res>
    implements $IOSPlatformConstraintsCopyWith<$Res> {
  factory _$$IOSPlatformConstraintsImplCopyWith(
          _$IOSPlatformConstraintsImpl value,
          $Res Function(_$IOSPlatformConstraintsImpl) then) =
      __$$IOSPlatformConstraintsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class __$$IOSPlatformConstraintsImplCopyWithImpl<$Res>
    extends _$IOSPlatformConstraintsCopyWithImpl<$Res,
        _$IOSPlatformConstraintsImpl>
    implements _$$IOSPlatformConstraintsImplCopyWith<$Res> {
  __$$IOSPlatformConstraintsImplCopyWithImpl(
      _$IOSPlatformConstraintsImpl _value,
      $Res Function(_$IOSPlatformConstraintsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minimumOsVersion = freezed,
  }) {
    return _then(_$IOSPlatformConstraintsImpl(
      minimumOsVersion: freezed == minimumOsVersion
          ? _value.minimumOsVersion
          : minimumOsVersion // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc

class _$IOSPlatformConstraintsImpl implements _IOSPlatformConstraints {
  const _$IOSPlatformConstraintsImpl({required this.minimumOsVersion});

  /// minimum iOS version
  @override
  final num? minimumOsVersion;

  @override
  String toString() {
    return 'IOSPlatformConstraints(minimumOsVersion: $minimumOsVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IOSPlatformConstraintsImpl &&
            (identical(other.minimumOsVersion, minimumOsVersion) ||
                other.minimumOsVersion == minimumOsVersion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, minimumOsVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IOSPlatformConstraintsImplCopyWith<_$IOSPlatformConstraintsImpl>
      get copyWith => __$$IOSPlatformConstraintsImplCopyWithImpl<
          _$IOSPlatformConstraintsImpl>(this, _$identity);
}

abstract class _IOSPlatformConstraints implements IOSPlatformConstraints {
  const factory _IOSPlatformConstraints(
      {required final num? minimumOsVersion}) = _$IOSPlatformConstraintsImpl;

  @override

  /// minimum iOS version
  num? get minimumOsVersion;
  @override
  @JsonKey(ignore: true)
  _$$IOSPlatformConstraintsImplCopyWith<_$IOSPlatformConstraintsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AndroidPlatformConstraints {
  /// minimum SDK version
  int? get minSdkVersion => throw _privateConstructorUsedError;

  /// compile SDK version
  int? get compileSdkVersion => throw _privateConstructorUsedError;

  /// target SDK version
  int? get targetSdkVersion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AndroidPlatformConstraintsCopyWith<AndroidPlatformConstraints>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AndroidPlatformConstraintsCopyWith<$Res> {
  factory $AndroidPlatformConstraintsCopyWith(AndroidPlatformConstraints value,
          $Res Function(AndroidPlatformConstraints) then) =
      _$AndroidPlatformConstraintsCopyWithImpl<$Res,
          AndroidPlatformConstraints>;
  @useResult
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class _$AndroidPlatformConstraintsCopyWithImpl<$Res,
        $Val extends AndroidPlatformConstraints>
    implements $AndroidPlatformConstraintsCopyWith<$Res> {
  _$AndroidPlatformConstraintsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minSdkVersion = freezed,
    Object? compileSdkVersion = freezed,
    Object? targetSdkVersion = freezed,
  }) {
    return _then(_value.copyWith(
      minSdkVersion: freezed == minSdkVersion
          ? _value.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      compileSdkVersion: freezed == compileSdkVersion
          ? _value.compileSdkVersion
          : compileSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      targetSdkVersion: freezed == targetSdkVersion
          ? _value.targetSdkVersion
          : targetSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AndroidPlatformConstraintsImplCopyWith<$Res>
    implements $AndroidPlatformConstraintsCopyWith<$Res> {
  factory _$$AndroidPlatformConstraintsImplCopyWith(
          _$AndroidPlatformConstraintsImpl value,
          $Res Function(_$AndroidPlatformConstraintsImpl) then) =
      __$$AndroidPlatformConstraintsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class __$$AndroidPlatformConstraintsImplCopyWithImpl<$Res>
    extends _$AndroidPlatformConstraintsCopyWithImpl<$Res,
        _$AndroidPlatformConstraintsImpl>
    implements _$$AndroidPlatformConstraintsImplCopyWith<$Res> {
  __$$AndroidPlatformConstraintsImplCopyWithImpl(
      _$AndroidPlatformConstraintsImpl _value,
      $Res Function(_$AndroidPlatformConstraintsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minSdkVersion = freezed,
    Object? compileSdkVersion = freezed,
    Object? targetSdkVersion = freezed,
  }) {
    return _then(_$AndroidPlatformConstraintsImpl(
      minSdkVersion: freezed == minSdkVersion
          ? _value.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      compileSdkVersion: freezed == compileSdkVersion
          ? _value.compileSdkVersion
          : compileSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      targetSdkVersion: freezed == targetSdkVersion
          ? _value.targetSdkVersion
          : targetSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$AndroidPlatformConstraintsImpl implements _AndroidPlatformConstraints {
  const _$AndroidPlatformConstraintsImpl(
      {required this.minSdkVersion,
      required this.compileSdkVersion,
      required this.targetSdkVersion});

  /// minimum SDK version
  @override
  final int? minSdkVersion;

  /// compile SDK version
  @override
  final int? compileSdkVersion;

  /// target SDK version
  @override
  final int? targetSdkVersion;

  @override
  String toString() {
    return 'AndroidPlatformConstraints(minSdkVersion: $minSdkVersion, compileSdkVersion: $compileSdkVersion, targetSdkVersion: $targetSdkVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AndroidPlatformConstraintsImpl &&
            (identical(other.minSdkVersion, minSdkVersion) ||
                other.minSdkVersion == minSdkVersion) &&
            (identical(other.compileSdkVersion, compileSdkVersion) ||
                other.compileSdkVersion == compileSdkVersion) &&
            (identical(other.targetSdkVersion, targetSdkVersion) ||
                other.targetSdkVersion == targetSdkVersion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, minSdkVersion, compileSdkVersion, targetSdkVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AndroidPlatformConstraintsImplCopyWith<_$AndroidPlatformConstraintsImpl>
      get copyWith => __$$AndroidPlatformConstraintsImplCopyWithImpl<
          _$AndroidPlatformConstraintsImpl>(this, _$identity);
}

abstract class _AndroidPlatformConstraints
    implements AndroidPlatformConstraints {
  const factory _AndroidPlatformConstraints(
      {required final int? minSdkVersion,
      required final int? compileSdkVersion,
      required final int? targetSdkVersion}) = _$AndroidPlatformConstraintsImpl;

  @override

  /// minimum SDK version
  int? get minSdkVersion;
  @override

  /// compile SDK version
  int? get compileSdkVersion;
  @override

  /// target SDK version
  int? get targetSdkVersion;
  @override
  @JsonKey(ignore: true)
  _$$AndroidPlatformConstraintsImplCopyWith<_$AndroidPlatformConstraintsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
