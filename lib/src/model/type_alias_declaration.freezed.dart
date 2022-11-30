// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_alias_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TypeAliasDeclaration {
  /// name of this type alias
  String get name => throw _privateConstructorUsedError;

  /// name of the aliased type
  String get aliasedTypeName => throw _privateConstructorUsedError;

  /// whether this type alias is deprecated
  bool get isDeprecated => throw _privateConstructorUsedError;

  /// whether this type alias is experimental
  bool get isExperimental => throw _privateConstructorUsedError;

  /// entry points this type alias is reachable through
  Set<String>? get entryPoints => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TypeAliasDeclarationCopyWith<TypeAliasDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeAliasDeclarationCopyWith<$Res> {
  factory $TypeAliasDeclarationCopyWith(TypeAliasDeclaration value,
          $Res Function(TypeAliasDeclaration) then) =
      _$TypeAliasDeclarationCopyWithImpl<$Res, TypeAliasDeclaration>;
  @useResult
  $Res call(
      {String name,
      String aliasedTypeName,
      bool isDeprecated,
      bool isExperimental,
      Set<String>? entryPoints});
}

/// @nodoc
class _$TypeAliasDeclarationCopyWithImpl<$Res,
        $Val extends TypeAliasDeclaration>
    implements $TypeAliasDeclarationCopyWith<$Res> {
  _$TypeAliasDeclarationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aliasedTypeName = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? entryPoints = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aliasedTypeName: null == aliasedTypeName
          ? _value.aliasedTypeName
          : aliasedTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
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
abstract class _$$_TypeAliasDeclarationCopyWith<$Res>
    implements $TypeAliasDeclarationCopyWith<$Res> {
  factory _$$_TypeAliasDeclarationCopyWith(_$_TypeAliasDeclaration value,
          $Res Function(_$_TypeAliasDeclaration) then) =
      __$$_TypeAliasDeclarationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String aliasedTypeName,
      bool isDeprecated,
      bool isExperimental,
      Set<String>? entryPoints});
}

/// @nodoc
class __$$_TypeAliasDeclarationCopyWithImpl<$Res>
    extends _$TypeAliasDeclarationCopyWithImpl<$Res, _$_TypeAliasDeclaration>
    implements _$$_TypeAliasDeclarationCopyWith<$Res> {
  __$$_TypeAliasDeclarationCopyWithImpl(_$_TypeAliasDeclaration _value,
      $Res Function(_$_TypeAliasDeclaration) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? aliasedTypeName = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? entryPoints = freezed,
  }) {
    return _then(_$_TypeAliasDeclaration(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      aliasedTypeName: null == aliasedTypeName
          ? _value.aliasedTypeName
          : aliasedTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
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

class _$_TypeAliasDeclaration extends _TypeAliasDeclaration {
  const _$_TypeAliasDeclaration(
      {required this.name,
      required this.aliasedTypeName,
      required this.isDeprecated,
      required this.isExperimental,
      final Set<String>? entryPoints})
      : _entryPoints = entryPoints,
        super._();

  /// name of this type alias
  @override
  final String name;

  /// name of the aliased type
  @override
  final String aliasedTypeName;

  /// whether this type alias is deprecated
  @override
  final bool isDeprecated;

  /// whether this type alias is experimental
  @override
  final bool isExperimental;

  /// entry points this type alias is reachable through
  final Set<String>? _entryPoints;

  /// entry points this type alias is reachable through
  @override
  Set<String>? get entryPoints {
    final value = _entryPoints;
    if (value == null) return null;
    if (_entryPoints is EqualUnmodifiableSetView) return _entryPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  @override
  String toString() {
    return 'TypeAliasDeclaration(name: $name, aliasedTypeName: $aliasedTypeName, isDeprecated: $isDeprecated, isExperimental: $isExperimental, entryPoints: $entryPoints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TypeAliasDeclaration &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.aliasedTypeName, aliasedTypeName) ||
                other.aliasedTypeName == aliasedTypeName) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            const DeepCollectionEquality()
                .equals(other._entryPoints, _entryPoints));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      aliasedTypeName,
      isDeprecated,
      isExperimental,
      const DeepCollectionEquality().hash(_entryPoints));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TypeAliasDeclarationCopyWith<_$_TypeAliasDeclaration> get copyWith =>
      __$$_TypeAliasDeclarationCopyWithImpl<_$_TypeAliasDeclaration>(
          this, _$identity);
}

abstract class _TypeAliasDeclaration extends TypeAliasDeclaration
    implements Declaration {
  const factory _TypeAliasDeclaration(
      {required final String name,
      required final String aliasedTypeName,
      required final bool isDeprecated,
      required final bool isExperimental,
      final Set<String>? entryPoints}) = _$_TypeAliasDeclaration;
  const _TypeAliasDeclaration._() : super._();

  @override

  /// name of this type alias
  String get name;
  @override

  /// name of the aliased type
  String get aliasedTypeName;
  @override

  /// whether this type alias is deprecated
  bool get isDeprecated;
  @override

  /// whether this type alias is experimental
  bool get isExperimental;
  @override

  /// entry points this type alias is reachable through
  Set<String>? get entryPoints;
  @override
  @JsonKey(ignore: true)
  _$$_TypeAliasDeclarationCopyWith<_$_TypeAliasDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}
