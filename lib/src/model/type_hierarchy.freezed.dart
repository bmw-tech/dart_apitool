// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_hierarchy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TypeHierarchy {
  /// the type hierarchy items
  Map<String, TypeHierarchyItem> get types =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TypeHierarchyCopyWith<TypeHierarchy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeHierarchyCopyWith<$Res> {
  factory $TypeHierarchyCopyWith(
          TypeHierarchy value, $Res Function(TypeHierarchy) then) =
      _$TypeHierarchyCopyWithImpl<$Res, TypeHierarchy>;
  @useResult
  $Res call({Map<String, TypeHierarchyItem> types});
}

/// @nodoc
class _$TypeHierarchyCopyWithImpl<$Res, $Val extends TypeHierarchy>
    implements $TypeHierarchyCopyWith<$Res> {
  _$TypeHierarchyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? types = null,
  }) {
    return _then(_value.copyWith(
      types: null == types
          ? _value.types
          : types // ignore: cast_nullable_to_non_nullable
              as Map<String, TypeHierarchyItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TypeHierarchyCopyWith<$Res>
    implements $TypeHierarchyCopyWith<$Res> {
  factory _$$_TypeHierarchyCopyWith(
          _$_TypeHierarchy value, $Res Function(_$_TypeHierarchy) then) =
      __$$_TypeHierarchyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, TypeHierarchyItem> types});
}

/// @nodoc
class __$$_TypeHierarchyCopyWithImpl<$Res>
    extends _$TypeHierarchyCopyWithImpl<$Res, _$_TypeHierarchy>
    implements _$$_TypeHierarchyCopyWith<$Res> {
  __$$_TypeHierarchyCopyWithImpl(
      _$_TypeHierarchy _value, $Res Function(_$_TypeHierarchy) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? types = null,
  }) {
    return _then(_$_TypeHierarchy(
      types: null == types
          ? _value._types
          : types // ignore: cast_nullable_to_non_nullable
              as Map<String, TypeHierarchyItem>,
    ));
  }
}

/// @nodoc

class _$_TypeHierarchy extends _TypeHierarchy {
  const _$_TypeHierarchy({required final Map<String, TypeHierarchyItem> types})
      : _types = types,
        super._();

  /// the type hierarchy items
  final Map<String, TypeHierarchyItem> _types;

  /// the type hierarchy items
  @override
  Map<String, TypeHierarchyItem> get types {
    if (_types is EqualUnmodifiableMapView) return _types;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_types);
  }

  @override
  String toString() {
    return 'TypeHierarchy(types: $types)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TypeHierarchy &&
            const DeepCollectionEquality().equals(other._types, _types));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_types));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TypeHierarchyCopyWith<_$_TypeHierarchy> get copyWith =>
      __$$_TypeHierarchyCopyWithImpl<_$_TypeHierarchy>(this, _$identity);
}

abstract class _TypeHierarchy extends TypeHierarchy {
  const factory _TypeHierarchy(
      {required final Map<String, TypeHierarchyItem> types}) = _$_TypeHierarchy;
  const _TypeHierarchy._() : super._();

  @override

  /// the type hierarchy items
  Map<String, TypeHierarchyItem> get types;
  @override
  @JsonKey(ignore: true)
  _$$_TypeHierarchyCopyWith<_$_TypeHierarchy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TypeHierarchyItem {
  /// the name of this type
  String get name => throw _privateConstructorUsedError;

  /// the namespace of this type. This gets populated if the type got imported with a prefix
  String get namespace => throw _privateConstructorUsedError;

  /// the type identifiers of the super types of this type
  Set<String> get baseTypeIdentifiers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TypeHierarchyItemCopyWith<TypeHierarchyItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeHierarchyItemCopyWith<$Res> {
  factory $TypeHierarchyItemCopyWith(
          TypeHierarchyItem value, $Res Function(TypeHierarchyItem) then) =
      _$TypeHierarchyItemCopyWithImpl<$Res, TypeHierarchyItem>;
  @useResult
  $Res call({String name, String namespace, Set<String> baseTypeIdentifiers});
}

/// @nodoc
class _$TypeHierarchyItemCopyWithImpl<$Res, $Val extends TypeHierarchyItem>
    implements $TypeHierarchyItemCopyWith<$Res> {
  _$TypeHierarchyItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? namespace = null,
    Object? baseTypeIdentifiers = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      namespace: null == namespace
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as String,
      baseTypeIdentifiers: null == baseTypeIdentifiers
          ? _value.baseTypeIdentifiers
          : baseTypeIdentifiers // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TypeHierarchyItemCopyWith<$Res>
    implements $TypeHierarchyItemCopyWith<$Res> {
  factory _$$_TypeHierarchyItemCopyWith(_$_TypeHierarchyItem value,
          $Res Function(_$_TypeHierarchyItem) then) =
      __$$_TypeHierarchyItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String namespace, Set<String> baseTypeIdentifiers});
}

/// @nodoc
class __$$_TypeHierarchyItemCopyWithImpl<$Res>
    extends _$TypeHierarchyItemCopyWithImpl<$Res, _$_TypeHierarchyItem>
    implements _$$_TypeHierarchyItemCopyWith<$Res> {
  __$$_TypeHierarchyItemCopyWithImpl(
      _$_TypeHierarchyItem _value, $Res Function(_$_TypeHierarchyItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? namespace = null,
    Object? baseTypeIdentifiers = null,
  }) {
    return _then(_$_TypeHierarchyItem(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      namespace: null == namespace
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as String,
      baseTypeIdentifiers: null == baseTypeIdentifiers
          ? _value._baseTypeIdentifiers
          : baseTypeIdentifiers // ignore: cast_nullable_to_non_nullable
              as Set<String>,
    ));
  }
}

/// @nodoc

class _$_TypeHierarchyItem extends _TypeHierarchyItem {
  const _$_TypeHierarchyItem(
      {required this.name,
      required this.namespace,
      required final Set<String> baseTypeIdentifiers})
      : _baseTypeIdentifiers = baseTypeIdentifiers,
        super._();

  /// the name of this type
  @override
  final String name;

  /// the namespace of this type. This gets populated if the type got imported with a prefix
  @override
  final String namespace;

  /// the type identifiers of the super types of this type
  final Set<String> _baseTypeIdentifiers;

  /// the type identifiers of the super types of this type
  @override
  Set<String> get baseTypeIdentifiers {
    if (_baseTypeIdentifiers is EqualUnmodifiableSetView)
      return _baseTypeIdentifiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_baseTypeIdentifiers);
  }

  @override
  String toString() {
    return 'TypeHierarchyItem(name: $name, namespace: $namespace, baseTypeIdentifiers: $baseTypeIdentifiers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TypeHierarchyItem &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.namespace, namespace) ||
                other.namespace == namespace) &&
            const DeepCollectionEquality()
                .equals(other._baseTypeIdentifiers, _baseTypeIdentifiers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, namespace,
      const DeepCollectionEquality().hash(_baseTypeIdentifiers));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TypeHierarchyItemCopyWith<_$_TypeHierarchyItem> get copyWith =>
      __$$_TypeHierarchyItemCopyWithImpl<_$_TypeHierarchyItem>(
          this, _$identity);
}

abstract class _TypeHierarchyItem extends TypeHierarchyItem {
  const factory _TypeHierarchyItem(
      {required final String name,
      required final String namespace,
      required final Set<String> baseTypeIdentifiers}) = _$_TypeHierarchyItem;
  const _TypeHierarchyItem._() : super._();

  @override

  /// the name of this type
  String get name;
  @override

  /// the namespace of this type. This gets populated if the type got imported with a prefix
  String get namespace;
  @override

  /// the type identifiers of the super types of this type
  Set<String> get baseTypeIdentifiers;
  @override
  @JsonKey(ignore: true)
  _$$_TypeHierarchyItemCopyWith<_$_TypeHierarchyItem> get copyWith =>
      throw _privateConstructorUsedError;
}
