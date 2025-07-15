// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'platform_constraints_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IOSPlatformConstraintsStorageV3 {
  num? get minimumOsVersion;

  /// Create a copy of IOSPlatformConstraintsStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IOSPlatformConstraintsStorageV3CopyWith<IOSPlatformConstraintsStorageV3>
      get copyWith => _$IOSPlatformConstraintsStorageV3CopyWithImpl<
              IOSPlatformConstraintsStorageV3>(
          this as IOSPlatformConstraintsStorageV3, _$identity);

  /// Serializes this IOSPlatformConstraintsStorageV3 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IOSPlatformConstraintsStorageV3 &&
            (identical(other.minimumOsVersion, minimumOsVersion) ||
                other.minimumOsVersion == minimumOsVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minimumOsVersion);

  @override
  String toString() {
    return 'IOSPlatformConstraintsStorageV3(minimumOsVersion: $minimumOsVersion)';
  }
}

/// @nodoc
abstract mixin class $IOSPlatformConstraintsStorageV3CopyWith<$Res> {
  factory $IOSPlatformConstraintsStorageV3CopyWith(
          IOSPlatformConstraintsStorageV3 value,
          $Res Function(IOSPlatformConstraintsStorageV3) _then) =
      _$IOSPlatformConstraintsStorageV3CopyWithImpl;
  @useResult
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class _$IOSPlatformConstraintsStorageV3CopyWithImpl<$Res>
    implements $IOSPlatformConstraintsStorageV3CopyWith<$Res> {
  _$IOSPlatformConstraintsStorageV3CopyWithImpl(this._self, this._then);

  final IOSPlatformConstraintsStorageV3 _self;
  final $Res Function(IOSPlatformConstraintsStorageV3) _then;

  /// Create a copy of IOSPlatformConstraintsStorageV3
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

/// Adds pattern-matching-related methods to [IOSPlatformConstraintsStorageV3].
extension IOSPlatformConstraintsStorageV3Patterns
    on IOSPlatformConstraintsStorageV3 {
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
    TResult Function(_IOSPlatformConstraintsStorageV3 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _IOSPlatformConstraintsStorageV3() when $default != null:
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
    TResult Function(_IOSPlatformConstraintsStorageV3 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IOSPlatformConstraintsStorageV3():
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
    TResult? Function(_IOSPlatformConstraintsStorageV3 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _IOSPlatformConstraintsStorageV3() when $default != null:
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
      case _IOSPlatformConstraintsStorageV3() when $default != null:
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
      case _IOSPlatformConstraintsStorageV3():
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
      case _IOSPlatformConstraintsStorageV3() when $default != null:
        return $default(_that.minimumOsVersion);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _IOSPlatformConstraintsStorageV3 extends IOSPlatformConstraintsStorageV3 {
  const _IOSPlatformConstraintsStorageV3({required this.minimumOsVersion})
      : super._();
  factory _IOSPlatformConstraintsStorageV3.fromJson(
          Map<String, dynamic> json) =>
      _$IOSPlatformConstraintsStorageV3FromJson(json);

  @override
  final num? minimumOsVersion;

  /// Create a copy of IOSPlatformConstraintsStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IOSPlatformConstraintsStorageV3CopyWith<_IOSPlatformConstraintsStorageV3>
      get copyWith => __$IOSPlatformConstraintsStorageV3CopyWithImpl<
          _IOSPlatformConstraintsStorageV3>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IOSPlatformConstraintsStorageV3ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IOSPlatformConstraintsStorageV3 &&
            (identical(other.minimumOsVersion, minimumOsVersion) ||
                other.minimumOsVersion == minimumOsVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, minimumOsVersion);

  @override
  String toString() {
    return 'IOSPlatformConstraintsStorageV3(minimumOsVersion: $minimumOsVersion)';
  }
}

/// @nodoc
abstract mixin class _$IOSPlatformConstraintsStorageV3CopyWith<$Res>
    implements $IOSPlatformConstraintsStorageV3CopyWith<$Res> {
  factory _$IOSPlatformConstraintsStorageV3CopyWith(
          _IOSPlatformConstraintsStorageV3 value,
          $Res Function(_IOSPlatformConstraintsStorageV3) _then) =
      __$IOSPlatformConstraintsStorageV3CopyWithImpl;
  @override
  @useResult
  $Res call({num? minimumOsVersion});
}

/// @nodoc
class __$IOSPlatformConstraintsStorageV3CopyWithImpl<$Res>
    implements _$IOSPlatformConstraintsStorageV3CopyWith<$Res> {
  __$IOSPlatformConstraintsStorageV3CopyWithImpl(this._self, this._then);

  final _IOSPlatformConstraintsStorageV3 _self;
  final $Res Function(_IOSPlatformConstraintsStorageV3) _then;

  /// Create a copy of IOSPlatformConstraintsStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? minimumOsVersion = freezed,
  }) {
    return _then(_IOSPlatformConstraintsStorageV3(
      minimumOsVersion: freezed == minimumOsVersion
          ? _self.minimumOsVersion
          : minimumOsVersion // ignore: cast_nullable_to_non_nullable
              as num?,
    ));
  }
}

/// @nodoc
mixin _$AndroidPlatformConstraintsStorageV3 {
  int? get minSdkVersion;
  int? get compileSdkVersion;
  int? get targetSdkVersion;

  /// Create a copy of AndroidPlatformConstraintsStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AndroidPlatformConstraintsStorageV3CopyWith<
          AndroidPlatformConstraintsStorageV3>
      get copyWith => _$AndroidPlatformConstraintsStorageV3CopyWithImpl<
              AndroidPlatformConstraintsStorageV3>(
          this as AndroidPlatformConstraintsStorageV3, _$identity);

  /// Serializes this AndroidPlatformConstraintsStorageV3 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AndroidPlatformConstraintsStorageV3 &&
            (identical(other.minSdkVersion, minSdkVersion) ||
                other.minSdkVersion == minSdkVersion) &&
            (identical(other.compileSdkVersion, compileSdkVersion) ||
                other.compileSdkVersion == compileSdkVersion) &&
            (identical(other.targetSdkVersion, targetSdkVersion) ||
                other.targetSdkVersion == targetSdkVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, minSdkVersion, compileSdkVersion, targetSdkVersion);

  @override
  String toString() {
    return 'AndroidPlatformConstraintsStorageV3(minSdkVersion: $minSdkVersion, compileSdkVersion: $compileSdkVersion, targetSdkVersion: $targetSdkVersion)';
  }
}

/// @nodoc
abstract mixin class $AndroidPlatformConstraintsStorageV3CopyWith<$Res> {
  factory $AndroidPlatformConstraintsStorageV3CopyWith(
          AndroidPlatformConstraintsStorageV3 value,
          $Res Function(AndroidPlatformConstraintsStorageV3) _then) =
      _$AndroidPlatformConstraintsStorageV3CopyWithImpl;
  @useResult
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class _$AndroidPlatformConstraintsStorageV3CopyWithImpl<$Res>
    implements $AndroidPlatformConstraintsStorageV3CopyWith<$Res> {
  _$AndroidPlatformConstraintsStorageV3CopyWithImpl(this._self, this._then);

  final AndroidPlatformConstraintsStorageV3 _self;
  final $Res Function(AndroidPlatformConstraintsStorageV3) _then;

  /// Create a copy of AndroidPlatformConstraintsStorageV3
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

/// Adds pattern-matching-related methods to [AndroidPlatformConstraintsStorageV3].
extension AndroidPlatformConstraintsStorageV3Patterns
    on AndroidPlatformConstraintsStorageV3 {
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
    TResult Function(_AndroidPlatformConstraintsStorageV3 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AndroidPlatformConstraintsStorageV3() when $default != null:
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
    TResult Function(_AndroidPlatformConstraintsStorageV3 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AndroidPlatformConstraintsStorageV3():
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
    TResult? Function(_AndroidPlatformConstraintsStorageV3 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AndroidPlatformConstraintsStorageV3() when $default != null:
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
      case _AndroidPlatformConstraintsStorageV3() when $default != null:
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
      case _AndroidPlatformConstraintsStorageV3():
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
      case _AndroidPlatformConstraintsStorageV3() when $default != null:
        return $default(_that.minSdkVersion, _that.compileSdkVersion,
            _that.targetSdkVersion);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AndroidPlatformConstraintsStorageV3
    extends AndroidPlatformConstraintsStorageV3 {
  const _AndroidPlatformConstraintsStorageV3(
      {required this.minSdkVersion,
      required this.compileSdkVersion,
      required this.targetSdkVersion})
      : super._();
  factory _AndroidPlatformConstraintsStorageV3.fromJson(
          Map<String, dynamic> json) =>
      _$AndroidPlatformConstraintsStorageV3FromJson(json);

  @override
  final int? minSdkVersion;
  @override
  final int? compileSdkVersion;
  @override
  final int? targetSdkVersion;

  /// Create a copy of AndroidPlatformConstraintsStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AndroidPlatformConstraintsStorageV3CopyWith<
          _AndroidPlatformConstraintsStorageV3>
      get copyWith => __$AndroidPlatformConstraintsStorageV3CopyWithImpl<
          _AndroidPlatformConstraintsStorageV3>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AndroidPlatformConstraintsStorageV3ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AndroidPlatformConstraintsStorageV3 &&
            (identical(other.minSdkVersion, minSdkVersion) ||
                other.minSdkVersion == minSdkVersion) &&
            (identical(other.compileSdkVersion, compileSdkVersion) ||
                other.compileSdkVersion == compileSdkVersion) &&
            (identical(other.targetSdkVersion, targetSdkVersion) ||
                other.targetSdkVersion == targetSdkVersion));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, minSdkVersion, compileSdkVersion, targetSdkVersion);

  @override
  String toString() {
    return 'AndroidPlatformConstraintsStorageV3(minSdkVersion: $minSdkVersion, compileSdkVersion: $compileSdkVersion, targetSdkVersion: $targetSdkVersion)';
  }
}

/// @nodoc
abstract mixin class _$AndroidPlatformConstraintsStorageV3CopyWith<$Res>
    implements $AndroidPlatformConstraintsStorageV3CopyWith<$Res> {
  factory _$AndroidPlatformConstraintsStorageV3CopyWith(
          _AndroidPlatformConstraintsStorageV3 value,
          $Res Function(_AndroidPlatformConstraintsStorageV3) _then) =
      __$AndroidPlatformConstraintsStorageV3CopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? minSdkVersion, int? compileSdkVersion, int? targetSdkVersion});
}

/// @nodoc
class __$AndroidPlatformConstraintsStorageV3CopyWithImpl<$Res>
    implements _$AndroidPlatformConstraintsStorageV3CopyWith<$Res> {
  __$AndroidPlatformConstraintsStorageV3CopyWithImpl(this._self, this._then);

  final _AndroidPlatformConstraintsStorageV3 _self;
  final $Res Function(_AndroidPlatformConstraintsStorageV3) _then;

  /// Create a copy of AndroidPlatformConstraintsStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? minSdkVersion = freezed,
    Object? compileSdkVersion = freezed,
    Object? targetSdkVersion = freezed,
  }) {
    return _then(_AndroidPlatformConstraintsStorageV3(
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
