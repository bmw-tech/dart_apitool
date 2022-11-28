// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'field_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FieldDeclaration {
  /// type of this field
  String get typeName => throw _privateConstructorUsedError;

  /// name of this field
  String get name => throw _privateConstructorUsedError;

  /// whether this field is deprecated
  bool get isDeprecated => throw _privateConstructorUsedError;

  /// whether this field is static
  bool get isStatic => throw _privateConstructorUsedError;

  /// whether this field is experimental
  bool get isExperimental => throw _privateConstructorUsedError;

  /// entry points this field is reachable through
  Set<String>? get entryPoints => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FieldDeclarationCopyWith<FieldDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldDeclarationCopyWith<$Res> {
  factory $FieldDeclarationCopyWith(
          FieldDeclaration value, $Res Function(FieldDeclaration) then) =
      _$FieldDeclarationCopyWithImpl<$Res, FieldDeclaration>;
  @useResult
  $Res call(
      {String typeName,
      String name,
      bool isDeprecated,
      bool isStatic,
      bool isExperimental,
      Set<String>? entryPoints});
}

/// @nodoc
class _$FieldDeclarationCopyWithImpl<$Res, $Val extends FieldDeclaration>
    implements $FieldDeclarationCopyWith<$Res> {
  _$FieldDeclarationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeName = null,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isStatic = null,
    Object? isExperimental = null,
    Object? entryPoints = freezed,
  }) {
    return _then(_value.copyWith(
      typeName: null == typeName
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isStatic: null == isStatic
          ? _value.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
      isExperimental: null == isExperimental
          ? _value.isExperimental
          : isExperimental // ignore: cast_nullable_to_non_nullable
              as bool,
      entryPoints: freezed == entryPoints
          ? _value.entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FieldDeclarationCopyWith<$Res>
    implements $FieldDeclarationCopyWith<$Res> {
  factory _$$_FieldDeclarationCopyWith(
          _$_FieldDeclaration value, $Res Function(_$_FieldDeclaration) then) =
      __$$_FieldDeclarationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String typeName,
      String name,
      bool isDeprecated,
      bool isStatic,
      bool isExperimental,
      Set<String>? entryPoints});
}

/// @nodoc
class __$$_FieldDeclarationCopyWithImpl<$Res>
    extends _$FieldDeclarationCopyWithImpl<$Res, _$_FieldDeclaration>
    implements _$$_FieldDeclarationCopyWith<$Res> {
  __$$_FieldDeclarationCopyWithImpl(
      _$_FieldDeclaration _value, $Res Function(_$_FieldDeclaration) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeName = null,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isStatic = null,
    Object? isExperimental = null,
    Object? entryPoints = freezed,
  }) {
    return _then(_$_FieldDeclaration(
      typeName: null == typeName
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isStatic: null == isStatic
          ? _value.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
      isExperimental: null == isExperimental
          ? _value.isExperimental
          : isExperimental // ignore: cast_nullable_to_non_nullable
              as bool,
      entryPoints: freezed == entryPoints
          ? _value._entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
    ));
  }
}

/// @nodoc

class _$_FieldDeclaration extends _FieldDeclaration {
  const _$_FieldDeclaration(
      {required this.typeName,
      required this.name,
      required this.isDeprecated,
      required this.isStatic,
      required this.isExperimental,
      final Set<String>? entryPoints})
      : _entryPoints = entryPoints,
        super._();

  /// type of this field
  @override
  final String typeName;

  /// name of this field
  @override
  final String name;

  /// whether this field is deprecated
  @override
  final bool isDeprecated;

  /// whether this field is static
  @override
  final bool isStatic;

  /// whether this field is experimental
  @override
  final bool isExperimental;

  /// entry points this field is reachable through
  final Set<String>? _entryPoints;

  /// entry points this field is reachable through
  @override
  Set<String>? get entryPoints {
    final value = _entryPoints;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  @override
  String toString() {
    return 'FieldDeclaration(typeName: $typeName, name: $name, isDeprecated: $isDeprecated, isStatic: $isStatic, isExperimental: $isExperimental, entryPoints: $entryPoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FieldDeclaration &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isStatic, isStatic) ||
                other.isStatic == isStatic) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            const DeepCollectionEquality()
                .equals(other._entryPoints, _entryPoints));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      typeName,
      name,
      isDeprecated,
      isStatic,
      isExperimental,
      const DeepCollectionEquality().hash(_entryPoints));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FieldDeclarationCopyWith<_$_FieldDeclaration> get copyWith =>
      __$$_FieldDeclarationCopyWithImpl<_$_FieldDeclaration>(this, _$identity);
}

abstract class _FieldDeclaration extends FieldDeclaration
    implements Declaration {
  const factory _FieldDeclaration(
      {required final String typeName,
      required final String name,
      required final bool isDeprecated,
      required final bool isStatic,
      required final bool isExperimental,
      final Set<String>? entryPoints}) = _$_FieldDeclaration;
  const _FieldDeclaration._() : super._();

  @override

  /// type of this field
  String get typeName;
  @override

  /// name of this field
  String get name;
  @override

  /// whether this field is deprecated
  bool get isDeprecated;
  @override

  /// whether this field is static
  bool get isStatic;
  @override

  /// whether this field is experimental
  bool get isExperimental;
  @override

  /// entry points this field is reachable through
  Set<String>? get entryPoints;
  @override
  @JsonKey(ignore: true)
  _$$_FieldDeclarationCopyWith<_$_FieldDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}
