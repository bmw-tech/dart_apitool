// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
