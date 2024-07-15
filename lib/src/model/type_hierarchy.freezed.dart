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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TypeIdentifier {
  /// the name of this type
  String get typeName => throw _privateConstructorUsedError;

  /// the name of the package defining that type
  String get packageName => throw _privateConstructorUsedError;

  /// the library path inside the package defining that type
  String get packageRelativeLibraryPath => throw _privateConstructorUsedError;

  /// Create a copy of TypeIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TypeIdentifierCopyWith<TypeIdentifier> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeIdentifierCopyWith<$Res> {
  factory $TypeIdentifierCopyWith(
          TypeIdentifier value, $Res Function(TypeIdentifier) then) =
      _$TypeIdentifierCopyWithImpl<$Res, TypeIdentifier>;
  @useResult
  $Res call(
      {String typeName, String packageName, String packageRelativeLibraryPath});
}

/// @nodoc
class _$TypeIdentifierCopyWithImpl<$Res, $Val extends TypeIdentifier>
    implements $TypeIdentifierCopyWith<$Res> {
  _$TypeIdentifierCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TypeIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeName = null,
    Object? packageName = null,
    Object? packageRelativeLibraryPath = null,
  }) {
    return _then(_value.copyWith(
      typeName: null == typeName
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageRelativeLibraryPath: null == packageRelativeLibraryPath
          ? _value.packageRelativeLibraryPath
          : packageRelativeLibraryPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TypeIdentifierImplCopyWith<$Res>
    implements $TypeIdentifierCopyWith<$Res> {
  factory _$$TypeIdentifierImplCopyWith(_$TypeIdentifierImpl value,
          $Res Function(_$TypeIdentifierImpl) then) =
      __$$TypeIdentifierImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String typeName, String packageName, String packageRelativeLibraryPath});
}

/// @nodoc
class __$$TypeIdentifierImplCopyWithImpl<$Res>
    extends _$TypeIdentifierCopyWithImpl<$Res, _$TypeIdentifierImpl>
    implements _$$TypeIdentifierImplCopyWith<$Res> {
  __$$TypeIdentifierImplCopyWithImpl(
      _$TypeIdentifierImpl _value, $Res Function(_$TypeIdentifierImpl) _then)
      : super(_value, _then);

  /// Create a copy of TypeIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeName = null,
    Object? packageName = null,
    Object? packageRelativeLibraryPath = null,
  }) {
    return _then(_$TypeIdentifierImpl(
      typeName: null == typeName
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageRelativeLibraryPath: null == packageRelativeLibraryPath
          ? _value.packageRelativeLibraryPath
          : packageRelativeLibraryPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TypeIdentifierImpl extends _TypeIdentifier {
  const _$TypeIdentifierImpl(
      {required this.typeName,
      required this.packageName,
      required this.packageRelativeLibraryPath})
      : super._();

  /// the name of this type
  @override
  final String typeName;

  /// the name of the package defining that type
  @override
  final String packageName;

  /// the library path inside the package defining that type
  @override
  final String packageRelativeLibraryPath;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TypeIdentifierImpl &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageRelativeLibraryPath,
                    packageRelativeLibraryPath) ||
                other.packageRelativeLibraryPath ==
                    packageRelativeLibraryPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, typeName, packageName, packageRelativeLibraryPath);

  /// Create a copy of TypeIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TypeIdentifierImplCopyWith<_$TypeIdentifierImpl> get copyWith =>
      __$$TypeIdentifierImplCopyWithImpl<_$TypeIdentifierImpl>(
          this, _$identity);
}

abstract class _TypeIdentifier extends TypeIdentifier {
  const factory _TypeIdentifier(
      {required final String typeName,
      required final String packageName,
      required final String packageRelativeLibraryPath}) = _$TypeIdentifierImpl;
  const _TypeIdentifier._() : super._();

  /// the name of this type
  @override
  String get typeName;

  /// the name of the package defining that type
  @override
  String get packageName;

  /// the library path inside the package defining that type
  @override
  String get packageRelativeLibraryPath;

  /// Create a copy of TypeIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TypeIdentifierImplCopyWith<_$TypeIdentifierImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TypeHierarchyItem {
  /// the identifier of this type
  TypeIdentifier get typeIdentifier => throw _privateConstructorUsedError;

  /// the type identifiers of the super types of this type
  Set<TypeIdentifier> get baseTypeIdentifiers =>
      throw _privateConstructorUsedError;

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$TypeHierarchyItemCopyWith<_TypeHierarchyItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$TypeHierarchyItemCopyWith<$Res> {
  factory _$TypeHierarchyItemCopyWith(
          _TypeHierarchyItem value, $Res Function(_TypeHierarchyItem) then) =
      __$TypeHierarchyItemCopyWithImpl<$Res, _TypeHierarchyItem>;
  @useResult
  $Res call(
      {TypeIdentifier typeIdentifier, Set<TypeIdentifier> baseTypeIdentifiers});

  $TypeIdentifierCopyWith<$Res> get typeIdentifier;
}

/// @nodoc
class __$TypeHierarchyItemCopyWithImpl<$Res, $Val extends _TypeHierarchyItem>
    implements _$TypeHierarchyItemCopyWith<$Res> {
  __$TypeHierarchyItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
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

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TypeIdentifierCopyWith<$Res> get typeIdentifier {
    return $TypeIdentifierCopyWith<$Res>(_value.typeIdentifier, (value) {
      return _then(_value.copyWith(typeIdentifier: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TypeHierarchyItemImplCopyWith<$Res>
    implements _$TypeHierarchyItemCopyWith<$Res> {
  factory _$$_TypeHierarchyItemImplCopyWith(_$_TypeHierarchyItemImpl value,
          $Res Function(_$_TypeHierarchyItemImpl) then) =
      __$$_TypeHierarchyItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TypeIdentifier typeIdentifier, Set<TypeIdentifier> baseTypeIdentifiers});

  @override
  $TypeIdentifierCopyWith<$Res> get typeIdentifier;
}

/// @nodoc
class __$$_TypeHierarchyItemImplCopyWithImpl<$Res>
    extends __$TypeHierarchyItemCopyWithImpl<$Res, _$_TypeHierarchyItemImpl>
    implements _$$_TypeHierarchyItemImplCopyWith<$Res> {
  __$$_TypeHierarchyItemImplCopyWithImpl(_$_TypeHierarchyItemImpl _value,
      $Res Function(_$_TypeHierarchyItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeIdentifier = null,
    Object? baseTypeIdentifiers = null,
  }) {
    return _then(_$_TypeHierarchyItemImpl(
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

class _$_TypeHierarchyItemImpl extends __TypeHierarchyItem {
  const _$_TypeHierarchyItemImpl(
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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TypeHierarchyItemImpl &&
            (identical(other.typeIdentifier, typeIdentifier) ||
                other.typeIdentifier == typeIdentifier) &&
            const DeepCollectionEquality()
                .equals(other._baseTypeIdentifiers, _baseTypeIdentifiers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, typeIdentifier,
      const DeepCollectionEquality().hash(_baseTypeIdentifiers));

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$_TypeHierarchyItemImplCopyWith<_$_TypeHierarchyItemImpl> get copyWith =>
      __$$_TypeHierarchyItemImplCopyWithImpl<_$_TypeHierarchyItemImpl>(
          this, _$identity);
}

abstract class __TypeHierarchyItem extends _TypeHierarchyItem {
  const factory __TypeHierarchyItem(
          {required final TypeIdentifier typeIdentifier,
          required final Set<TypeIdentifier> baseTypeIdentifiers}) =
      _$_TypeHierarchyItemImpl;
  const __TypeHierarchyItem._() : super._();

  /// the identifier of this type
  @override
  TypeIdentifier get typeIdentifier;

  /// the type identifiers of the super types of this type
  @override
  Set<TypeIdentifier> get baseTypeIdentifiers;

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$_TypeHierarchyItemImplCopyWith<_$_TypeHierarchyItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
