// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_dependency_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PackageDependencyStorageV3 {
  String get packageName;
  String? get packageVersion;

  /// Create a copy of PackageDependencyStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PackageDependencyStorageV3CopyWith<PackageDependencyStorageV3>
      get copyWith =>
          _$PackageDependencyStorageV3CopyWithImpl<PackageDependencyStorageV3>(
              this as PackageDependencyStorageV3, _$identity);

  /// Serializes this PackageDependencyStorageV3 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PackageDependencyStorageV3 &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageVersion, packageVersion) ||
                other.packageVersion == packageVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, packageName, packageVersion);

  @override
  String toString() {
    return 'PackageDependencyStorageV3(packageName: $packageName, packageVersion: $packageVersion)';
  }
}

/// @nodoc
abstract mixin class $PackageDependencyStorageV3CopyWith<$Res> {
  factory $PackageDependencyStorageV3CopyWith(PackageDependencyStorageV3 value,
          $Res Function(PackageDependencyStorageV3) _then) =
      _$PackageDependencyStorageV3CopyWithImpl;
  @useResult
  $Res call({String packageName, String? packageVersion});
}

/// @nodoc
class _$PackageDependencyStorageV3CopyWithImpl<$Res>
    implements $PackageDependencyStorageV3CopyWith<$Res> {
  _$PackageDependencyStorageV3CopyWithImpl(this._self, this._then);

  final PackageDependencyStorageV3 _self;
  final $Res Function(PackageDependencyStorageV3) _then;

  /// Create a copy of PackageDependencyStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
  }) {
    return _then(_self.copyWith(
      packageName: null == packageName
          ? _self.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageVersion: freezed == packageVersion
          ? _self.packageVersion
          : packageVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PackageDependencyStorageV3 extends PackageDependencyStorageV3 {
  const _PackageDependencyStorageV3(
      {required this.packageName, required this.packageVersion})
      : super._();
  factory _PackageDependencyStorageV3.fromJson(Map<String, dynamic> json) =>
      _$PackageDependencyStorageV3FromJson(json);

  @override
  final String packageName;
  @override
  final String? packageVersion;

  /// Create a copy of PackageDependencyStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PackageDependencyStorageV3CopyWith<_PackageDependencyStorageV3>
      get copyWith => __$PackageDependencyStorageV3CopyWithImpl<
          _PackageDependencyStorageV3>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PackageDependencyStorageV3ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PackageDependencyStorageV3 &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageVersion, packageVersion) ||
                other.packageVersion == packageVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, packageName, packageVersion);

  @override
  String toString() {
    return 'PackageDependencyStorageV3(packageName: $packageName, packageVersion: $packageVersion)';
  }
}

/// @nodoc
abstract mixin class _$PackageDependencyStorageV3CopyWith<$Res>
    implements $PackageDependencyStorageV3CopyWith<$Res> {
  factory _$PackageDependencyStorageV3CopyWith(
          _PackageDependencyStorageV3 value,
          $Res Function(_PackageDependencyStorageV3) _then) =
      __$PackageDependencyStorageV3CopyWithImpl;
  @override
  @useResult
  $Res call({String packageName, String? packageVersion});
}

/// @nodoc
class __$PackageDependencyStorageV3CopyWithImpl<$Res>
    implements _$PackageDependencyStorageV3CopyWith<$Res> {
  __$PackageDependencyStorageV3CopyWithImpl(this._self, this._then);

  final _PackageDependencyStorageV3 _self;
  final $Res Function(_PackageDependencyStorageV3) _then;

  /// Create a copy of PackageDependencyStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
  }) {
    return _then(_PackageDependencyStorageV3(
      packageName: null == packageName
          ? _self.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageVersion: freezed == packageVersion
          ? _self.packageVersion
          : packageVersion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
