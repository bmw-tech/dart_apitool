// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'platform_constraints.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IOSPlatformConstraints {
  /// minimum iOS version
  num? get minimumOsVersion;

  /// Create a copy of IOSPlatformConstraints
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IOSPlatformConstraintsCopyWith<IOSPlatformConstraints> get copyWith =>
      _$IOSPlatformConstraintsCopyWithImpl<IOSPlatformConstraints>(
          this as IOSPlatformConstraints, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IOSPlatformConstraints &&
            (identical(other.minimumOsVersion, minimumOsVersion) ||
                other.minimumOsVersion == minimumOsVersion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, minimumOsVersion);

  @override
  String toString() {
    return 'IOSPlatformConstraints(minimumOsVersion: $minimumOsVersion)';
  }
}

/// @nodoc
abstract mixin class $IOSPlatformConstraintsCopyWith<$Res> {
  factory $IOSPlatformConstraintsCopyWith(IOSPlatformConstraints value,
          $Res Function(IOSPlatformConstraints) _then) =
      _$IOSPlatformConstraintsCopyWithImpl;
  @useResult
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class _$IOSPlatformConstraintsCopyWithImpl<$Res>
    implements $IOSPlatformConstraintsCopyWith<$Res> {
  _$IOSPlatformConstraintsCopyWithImpl(this._self, this._then);

  final IOSPlatformConstraints _self;
  final $Res Function(IOSPlatformConstraints) _then;

  /// Create a copy of IOSPlatformConstraints
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minimumOsVersion = freezed,
  }) {
    return _then(_self.copyWith(
      minimumOsVersion: freezed == minimumOsVersion
          ? _self.minimumOsVersion
          : minimumOsVersion // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// Adds pattern-matching-related methods to [IOSPlatformConstraints].
extension IOSPlatformConstraintsPatterns on IOSPlatformConstraints {
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
    TResult Function(_IOSPlatformConstraints value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IOSPlatformConstraints() when $default != null:
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
    TResult Function(_IOSPlatformConstraints value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IOSPlatformConstraints():
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
    TResult? Function(_IOSPlatformConstraints value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IOSPlatformConstraints() when $default != null:
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
    TResult Function(num? minimumOsVersion)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IOSPlatformConstraints() when $default != null:
        return $default(_that.minimumOsVersion);
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
    TResult Function(num? minimumOsVersion) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IOSPlatformConstraints():
        return $default(_that.minimumOsVersion);
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
    TResult? Function(num? minimumOsVersion)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IOSPlatformConstraints() when $default != null:
        return $default(_that.minimumOsVersion);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _IOSPlatformConstraints implements IOSPlatformConstraints {
  const _IOSPlatformConstraints({required this.minimumOsVersion});

  /// minimum iOS version
  @override
  final num? minimumOsVersion;

  /// Create a copy of IOSPlatformConstraints
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IOSPlatformConstraintsCopyWith<_IOSPlatformConstraints> get copyWith =>
      __$IOSPlatformConstraintsCopyWithImpl<_IOSPlatformConstraints>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IOSPlatformConstraints &&
            (identical(other.minimumOsVersion, minimumOsVersion) ||
                other.minimumOsVersion == minimumOsVersion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, minimumOsVersion);

  @override
  String toString() {
    return 'IOSPlatformConstraints(minimumOsVersion: $minimumOsVersion)';
  }
}

/// @nodoc
abstract mixin class _$IOSPlatformConstraintsCopyWith<$Res>
    implements $IOSPlatformConstraintsCopyWith<$Res> {
  factory _$IOSPlatformConstraintsCopyWith(_IOSPlatformConstraints value,
          $Res Function(_IOSPlatformConstraints) _then) =
      __$IOSPlatformConstraintsCopyWithImpl;
  @override
  @useResult
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class __$IOSPlatformConstraintsCopyWithImpl<$Res>
    implements _$IOSPlatformConstraintsCopyWith<$Res> {
  __$IOSPlatformConstraintsCopyWithImpl(this._self, this._then);

  final _IOSPlatformConstraints _self;
  final $Res Function(_IOSPlatformConstraints) _then;

  /// Create a copy of IOSPlatformConstraints
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? minimumOsVersion = freezed,
  }) {
    return _then(_IOSPlatformConstraints(
      minimumOsVersion: freezed == minimumOsVersion
          ? _self.minimumOsVersion
          : minimumOsVersion // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
mixin _$AndroidPlatformConstraints {
  /// minimum SDK version
  int? get minSdkVersion;

  /// compile SDK version
  int? get compileSdkVersion;

  /// target SDK version
  int? get targetSdkVersion;

  /// Create a copy of AndroidPlatformConstraints
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AndroidPlatformConstraintsCopyWith<AndroidPlatformConstraints>
      get copyWith =>
          _$AndroidPlatformConstraintsCopyWithImpl<AndroidPlatformConstraints>(
              this as AndroidPlatformConstraints, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AndroidPlatformConstraints &&
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

  @override
  String toString() {
    return 'AndroidPlatformConstraints(minSdkVersion: $minSdkVersion, compileSdkVersion: $compileSdkVersion, targetSdkVersion: $targetSdkVersion)';
  }
}

/// @nodoc
abstract mixin class $AndroidPlatformConstraintsCopyWith<$Res> {
  factory $AndroidPlatformConstraintsCopyWith(AndroidPlatformConstraints value,
          $Res Function(AndroidPlatformConstraints) _then) =
      _$AndroidPlatformConstraintsCopyWithImpl;
  @useResult
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class _$AndroidPlatformConstraintsCopyWithImpl<$Res>
    implements $AndroidPlatformConstraintsCopyWith<$Res> {
  _$AndroidPlatformConstraintsCopyWithImpl(this._self, this._then);

  final AndroidPlatformConstraints _self;
  final $Res Function(AndroidPlatformConstraints) _then;

  /// Create a copy of AndroidPlatformConstraints
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minSdkVersion = freezed,
    Object? compileSdkVersion = freezed,
    Object? targetSdkVersion = freezed,
  }) {
    return _then(_self.copyWith(
      minSdkVersion: freezed == minSdkVersion
          ? _self.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      compileSdkVersion: freezed == compileSdkVersion
          ? _self.compileSdkVersion
          : compileSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      targetSdkVersion: freezed == targetSdkVersion
          ? _self.targetSdkVersion
          : targetSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AndroidPlatformConstraints].
extension AndroidPlatformConstraintsPatterns on AndroidPlatformConstraints {
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
    TResult Function(_AndroidPlatformConstraints value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AndroidPlatformConstraints() when $default != null:
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
    TResult Function(_AndroidPlatformConstraints value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AndroidPlatformConstraints():
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
    TResult? Function(_AndroidPlatformConstraints value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AndroidPlatformConstraints() when $default != null:
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
    TResult Function(
            int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AndroidPlatformConstraints() when $default != null:
        return $default(_that.minSdkVersion, _that.compileSdkVersion,
            _that.targetSdkVersion);
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
    TResult Function(
            int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AndroidPlatformConstraints():
        return $default(_that.minSdkVersion, _that.compileSdkVersion,
            _that.targetSdkVersion);
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
    TResult? Function(
            int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AndroidPlatformConstraints() when $default != null:
        return $default(_that.minSdkVersion, _that.compileSdkVersion,
            _that.targetSdkVersion);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AndroidPlatformConstraints implements AndroidPlatformConstraints {
  const _AndroidPlatformConstraints(
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

  /// Create a copy of AndroidPlatformConstraints
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AndroidPlatformConstraintsCopyWith<_AndroidPlatformConstraints>
      get copyWith => __$AndroidPlatformConstraintsCopyWithImpl<
          _AndroidPlatformConstraints>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AndroidPlatformConstraints &&
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

  @override
  String toString() {
    return 'AndroidPlatformConstraints(minSdkVersion: $minSdkVersion, compileSdkVersion: $compileSdkVersion, targetSdkVersion: $targetSdkVersion)';
  }
}

/// @nodoc
abstract mixin class _$AndroidPlatformConstraintsCopyWith<$Res>
    implements $AndroidPlatformConstraintsCopyWith<$Res> {
  factory _$AndroidPlatformConstraintsCopyWith(
          _AndroidPlatformConstraints value,
          $Res Function(_AndroidPlatformConstraints) _then) =
      __$AndroidPlatformConstraintsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class __$AndroidPlatformConstraintsCopyWithImpl<$Res>
    implements _$AndroidPlatformConstraintsCopyWith<$Res> {
  __$AndroidPlatformConstraintsCopyWithImpl(this._self, this._then);

  final _AndroidPlatformConstraints _self;
  final $Res Function(_AndroidPlatformConstraints) _then;

  /// Create a copy of AndroidPlatformConstraints
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? minSdkVersion = freezed,
    Object? compileSdkVersion = freezed,
    Object? targetSdkVersion = freezed,
  }) {
    return _then(_AndroidPlatformConstraints(
      minSdkVersion: freezed == minSdkVersion
          ? _self.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      compileSdkVersion: freezed == compileSdkVersion
          ? _self.compileSdkVersion
          : compileSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
      targetSdkVersion: freezed == targetSdkVersion
          ? _self.targetSdkVersion
          : targetSdkVersion // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
