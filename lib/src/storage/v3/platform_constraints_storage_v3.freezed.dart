// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'platform_constraints_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IOSPlatformConstraintsStorageV3 _$IOSPlatformConstraintsStorageV3FromJson(
    Map<String, dynamic> json) {
  return _IOSPlatformConstraintsStorageV3.fromJson(json);
}

/// @nodoc
mixin _$IOSPlatformConstraintsStorageV3 {
  num? get minimumOsVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IOSPlatformConstraintsStorageV3CopyWith<IOSPlatformConstraintsStorageV3>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IOSPlatformConstraintsStorageV3CopyWith<$Res> {
  factory $IOSPlatformConstraintsStorageV3CopyWith(
          IOSPlatformConstraintsStorageV3 value,
          $Res Function(IOSPlatformConstraintsStorageV3) then) =
      _$IOSPlatformConstraintsStorageV3CopyWithImpl<$Res,
          IOSPlatformConstraintsStorageV3>;
  @useResult
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class _$IOSPlatformConstraintsStorageV3CopyWithImpl<$Res,
        $Val extends IOSPlatformConstraintsStorageV3>
    implements $IOSPlatformConstraintsStorageV3CopyWith<$Res> {
  _$IOSPlatformConstraintsStorageV3CopyWithImpl(this._value, this._then);

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
abstract class _$$IOSPlatformConstraintsStorageV3ImplCopyWith<$Res>
    implements $IOSPlatformConstraintsStorageV3CopyWith<$Res> {
  factory _$$IOSPlatformConstraintsStorageV3ImplCopyWith(
          _$IOSPlatformConstraintsStorageV3Impl value,
          $Res Function(_$IOSPlatformConstraintsStorageV3Impl) then) =
      __$$IOSPlatformConstraintsStorageV3ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class __$$IOSPlatformConstraintsStorageV3ImplCopyWithImpl<$Res>
    extends _$IOSPlatformConstraintsStorageV3CopyWithImpl<$Res,
        _$IOSPlatformConstraintsStorageV3Impl>
    implements _$$IOSPlatformConstraintsStorageV3ImplCopyWith<$Res> {
  __$$IOSPlatformConstraintsStorageV3ImplCopyWithImpl(
      _$IOSPlatformConstraintsStorageV3Impl _value,
      $Res Function(_$IOSPlatformConstraintsStorageV3Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minimumOsVersion = freezed,
  }) {
    return _then(_$IOSPlatformConstraintsStorageV3Impl(
      minimumOsVersion: freezed == minimumOsVersion
          ? _value.minimumOsVersion
          : minimumOsVersion // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IOSPlatformConstraintsStorageV3Impl
    extends _IOSPlatformConstraintsStorageV3 {
  const _$IOSPlatformConstraintsStorageV3Impl({required this.minimumOsVersion})
      : super._();

  factory _$IOSPlatformConstraintsStorageV3Impl.fromJson(
          Map<String, dynamic> json) =>
      _$$IOSPlatformConstraintsStorageV3ImplFromJson(json);

  @override
  final num? minimumOsVersion;

  @override
  String toString() {
    return 'IOSPlatformConstraintsStorageV3(minimumOsVersion: $minimumOsVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IOSPlatformConstraintsStorageV3Impl &&
            (identical(other.minimumOsVersion, minimumOsVersion) ||
                other.minimumOsVersion == minimumOsVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, minimumOsVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IOSPlatformConstraintsStorageV3ImplCopyWith<
          _$IOSPlatformConstraintsStorageV3Impl>
      get copyWith => __$$IOSPlatformConstraintsStorageV3ImplCopyWithImpl<
          _$IOSPlatformConstraintsStorageV3Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IOSPlatformConstraintsStorageV3ImplToJson(
      this,
    );
  }
}

abstract class _IOSPlatformConstraintsStorageV3
    extends IOSPlatformConstraintsStorageV3 {
  const factory _IOSPlatformConstraintsStorageV3(
          {required final num? minimumOsVersion}) =
      _$IOSPlatformConstraintsStorageV3Impl;
  const _IOSPlatformConstraintsStorageV3._() : super._();

  factory _IOSPlatformConstraintsStorageV3.fromJson(Map<String, dynamic> json) =
      _$IOSPlatformConstraintsStorageV3Impl.fromJson;

  @override
  num? get minimumOsVersion;
  @override
  @JsonKey(ignore: true)
  _$$IOSPlatformConstraintsStorageV3ImplCopyWith<
          _$IOSPlatformConstraintsStorageV3Impl>
      get copyWith => throw _privateConstructorUsedError;
}

AndroidPlatformConstraintsStorageV3
    _$AndroidPlatformConstraintsStorageV3FromJson(Map<String, dynamic> json) {
  return _AndroidPlatformConstraintsStorageV3.fromJson(json);
}

/// @nodoc
mixin _$AndroidPlatformConstraintsStorageV3 {
  int? get minSdkVersion => throw _privateConstructorUsedError;
  int? get compileSdkVersion => throw _privateConstructorUsedError;
  int? get targetSdkVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AndroidPlatformConstraintsStorageV3CopyWith<
          AndroidPlatformConstraintsStorageV3>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AndroidPlatformConstraintsStorageV3CopyWith<$Res> {
  factory $AndroidPlatformConstraintsStorageV3CopyWith(
          AndroidPlatformConstraintsStorageV3 value,
          $Res Function(AndroidPlatformConstraintsStorageV3) then) =
      _$AndroidPlatformConstraintsStorageV3CopyWithImpl<$Res,
          AndroidPlatformConstraintsStorageV3>;
  @useResult
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class _$AndroidPlatformConstraintsStorageV3CopyWithImpl<$Res,
        $Val extends AndroidPlatformConstraintsStorageV3>
    implements $AndroidPlatformConstraintsStorageV3CopyWith<$Res> {
  _$AndroidPlatformConstraintsStorageV3CopyWithImpl(this._value, this._then);

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
abstract class _$$AndroidPlatformConstraintsStorageV3ImplCopyWith<$Res>
    implements $AndroidPlatformConstraintsStorageV3CopyWith<$Res> {
  factory _$$AndroidPlatformConstraintsStorageV3ImplCopyWith(
          _$AndroidPlatformConstraintsStorageV3Impl value,
          $Res Function(_$AndroidPlatformConstraintsStorageV3Impl) then) =
      __$$AndroidPlatformConstraintsStorageV3ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class __$$AndroidPlatformConstraintsStorageV3ImplCopyWithImpl<$Res>
    extends _$AndroidPlatformConstraintsStorageV3CopyWithImpl<$Res,
        _$AndroidPlatformConstraintsStorageV3Impl>
    implements _$$AndroidPlatformConstraintsStorageV3ImplCopyWith<$Res> {
  __$$AndroidPlatformConstraintsStorageV3ImplCopyWithImpl(
      _$AndroidPlatformConstraintsStorageV3Impl _value,
      $Res Function(_$AndroidPlatformConstraintsStorageV3Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minSdkVersion = freezed,
    Object? compileSdkVersion = freezed,
    Object? targetSdkVersion = freezed,
  }) {
    return _then(_$AndroidPlatformConstraintsStorageV3Impl(
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
@JsonSerializable()
class _$AndroidPlatformConstraintsStorageV3Impl
    extends _AndroidPlatformConstraintsStorageV3 {
  const _$AndroidPlatformConstraintsStorageV3Impl(
      {required this.minSdkVersion,
      required this.compileSdkVersion,
      required this.targetSdkVersion})
      : super._();

  factory _$AndroidPlatformConstraintsStorageV3Impl.fromJson(
          Map<String, dynamic> json) =>
      _$$AndroidPlatformConstraintsStorageV3ImplFromJson(json);

  @override
  final int? minSdkVersion;
  @override
  final int? compileSdkVersion;
  @override
  final int? targetSdkVersion;

  @override
  String toString() {
    return 'AndroidPlatformConstraintsStorageV3(minSdkVersion: $minSdkVersion, compileSdkVersion: $compileSdkVersion, targetSdkVersion: $targetSdkVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AndroidPlatformConstraintsStorageV3Impl &&
            (identical(other.minSdkVersion, minSdkVersion) ||
                other.minSdkVersion == minSdkVersion) &&
            (identical(other.compileSdkVersion, compileSdkVersion) ||
                other.compileSdkVersion == compileSdkVersion) &&
            (identical(other.targetSdkVersion, targetSdkVersion) ||
                other.targetSdkVersion == targetSdkVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, minSdkVersion, compileSdkVersion, targetSdkVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AndroidPlatformConstraintsStorageV3ImplCopyWith<
          _$AndroidPlatformConstraintsStorageV3Impl>
      get copyWith => __$$AndroidPlatformConstraintsStorageV3ImplCopyWithImpl<
          _$AndroidPlatformConstraintsStorageV3Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AndroidPlatformConstraintsStorageV3ImplToJson(
      this,
    );
  }
}

abstract class _AndroidPlatformConstraintsStorageV3
    extends AndroidPlatformConstraintsStorageV3 {
  const factory _AndroidPlatformConstraintsStorageV3(
          {required final int? minSdkVersion,
          required final int? compileSdkVersion,
          required final int? targetSdkVersion}) =
      _$AndroidPlatformConstraintsStorageV3Impl;
  const _AndroidPlatformConstraintsStorageV3._() : super._();

  factory _AndroidPlatformConstraintsStorageV3.fromJson(
          Map<String, dynamic> json) =
      _$AndroidPlatformConstraintsStorageV3Impl.fromJson;

  @override
  int? get minSdkVersion;
  @override
  int? get compileSdkVersion;
  @override
  int? get targetSdkVersion;
  @override
  @JsonKey(ignore: true)
  _$$AndroidPlatformConstraintsStorageV3ImplCopyWith<
          _$AndroidPlatformConstraintsStorageV3Impl>
      get copyWith => throw _privateConstructorUsedError;
}
