// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_dependency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PackageDependency {
  /// name of the package
  String get packageName;

  /// String representation of the version range. Can be null if the dependency is a path or git dependency
  String? get packageVersion;

  /// Create a copy of PackageDependency
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PackageDependencyCopyWith<PackageDependency> get copyWith =>
      _$PackageDependencyCopyWithImpl<PackageDependency>(
          this as PackageDependency, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PackageDependency &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageVersion, packageVersion) ||
                other.packageVersion == packageVersion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, packageName, packageVersion);

  @override
  String toString() {
    return 'PackageDependency(packageName: $packageName, packageVersion: $packageVersion)';
  }
}

/// @nodoc
abstract mixin class $PackageDependencyCopyWith<$Res> {
  factory $PackageDependencyCopyWith(
          PackageDependency value, $Res Function(PackageDependency) _then) =
      _$PackageDependencyCopyWithImpl;
  @useResult
  $Res call({String packageName, String? packageVersion});
}

/// @nodoc
class _$PackageDependencyCopyWithImpl<$Res>
    implements $PackageDependencyCopyWith<$Res> {
  _$PackageDependencyCopyWithImpl(this._self, this._then);

  final PackageDependency _self;
  final $Res Function(PackageDependency) _then;

  /// Create a copy of PackageDependency
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

/// Adds pattern-matching-related methods to [PackageDependency].
extension PackageDependencyPatterns on PackageDependency {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_PackageDependency value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PackageDependency() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_PackageDependency value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackageDependency():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_PackageDependency value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackageDependency() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String packageName, String? packageVersion)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PackageDependency() when $default != null:
        return $default(_that.packageName, _that.packageVersion);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String packageName, String? packageVersion) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackageDependency():
        return $default(_that.packageName, _that.packageVersion);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String packageName, String? packageVersion)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackageDependency() when $default != null:
        return $default(_that.packageName, _that.packageVersion);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PackageDependency implements PackageDependency {
  _PackageDependency({required this.packageName, required this.packageVersion});

  /// name of the package
  @override
  final String packageName;

  /// String representation of the version range. Can be null if the dependency is a path or git dependency
  @override
  final String? packageVersion;

  /// Create a copy of PackageDependency
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PackageDependencyCopyWith<_PackageDependency> get copyWith =>
      __$PackageDependencyCopyWithImpl<_PackageDependency>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PackageDependency &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageVersion, packageVersion) ||
                other.packageVersion == packageVersion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, packageName, packageVersion);

  @override
  String toString() {
    return 'PackageDependency(packageName: $packageName, packageVersion: $packageVersion)';
  }
}

/// @nodoc
abstract mixin class _$PackageDependencyCopyWith<$Res>
    implements $PackageDependencyCopyWith<$Res> {
  factory _$PackageDependencyCopyWith(
          _PackageDependency value, $Res Function(_PackageDependency) _then) =
      __$PackageDependencyCopyWithImpl;
  @override
  @useResult
  $Res call({String packageName, String? packageVersion});
}

/// @nodoc
class __$PackageDependencyCopyWithImpl<$Res>
    implements _$PackageDependencyCopyWith<$Res> {
  __$PackageDependencyCopyWithImpl(this._self, this._then);

  final _PackageDependency _self;
  final $Res Function(_PackageDependency) _then;

  /// Create a copy of PackageDependency
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
  }) {
    return _then(_PackageDependency(
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
