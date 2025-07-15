// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

/// Adds pattern-matching-related methods to [PackageDependencyStorageV3].
extension PackageDependencyStorageV3Patterns on PackageDependencyStorageV3 {
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
    TResult Function(_PackageDependencyStorageV3 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PackageDependencyStorageV3() when $default != null:
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
    TResult Function(_PackageDependencyStorageV3 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackageDependencyStorageV3():
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
    TResult? Function(_PackageDependencyStorageV3 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackageDependencyStorageV3() when $default != null:
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
      case _PackageDependencyStorageV3() when $default != null:
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
      case _PackageDependencyStorageV3():
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
      case _PackageDependencyStorageV3() when $default != null:
        return $default(_that.packageName, _that.packageVersion);
      case _:
        return null;
    }
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
