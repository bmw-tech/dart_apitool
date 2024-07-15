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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PackageDependency {
  /// name of the package
  String get packageName => throw _privateConstructorUsedError;

  /// String representation of the version range. Can be null if the dependency is a path or git dependency
  String? get packageVersion => throw _privateConstructorUsedError;

  /// Create a copy of PackageDependency
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of PackageDependency
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$PackageDependencyImplCopyWith<$Res>
    implements $PackageDependencyCopyWith<$Res> {
  factory _$$PackageDependencyImplCopyWith(_$PackageDependencyImpl value,
          $Res Function(_$PackageDependencyImpl) then) =
      __$$PackageDependencyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String packageName, String? packageVersion});
}

/// @nodoc
class __$$PackageDependencyImplCopyWithImpl<$Res>
    extends _$PackageDependencyCopyWithImpl<$Res, _$PackageDependencyImpl>
    implements _$$PackageDependencyImplCopyWith<$Res> {
  __$$PackageDependencyImplCopyWithImpl(_$PackageDependencyImpl _value,
      $Res Function(_$PackageDependencyImpl) _then)
      : super(_value, _then);

  /// Create a copy of PackageDependency
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
  }) {
    return _then(_$PackageDependencyImpl(
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

class _$PackageDependencyImpl implements _PackageDependency {
  _$PackageDependencyImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackageDependencyImpl &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageVersion, packageVersion) ||
                other.packageVersion == packageVersion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, packageName, packageVersion);

  /// Create a copy of PackageDependency
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PackageDependencyImplCopyWith<_$PackageDependencyImpl> get copyWith =>
      __$$PackageDependencyImplCopyWithImpl<_$PackageDependencyImpl>(
          this, _$identity);
}

abstract class _PackageDependency implements PackageDependency {
  factory _PackageDependency(
      {required final String packageName,
      required final String? packageVersion}) = _$PackageDependencyImpl;

  /// name of the package
  @override
  String get packageName;

  /// String representation of the version range. Can be null if the dependency is a path or git dependency
  @override
  String? get packageVersion;

  /// Create a copy of PackageDependency
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PackageDependencyImplCopyWith<_$PackageDependencyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
