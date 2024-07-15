// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_usage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TypeUsage {
  /// kind of usage
  TypeUsageKind get kind => throw _privateConstructorUsedError;

  /// the name of the referring element
  String get referringElementName => throw _privateConstructorUsedError;

  /// defines if the usage happened in a visibleForTesting context
  bool get isVisibleForTesting => throw _privateConstructorUsedError;

  /// Create a copy of TypeUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypeUsageCopyWith<TypeUsage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeUsageCopyWith<$Res> {
  factory $TypeUsageCopyWith(TypeUsage value, $Res Function(TypeUsage) then) =
      _$TypeUsageCopyWithImpl<$Res, TypeUsage>;
  @useResult
  $Res call(
      {TypeUsageKind kind,
      String referringElementName,
      bool isVisibleForTesting});
}

/// @nodoc
class _$TypeUsageCopyWithImpl<$Res, $Val extends TypeUsage>
    implements $TypeUsageCopyWith<$Res> {
  _$TypeUsageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypeUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = null,
    Object? referringElementName = null,
    Object? isVisibleForTesting = null,
  }) {
    return _then(_value.copyWith(
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as TypeUsageKind,
      referringElementName: null == referringElementName
          ? _value.referringElementName
          : referringElementName // ignore: cast_nullable_to_non_nullable
              as String,
      isVisibleForTesting: null == isVisibleForTesting
          ? _value.isVisibleForTesting
          : isVisibleForTesting // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TypeUsageImplCopyWith<$Res>
    implements $TypeUsageCopyWith<$Res> {
  factory _$$TypeUsageImplCopyWith(
          _$TypeUsageImpl value, $Res Function(_$TypeUsageImpl) then) =
      __$$TypeUsageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TypeUsageKind kind,
      String referringElementName,
      bool isVisibleForTesting});
}

/// @nodoc
class __$$TypeUsageImplCopyWithImpl<$Res>
    extends _$TypeUsageCopyWithImpl<$Res, _$TypeUsageImpl>
    implements _$$TypeUsageImplCopyWith<$Res> {
  __$$TypeUsageImplCopyWithImpl(
      _$TypeUsageImpl _value, $Res Function(_$TypeUsageImpl) _then)
      : super(_value, _then);

  /// Create a copy of TypeUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = null,
    Object? referringElementName = null,
    Object? isVisibleForTesting = null,
  }) {
    return _then(_$TypeUsageImpl(
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as TypeUsageKind,
      referringElementName: null == referringElementName
          ? _value.referringElementName
          : referringElementName // ignore: cast_nullable_to_non_nullable
              as String,
      isVisibleForTesting: null == isVisibleForTesting
          ? _value.isVisibleForTesting
          : isVisibleForTesting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TypeUsageImpl extends _TypeUsage {
  const _$TypeUsageImpl(
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

  @override
  String toString() {
    return 'TypeUsage(kind: $kind, referringElementName: $referringElementName, isVisibleForTesting: $isVisibleForTesting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypeUsageImpl &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.referringElementName, referringElementName) ||
                other.referringElementName == referringElementName) &&
            (identical(other.isVisibleForTesting, isVisibleForTesting) ||
                other.isVisibleForTesting == isVisibleForTesting));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, kind, referringElementName, isVisibleForTesting);

  /// Create a copy of TypeUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypeUsageImplCopyWith<_$TypeUsageImpl> get copyWith =>
      __$$TypeUsageImplCopyWithImpl<_$TypeUsageImpl>(this, _$identity);
}

abstract class _TypeUsage extends TypeUsage {
  const factory _TypeUsage(
      {required final TypeUsageKind kind,
      required final String referringElementName,
      required final bool isVisibleForTesting}) = _$TypeUsageImpl;
  const _TypeUsage._() : super._();

  /// kind of usage
  @override
  TypeUsageKind get kind;

  /// the name of the referring element
  @override
  String get referringElementName;

  /// defines if the usage happened in a visibleForTesting context
  @override
  bool get isVisibleForTesting;

  /// Create a copy of TypeUsage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypeUsageImplCopyWith<_$TypeUsageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
