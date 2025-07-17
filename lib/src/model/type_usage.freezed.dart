// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_usage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TypeUsage {
  /// kind of usage
  TypeUsageKind get kind;

  /// the name of the referring element
  String get referringElementName;

  /// defines if the usage happened in a visibleForTesting context
  bool get isVisibleForTesting;

  /// Create a copy of TypeUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TypeUsageCopyWith<TypeUsage> get copyWith =>
      _$TypeUsageCopyWithImpl<TypeUsage>(this as TypeUsage, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TypeUsage &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.referringElementName, referringElementName) ||
                other.referringElementName == referringElementName) &&
            (identical(other.isVisibleForTesting, isVisibleForTesting) ||
                other.isVisibleForTesting == isVisibleForTesting));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, kind, referringElementName, isVisibleForTesting);

  @override
  String toString() {
    return 'TypeUsage(kind: $kind, referringElementName: $referringElementName, isVisibleForTesting: $isVisibleForTesting)';
  }
}

/// @nodoc
abstract mixin class $TypeUsageCopyWith<$Res> {
  factory $TypeUsageCopyWith(TypeUsage value, $Res Function(TypeUsage) _then) =
      _$TypeUsageCopyWithImpl;
  @useResult
  $Res call(
      {TypeUsageKind kind,
      String referringElementName,
      bool isVisibleForTesting});
}

/// @nodoc
class _$TypeUsageCopyWithImpl<$Res> implements $TypeUsageCopyWith<$Res> {
  _$TypeUsageCopyWithImpl(this._self, this._then);

  final TypeUsage _self;
  final $Res Function(TypeUsage) _then;

  /// Create a copy of TypeUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = null,
    Object? referringElementName = null,
    Object? isVisibleForTesting = null,
  }) {
    return _then(_self.copyWith(
      kind: null == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as TypeUsageKind,
      referringElementName: null == referringElementName
          ? _self.referringElementName
          : referringElementName // ignore: cast_nullable_to_non_nullable
              as String,
      isVisibleForTesting: null == isVisibleForTesting
          ? _self.isVisibleForTesting
          : isVisibleForTesting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [TypeUsage].
extension TypeUsagePatterns on TypeUsage {
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
    TResult Function(_TypeUsage value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TypeUsage() when $default != null:
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
    TResult Function(_TypeUsage value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeUsage():
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
    TResult? Function(_TypeUsage value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeUsage() when $default != null:
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
    TResult Function(TypeUsageKind kind, String referringElementName,
            bool isVisibleForTesting)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TypeUsage() when $default != null:
        return $default(
            _that.kind, _that.referringElementName, _that.isVisibleForTesting);
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
    TResult Function(TypeUsageKind kind, String referringElementName,
            bool isVisibleForTesting)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeUsage():
        return $default(
            _that.kind, _that.referringElementName, _that.isVisibleForTesting);
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
    TResult? Function(TypeUsageKind kind, String referringElementName,
            bool isVisibleForTesting)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeUsage() when $default != null:
        return $default(
            _that.kind, _that.referringElementName, _that.isVisibleForTesting);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TypeUsage extends TypeUsage {
  const _TypeUsage(
      {required this.kind,
      required this.referringElementName,
      required this.isVisibleForTesting})
      : super._();

  /// kind of usage
  @override
  final TypeUsageKind kind;

  /// the name of the referring element
  @override
  final String referringElementName;

  /// defines if the usage happened in a visibleForTesting context
  @override
  final bool isVisibleForTesting;

  /// Create a copy of TypeUsage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypeUsageCopyWith<_TypeUsage> get copyWith =>
      __$TypeUsageCopyWithImpl<_TypeUsage>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TypeUsage &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.referringElementName, referringElementName) ||
                other.referringElementName == referringElementName) &&
            (identical(other.isVisibleForTesting, isVisibleForTesting) ||
                other.isVisibleForTesting == isVisibleForTesting));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, kind, referringElementName, isVisibleForTesting);

  @override
  String toString() {
    return 'TypeUsage(kind: $kind, referringElementName: $referringElementName, isVisibleForTesting: $isVisibleForTesting)';
  }
}

/// @nodoc
abstract mixin class _$TypeUsageCopyWith<$Res>
    implements $TypeUsageCopyWith<$Res> {
  factory _$TypeUsageCopyWith(
          _TypeUsage value, $Res Function(_TypeUsage) _then) =
      __$TypeUsageCopyWithImpl;
  @override
  @useResult
  $Res call(
      {TypeUsageKind kind,
      String referringElementName,
      bool isVisibleForTesting});
}

/// @nodoc
class __$TypeUsageCopyWithImpl<$Res> implements _$TypeUsageCopyWith<$Res> {
  __$TypeUsageCopyWithImpl(this._self, this._then);

  final _TypeUsage _self;
  final $Res Function(_TypeUsage) _then;

  /// Create a copy of TypeUsage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? kind = null,
    Object? referringElementName = null,
    Object? isVisibleForTesting = null,
  }) {
    return _then(_TypeUsage(
      kind: null == kind
          ? _self.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as TypeUsageKind,
      referringElementName: null == referringElementName
          ? _self.referringElementName
          : referringElementName // ignore: cast_nullable_to_non_nullable
              as String,
      isVisibleForTesting: null == isVisibleForTesting
          ? _self.isVisibleForTesting
          : isVisibleForTesting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
