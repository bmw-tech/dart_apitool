// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'type_hierarchy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TypeIdentifier {
  /// the name of this type
  String get typeName;

  /// the name of the package defining that type
  String get packageName;

  /// the library path inside the package defining that type
  String get packageRelativeLibraryPath;

  /// Create a copy of TypeIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TypeIdentifierCopyWith<TypeIdentifier> get copyWith =>
      _$TypeIdentifierCopyWithImpl<TypeIdentifier>(
          this as TypeIdentifier, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TypeIdentifier &&
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
}

/// @nodoc
abstract mixin class $TypeIdentifierCopyWith<$Res> {
  factory $TypeIdentifierCopyWith(
          TypeIdentifier value, $Res Function(TypeIdentifier) _then) =
      _$TypeIdentifierCopyWithImpl;
  @useResult
  $Res call(
      {String typeName, String packageName, String packageRelativeLibraryPath});
}

/// @nodoc
class _$TypeIdentifierCopyWithImpl<$Res>
    implements $TypeIdentifierCopyWith<$Res> {
  _$TypeIdentifierCopyWithImpl(this._self, this._then);

  final TypeIdentifier _self;
  final $Res Function(TypeIdentifier) _then;

  /// Create a copy of TypeIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeName = null,
    Object? packageName = null,
    Object? packageRelativeLibraryPath = null,
  }) {
    return _then(_self.copyWith(
      typeName: null == typeName
          ? _self.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: null == packageName
          ? _self.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageRelativeLibraryPath: null == packageRelativeLibraryPath
          ? _self.packageRelativeLibraryPath
          : packageRelativeLibraryPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TypeIdentifier].
extension TypeIdentifierPatterns on TypeIdentifier {
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
    TResult Function(_TypeIdentifier value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TypeIdentifier() when $default != null:
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
    TResult Function(_TypeIdentifier value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeIdentifier():
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
    TResult? Function(_TypeIdentifier value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeIdentifier() when $default != null:
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
    TResult Function(String typeName, String packageName,
            String packageRelativeLibraryPath)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TypeIdentifier() when $default != null:
        return $default(_that.typeName, _that.packageName,
            _that.packageRelativeLibraryPath);
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
    TResult Function(String typeName, String packageName,
            String packageRelativeLibraryPath)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeIdentifier():
        return $default(_that.typeName, _that.packageName,
            _that.packageRelativeLibraryPath);
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
    TResult? Function(String typeName, String packageName,
            String packageRelativeLibraryPath)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TypeIdentifier() when $default != null:
        return $default(_that.typeName, _that.packageName,
            _that.packageRelativeLibraryPath);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _TypeIdentifier extends TypeIdentifier {
  const _TypeIdentifier(
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

  /// Create a copy of TypeIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypeIdentifierCopyWith<_TypeIdentifier> get copyWith =>
      __$TypeIdentifierCopyWithImpl<_TypeIdentifier>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TypeIdentifier &&
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
}

/// @nodoc
abstract mixin class _$TypeIdentifierCopyWith<$Res>
    implements $TypeIdentifierCopyWith<$Res> {
  factory _$TypeIdentifierCopyWith(
          _TypeIdentifier value, $Res Function(_TypeIdentifier) _then) =
      __$TypeIdentifierCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String typeName, String packageName, String packageRelativeLibraryPath});
}

/// @nodoc
class __$TypeIdentifierCopyWithImpl<$Res>
    implements _$TypeIdentifierCopyWith<$Res> {
  __$TypeIdentifierCopyWithImpl(this._self, this._then);

  final _TypeIdentifier _self;
  final $Res Function(_TypeIdentifier) _then;

  /// Create a copy of TypeIdentifier
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? typeName = null,
    Object? packageName = null,
    Object? packageRelativeLibraryPath = null,
  }) {
    return _then(_TypeIdentifier(
      typeName: null == typeName
          ? _self.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      packageName: null == packageName
          ? _self.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageRelativeLibraryPath: null == packageRelativeLibraryPath
          ? _self.packageRelativeLibraryPath
          : packageRelativeLibraryPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$TypeHierarchyItem {
  /// the identifier of this type
  TypeIdentifier get typeIdentifier;

  /// the type identifiers of the super types of this type
  Set<TypeIdentifier> get baseTypeIdentifiers;

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TypeHierarchyItemCopyWith<_TypeHierarchyItem> get copyWith =>
      __$TypeHierarchyItemCopyWithImpl<_TypeHierarchyItem>(
          this as _TypeHierarchyItem, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TypeHierarchyItem &&
            (identical(other.typeIdentifier, typeIdentifier) ||
                other.typeIdentifier == typeIdentifier) &&
            const DeepCollectionEquality()
                .equals(other.baseTypeIdentifiers, baseTypeIdentifiers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, typeIdentifier,
      const DeepCollectionEquality().hash(baseTypeIdentifiers));
}

/// @nodoc
abstract mixin class _$TypeHierarchyItemCopyWith<$Res> {
  factory _$TypeHierarchyItemCopyWith(
          _TypeHierarchyItem value, $Res Function(_TypeHierarchyItem) _then) =
      __$TypeHierarchyItemCopyWithImpl;
  @useResult
  $Res call(
      {TypeIdentifier typeIdentifier, Set<TypeIdentifier> baseTypeIdentifiers});

  $TypeIdentifierCopyWith<$Res> get typeIdentifier;
}

/// @nodoc
class __$TypeHierarchyItemCopyWithImpl<$Res>
    implements _$TypeHierarchyItemCopyWith<$Res> {
  __$TypeHierarchyItemCopyWithImpl(this._self, this._then);

  final _TypeHierarchyItem _self;
  final $Res Function(_TypeHierarchyItem) _then;

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeIdentifier = null,
    Object? baseTypeIdentifiers = null,
  }) {
    return _then(_self.copyWith(
      typeIdentifier: null == typeIdentifier
          ? _self.typeIdentifier
          : typeIdentifier // ignore: cast_nullable_to_non_nullable
              as TypeIdentifier,
      baseTypeIdentifiers: null == baseTypeIdentifiers
          ? _self.baseTypeIdentifiers
          : baseTypeIdentifiers // ignore: cast_nullable_to_non_nullable
              as Set<TypeIdentifier>,
    ));
  }

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TypeIdentifierCopyWith<$Res> get typeIdentifier {
    return $TypeIdentifierCopyWith<$Res>(_self.typeIdentifier, (value) {
      return _then(_self.copyWith(typeIdentifier: value));
    });
  }
}

/// Adds pattern-matching-related methods to [_TypeHierarchyItem].
extension _TypeHierarchyItemPatterns on _TypeHierarchyItem {
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
    TResult Function(__TypeHierarchyItem value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __TypeHierarchyItem() when $default != null:
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
    TResult Function(__TypeHierarchyItem value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case __TypeHierarchyItem():
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
    TResult? Function(__TypeHierarchyItem value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case __TypeHierarchyItem() when $default != null:
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
    TResult Function(TypeIdentifier typeIdentifier,
            Set<TypeIdentifier> baseTypeIdentifiers)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case __TypeHierarchyItem() when $default != null:
        return $default(_that.typeIdentifier, _that.baseTypeIdentifiers);
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
    TResult Function(TypeIdentifier typeIdentifier,
            Set<TypeIdentifier> baseTypeIdentifiers)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case __TypeHierarchyItem():
        return $default(_that.typeIdentifier, _that.baseTypeIdentifiers);
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
    TResult? Function(TypeIdentifier typeIdentifier,
            Set<TypeIdentifier> baseTypeIdentifiers)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case __TypeHierarchyItem() when $default != null:
        return $default(_that.typeIdentifier, _that.baseTypeIdentifiers);
      case _:
        return null;
    }
  }
}

/// @nodoc

class __TypeHierarchyItem extends _TypeHierarchyItem {
  const __TypeHierarchyItem(
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

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$_TypeHierarchyItemCopyWith<__TypeHierarchyItem> get copyWith =>
      __$_TypeHierarchyItemCopyWithImpl<__TypeHierarchyItem>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is __TypeHierarchyItem &&
            (identical(other.typeIdentifier, typeIdentifier) ||
                other.typeIdentifier == typeIdentifier) &&
            const DeepCollectionEquality()
                .equals(other._baseTypeIdentifiers, _baseTypeIdentifiers));
  }

  @override
  int get hashCode => Object.hash(runtimeType, typeIdentifier,
      const DeepCollectionEquality().hash(_baseTypeIdentifiers));
}

/// @nodoc
abstract mixin class _$_TypeHierarchyItemCopyWith<$Res>
    implements _$TypeHierarchyItemCopyWith<$Res> {
  factory _$_TypeHierarchyItemCopyWith(
          __TypeHierarchyItem value, $Res Function(__TypeHierarchyItem) _then) =
      __$_TypeHierarchyItemCopyWithImpl;
  @override
  @useResult
  $Res call(
      {TypeIdentifier typeIdentifier, Set<TypeIdentifier> baseTypeIdentifiers});

  @override
  $TypeIdentifierCopyWith<$Res> get typeIdentifier;
}

/// @nodoc
class __$_TypeHierarchyItemCopyWithImpl<$Res>
    implements _$_TypeHierarchyItemCopyWith<$Res> {
  __$_TypeHierarchyItemCopyWithImpl(this._self, this._then);

  final __TypeHierarchyItem _self;
  final $Res Function(__TypeHierarchyItem) _then;

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? typeIdentifier = null,
    Object? baseTypeIdentifiers = null,
  }) {
    return _then(__TypeHierarchyItem(
      typeIdentifier: null == typeIdentifier
          ? _self.typeIdentifier
          : typeIdentifier // ignore: cast_nullable_to_non_nullable
              as TypeIdentifier,
      baseTypeIdentifiers: null == baseTypeIdentifiers
          ? _self._baseTypeIdentifiers
          : baseTypeIdentifiers // ignore: cast_nullable_to_non_nullable
              as Set<TypeIdentifier>,
    ));
  }

  /// Create a copy of _TypeHierarchyItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TypeIdentifierCopyWith<$Res> get typeIdentifier {
    return $TypeIdentifierCopyWith<$Res>(_self.typeIdentifier, (value) {
      return _then(_self.copyWith(typeIdentifier: value));
    });
  }
}

// dart format on
