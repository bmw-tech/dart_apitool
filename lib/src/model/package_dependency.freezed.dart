// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_dependency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PackageDependency {
  /// name of the package
  String get packageName => throw _privateConstructorUsedError;

  /// String representation of the version range. Can be null if the dependency is a path or git dependency
  String? get packageVersion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PackageDependencyCopyWith<PackageDependency> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageDependencyCopyWith<$Res> {
  factory $PackageDependencyCopyWith(
          PackageDependency value, $Res Function(PackageDependency) then) =
      _$PackageDependencyCopyWithImpl<$Res, PackageDependency>;
  @useResult
  $Res call({String packageName, String? packageVersion});
}

/// @nodoc
class _$PackageDependencyCopyWithImpl<$Res, $Val extends PackageDependency>
    implements $PackageDependencyCopyWith<$Res> {
  _$PackageDependencyCopyWithImpl(this._value, this._then);

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
abstract class _$$_PackageDependencyCopyWith<$Res>
    implements $PackageDependencyCopyWith<$Res> {
  factory _$$_PackageDependencyCopyWith(_$_PackageDependency value,
          $Res Function(_$_PackageDependency) then) =
      __$$_PackageDependencyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String packageName, String? packageVersion});
}

/// @nodoc
class __$$_PackageDependencyCopyWithImpl<$Res>
    extends _$PackageDependencyCopyWithImpl<$Res, _$_PackageDependency>
    implements _$$_PackageDependencyCopyWith<$Res> {
  __$$_PackageDependencyCopyWithImpl(
      _$_PackageDependency _value, $Res Function(_$_PackageDependency) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
  }) {
    return _then(_$_PackageDependency(
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

class _$_PackageDependency implements _PackageDependency {
  _$_PackageDependency(
      {required this.packageName, required this.packageVersion});

  /// name of the package
  @override
  final String packageName;

  /// String representation of the version range. Can be null if the dependency is a path or git dependency
  @override
  final String? packageVersion;

  @override
  String toString() {
    return 'PackageDependency(packageName: $packageName, packageVersion: $packageVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackageDependency &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageVersion, packageVersion) ||
                other.packageVersion == packageVersion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, packageName, packageVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackageDependencyCopyWith<_$_PackageDependency> get copyWith =>
      __$$_PackageDependencyCopyWithImpl<_$_PackageDependency>(
          this, _$identity);
}

abstract class _PackageDependency implements PackageDependency {
  factory _PackageDependency(
      {required final String packageName,
      required final String? packageVersion}) = _$_PackageDependency;

  @override

  /// name of the package
  String get packageName;
  @override

  /// String representation of the version range. Can be null if the dependency is a path or git dependency
  String? get packageVersion;
  @override
  @JsonKey(ignore: true)
  _$$_PackageDependencyCopyWith<_$_PackageDependency> get copyWith =>
      throw _privateConstructorUsedError;
}
