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
mixin _$TypeIdentifier {
  /// the name of this type
  String get name => throw _privateConstructorUsedError;

  /// the full library name
  String? get fullLibraryName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TypeIdentifierCopyWith<TypeIdentifier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeIdentifierCopyWith<$Res> {
  factory $TypeIdentifierCopyWith(
          TypeIdentifier value, $Res Function(TypeIdentifier) then) =
      _$TypeIdentifierCopyWithImpl<$Res, TypeIdentifier>;
  @useResult
  $Res call({String name, String? fullLibraryName});
}

/// @nodoc
class _$TypeIdentifierCopyWithImpl<$Res, $Val extends TypeIdentifier>
    implements $TypeIdentifierCopyWith<$Res> {
  _$TypeIdentifierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fullLibraryName = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullLibraryName: freezed == fullLibraryName
          ? _value.fullLibraryName
          : fullLibraryName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TypeIdentifierCopyWith<$Res>
    implements $TypeIdentifierCopyWith<$Res> {
  factory _$$_TypeIdentifierCopyWith(
          _$_TypeIdentifier value, $Res Function(_$_TypeIdentifier) then) =
      __$$_TypeIdentifierCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? fullLibraryName});
}

/// @nodoc
class __$$_TypeIdentifierCopyWithImpl<$Res>
    extends _$TypeIdentifierCopyWithImpl<$Res, _$_TypeIdentifier>
    implements _$$_TypeIdentifierCopyWith<$Res> {
  __$$_TypeIdentifierCopyWithImpl(
      _$_TypeIdentifier _value, $Res Function(_$_TypeIdentifier) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? fullLibraryName = freezed,
  }) {
    return _then(_$_TypeIdentifier(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      fullLibraryName: freezed == fullLibraryName
          ? _value.fullLibraryName
          : fullLibraryName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_TypeIdentifier extends _TypeIdentifier {
  const _$_TypeIdentifier({required this.name, required this.fullLibraryName})
      : super._();

  /// the name of this type
  @override
  final String name;

  /// the full library name
  @override
  final String? fullLibraryName;

  @override
  String toString() {
    return 'TypeIdentifier(name: $name, fullLibraryName: $fullLibraryName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TypeIdentifier &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fullLibraryName, fullLibraryName) ||
                other.fullLibraryName == fullLibraryName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, fullLibraryName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TypeIdentifierCopyWith<_$_TypeIdentifier> get copyWith =>
      __$$_TypeIdentifierCopyWithImpl<_$_TypeIdentifier>(this, _$identity);
}

abstract class _TypeIdentifier extends TypeIdentifier {
  const factory _TypeIdentifier(
      {required final String name,
      required final String? fullLibraryName}) = _$_TypeIdentifier;
  const _TypeIdentifier._() : super._();

  @override

  /// the name of this type
  String get name;
  @override

  /// the full library name
  String? get fullLibraryName;
  @override
  @JsonKey(ignore: true)
  _$$_TypeIdentifierCopyWith<_$_TypeIdentifier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TypeHierarchyItem {
  /// the identifier of this type
  TypeIdentifier get typeIdentifier => throw _privateConstructorUsedError;

  /// the type identifiers of the super types of this type
  Set<TypeIdentifier> get baseTypeIdentifiers =>
      throw _privateConstructorUsedError;

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
  $Res call(
      {TypeIdentifier typeIdentifier, Set<TypeIdentifier> baseTypeIdentifiers});

  $TypeIdentifierCopyWith<$Res> get typeIdentifier;
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
    Object? typeIdentifier = null,
    Object? baseTypeIdentifiers = null,
  }) {
    return _then(_value.copyWith(
      typeIdentifier: null == typeIdentifier
          ? _value.typeIdentifier
          : typeIdentifier // ignore: cast_nullable_to_non_nullable
              as TypeIdentifier,
      baseTypeIdentifiers: null == baseTypeIdentifiers
          ? _value.baseTypeIdentifiers
          : baseTypeIdentifiers // ignore: cast_nullable_to_non_nullable
              as Set<TypeIdentifier>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TypeIdentifierCopyWith<$Res> get typeIdentifier {
    return $TypeIdentifierCopyWith<$Res>(_value.typeIdentifier, (value) {
      return _then(_value.copyWith(typeIdentifier: value) as $Val);
    });
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
  $Res call(
      {TypeIdentifier typeIdentifier, Set<TypeIdentifier> baseTypeIdentifiers});

  @override
  $TypeIdentifierCopyWith<$Res> get typeIdentifier;
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
    Object? typeIdentifier = null,
    Object? baseTypeIdentifiers = null,
  }) {
    return _then(_$_TypeHierarchyItem(
      typeIdentifier: null == typeIdentifier
          ? _value.typeIdentifier
          : typeIdentifier // ignore: cast_nullable_to_non_nullable
              as TypeIdentifier,
      baseTypeIdentifiers: null == baseTypeIdentifiers
          ? _value._baseTypeIdentifiers
          : baseTypeIdentifiers // ignore: cast_nullable_to_non_nullable
              as Set<TypeIdentifier>,
    ));
  }
}

/// @nodoc

class _$_TypeHierarchyItem extends _TypeHierarchyItem {
  const _$_TypeHierarchyItem(
      {required this.typeIdentifier,
      required final Set<TypeIdentifier> baseTypeIdentifiers})
      : _baseTypeIdentifiers = baseTypeIdentifiers,
        super._();

  /// the identifier of this type
  @override
  final TypeIdentifier typeIdentifier;

  /// the type identifiers of the super types of this type
  final Set<TypeIdentifier> _baseTypeIdentifiers;

  /// the type identifiers of the super types of this type
  @override
  Set<TypeIdentifier> get baseTypeIdentifiers {
    if (_baseTypeIdentifiers is EqualUnmodifiableSetView)
      return _baseTypeIdentifiers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_baseTypeIdentifiers);
  }

  @override
  String toString() {
    return 'TypeHierarchyItem(typeIdentifier: $typeIdentifier, baseTypeIdentifiers: $baseTypeIdentifiers)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TypeHierarchyItem &&
            (identical(other.typeIdentifier, typeIdentifier) ||
                other.typeIdentifier == typeIdentifier) &&
            const DeepCollectionEquality()
                .equals(other._baseTypeIdentifiers, _baseTypeIdentifiers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, typeIdentifier,
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
          {required final TypeIdentifier typeIdentifier,
          required final Set<TypeIdentifier> baseTypeIdentifiers}) =
      _$_TypeHierarchyItem;
  const _TypeHierarchyItem._() : super._();

  @override

  /// the identifier of this type
  TypeIdentifier get typeIdentifier;
  @override

  /// the type identifiers of the super types of this type
  Set<TypeIdentifier> get baseTypeIdentifiers;
  @override
  @JsonKey(ignore: true)
  _$$_TypeHierarchyItemCopyWith<_$_TypeHierarchyItem> get copyWith =>
      throw _privateConstructorUsedError;
}
