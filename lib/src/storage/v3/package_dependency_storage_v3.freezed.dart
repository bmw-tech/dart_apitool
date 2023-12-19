// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_dependency_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PackageDependencyStorageV3 _$PackageDependencyStorageV3FromJson(
    Map<String, dynamic> json) {
  return _PackageDependencyStorageV3.fromJson(json);
}

/// @nodoc
mixin _$PackageDependencyStorageV3 {
  String get packageName => throw _privateConstructorUsedError;
  String? get packageVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackageDependencyStorageV3CopyWith<PackageDependencyStorageV3>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageDependencyStorageV3CopyWith<$Res> {
  factory $PackageDependencyStorageV3CopyWith(PackageDependencyStorageV3 value,
          $Res Function(PackageDependencyStorageV3) then) =
      _$PackageDependencyStorageV3CopyWithImpl<$Res,
          PackageDependencyStorageV3>;
  @useResult
  $Res call({String packageName, String? packageVersion});
}

/// @nodoc
class _$PackageDependencyStorageV3CopyWithImpl<$Res,
        $Val extends PackageDependencyStorageV3>
    implements $PackageDependencyStorageV3CopyWith<$Res> {
  _$PackageDependencyStorageV3CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
  }) {
    return _then(_value.copyWith(
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageVersion: freezed == packageVersion
          ? _value.packageVersion
          : packageVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PackageDependencyStorageV3ImplCopyWith<$Res>
    implements $PackageDependencyStorageV3CopyWith<$Res> {
  factory _$$PackageDependencyStorageV3ImplCopyWith(
          _$PackageDependencyStorageV3Impl value,
          $Res Function(_$PackageDependencyStorageV3Impl) then) =
      __$$PackageDependencyStorageV3ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String packageName, String? packageVersion});
}

/// @nodoc
class __$$PackageDependencyStorageV3ImplCopyWithImpl<$Res>
    extends _$PackageDependencyStorageV3CopyWithImpl<$Res,
        _$PackageDependencyStorageV3Impl>
    implements _$$PackageDependencyStorageV3ImplCopyWith<$Res> {
  __$$PackageDependencyStorageV3ImplCopyWithImpl(
      _$PackageDependencyStorageV3Impl _value,
      $Res Function(_$PackageDependencyStorageV3Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
  }) {
    return _then(_$PackageDependencyStorageV3Impl(
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageVersion: freezed == packageVersion
          ? _value.packageVersion
          : packageVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PackageDependencyStorageV3Impl extends _PackageDependencyStorageV3 {
  const _$PackageDependencyStorageV3Impl(
      {required this.packageName, required this.packageVersion})
      : super._();

  factory _$PackageDependencyStorageV3Impl.fromJson(
          Map<String, dynamic> json) =>
      _$$PackageDependencyStorageV3ImplFromJson(json);

  @override
  final String packageName;
  @override
  final String? packageVersion;

  @override
  String toString() {
    return 'PackageDependencyStorageV3(packageName: $packageName, packageVersion: $packageVersion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackageDependencyStorageV3Impl &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageVersion, packageVersion) ||
                other.packageVersion == packageVersion));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, packageName, packageVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PackageDependencyStorageV3ImplCopyWith<_$PackageDependencyStorageV3Impl>
      get copyWith => __$$PackageDependencyStorageV3ImplCopyWithImpl<
          _$PackageDependencyStorageV3Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackageDependencyStorageV3ImplToJson(
      this,
    );
  }
}

abstract class _PackageDependencyStorageV3 extends PackageDependencyStorageV3 {
  const factory _PackageDependencyStorageV3(
          {required final String packageName,
          required final String? packageVersion}) =
      _$PackageDependencyStorageV3Impl;
  const _PackageDependencyStorageV3._() : super._();

  factory _PackageDependencyStorageV3.fromJson(Map<String, dynamic> json) =
      _$PackageDependencyStorageV3Impl.fromJson;

  @override
  String get packageName;
  @override
  String? get packageVersion;
  @override
  @JsonKey(ignore: true)
  _$$PackageDependencyStorageV3ImplCopyWith<_$PackageDependencyStorageV3Impl>
      get copyWith => throw _privateConstructorUsedError;
}
