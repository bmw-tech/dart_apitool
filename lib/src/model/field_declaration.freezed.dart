// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldDeclaration {
  /// type of this field
  String get typeName;

  /// full library name for the type
  String? get typeFullLibraryName;

  /// name of this field
  String get name;

  /// whether this field is deprecated
  bool get isDeprecated;

  /// whether this field is static
  bool get isStatic;

  /// whether this field is a constant
  bool get isConst;

  /// whether this field is experimental
  bool get isExperimental;

  /// entry points this field is reachable through
  Set<String>? get entryPoints;

  /// the relative path of the library
  String get relativePath;

  /// whether this field is readable
  bool get isReadable;

  /// whether this field is writeable
  bool get isWriteable;

  /// Create a copy of FieldDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FieldDeclarationCopyWith<FieldDeclaration> get copyWith =>
      _$FieldDeclarationCopyWithImpl<FieldDeclaration>(
          this as FieldDeclaration, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FieldDeclaration &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.typeFullLibraryName, typeFullLibraryName) ||
                other.typeFullLibraryName == typeFullLibraryName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isStatic, isStatic) ||
                other.isStatic == isStatic) &&
            (identical(other.isConst, isConst) || other.isConst == isConst) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            const DeepCollectionEquality()
                .equals(other.entryPoints, entryPoints) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath) &&
            (identical(other.isReadable, isReadable) ||
                other.isReadable == isReadable) &&
            (identical(other.isWriteable, isWriteable) ||
                other.isWriteable == isWriteable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      typeName,
      typeFullLibraryName,
      name,
      isDeprecated,
      isStatic,
      isConst,
      isExperimental,
      const DeepCollectionEquality().hash(entryPoints),
      relativePath,
      isReadable,
      isWriteable);

  @override
  String toString() {
    return 'FieldDeclaration(typeName: $typeName, typeFullLibraryName: $typeFullLibraryName, name: $name, isDeprecated: $isDeprecated, isStatic: $isStatic, isConst: $isConst, isExperimental: $isExperimental, entryPoints: $entryPoints, relativePath: $relativePath, isReadable: $isReadable, isWriteable: $isWriteable)';
  }
}

/// @nodoc
abstract mixin class $FieldDeclarationCopyWith<$Res> {
  factory $FieldDeclarationCopyWith(
          FieldDeclaration value, $Res Function(FieldDeclaration) _then) =
      _$FieldDeclarationCopyWithImpl;
  @useResult
  $Res call(
      {String typeName,
      String? typeFullLibraryName,
      String name,
      bool isDeprecated,
      bool isStatic,
      bool isConst,
      bool isExperimental,
      Set<String>? entryPoints,
      String relativePath,
      bool isReadable,
      bool isWriteable});
}

/// @nodoc
class _$FieldDeclarationCopyWithImpl<$Res>
    implements $FieldDeclarationCopyWith<$Res> {
  _$FieldDeclarationCopyWithImpl(this._self, this._then);

  final FieldDeclaration _self;
  final $Res Function(FieldDeclaration) _then;

  /// Create a copy of FieldDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeName = null,
    Object? typeFullLibraryName = freezed,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isStatic = null,
    Object? isConst = null,
    Object? isExperimental = null,
    Object? entryPoints = freezed,
    Object? relativePath = null,
    Object? isReadable = null,
    Object? isWriteable = null,
  }) {
    return _then(_self.copyWith(
      typeName: null == typeName
          ? _self.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      typeFullLibraryName: freezed == typeFullLibraryName
          ? _self.typeFullLibraryName
          : typeFullLibraryName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _self.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isStatic: null == isStatic
          ? _self.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
      isConst: null == isConst
          ? _self.isConst
          : isConst // ignore: cast_nullable_to_non_nullable
              as bool,
      isExperimental: null == isExperimental
          ? _self.isExperimental
          : isExperimental // ignore: cast_nullable_to_non_nullable
              as bool,
      entryPoints: freezed == entryPoints
          ? _self.entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
      isReadable: null == isReadable
          ? _self.isReadable
          : isReadable // ignore: cast_nullable_to_non_nullable
              as bool,
      isWriteable: null == isWriteable
          ? _self.isWriteable
          : isWriteable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [FieldDeclaration].
extension FieldDeclarationPatterns on FieldDeclaration {
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
    TResult Function(_FieldDeclaration value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FieldDeclaration() when $default != null:
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
    TResult Function(_FieldDeclaration value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldDeclaration():
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
    TResult? Function(_FieldDeclaration value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldDeclaration() when $default != null:
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
            String typeName,
            String? typeFullLibraryName,
            String name,
            bool isDeprecated,
            bool isStatic,
            bool isConst,
            bool isExperimental,
            Set<String>? entryPoints,
            String relativePath,
            bool isReadable,
            bool isWriteable)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FieldDeclaration() when $default != null:
        return $default(
            _that.typeName,
            _that.typeFullLibraryName,
            _that.name,
            _that.isDeprecated,
            _that.isStatic,
            _that.isConst,
            _that.isExperimental,
            _that.entryPoints,
            _that.relativePath,
            _that.isReadable,
            _that.isWriteable);
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
            String typeName,
            String? typeFullLibraryName,
            String name,
            bool isDeprecated,
            bool isStatic,
            bool isConst,
            bool isExperimental,
            Set<String>? entryPoints,
            String relativePath,
            bool isReadable,
            bool isWriteable)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldDeclaration():
        return $default(
            _that.typeName,
            _that.typeFullLibraryName,
            _that.name,
            _that.isDeprecated,
            _that.isStatic,
            _that.isConst,
            _that.isExperimental,
            _that.entryPoints,
            _that.relativePath,
            _that.isReadable,
            _that.isWriteable);
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
            String typeName,
            String? typeFullLibraryName,
            String name,
            bool isDeprecated,
            bool isStatic,
            bool isConst,
            bool isExperimental,
            Set<String>? entryPoints,
            String relativePath,
            bool isReadable,
            bool isWriteable)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldDeclaration() when $default != null:
        return $default(
            _that.typeName,
            _that.typeFullLibraryName,
            _that.name,
            _that.isDeprecated,
            _that.isStatic,
            _that.isConst,
            _that.isExperimental,
            _that.entryPoints,
            _that.relativePath,
            _that.isReadable,
            _that.isWriteable);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _FieldDeclaration extends FieldDeclaration implements Declaration {
  const _FieldDeclaration(
      {required this.typeName,
      required this.typeFullLibraryName,
      required this.name,
      required this.isDeprecated,
      required this.isStatic,
      required this.isConst,
      required this.isExperimental,
      final Set<String>? entryPoints,
      required this.relativePath,
      required this.isReadable,
      required this.isWriteable})
      : _entryPoints = entryPoints,
        super._();

  /// type of this field
  @override
  final String typeName;

  /// full library name for the type
  @override
  final String? typeFullLibraryName;

  /// name of this field
  @override
  final String name;

  /// whether this field is deprecated
  @override
  final bool isDeprecated;

  /// whether this field is static
  @override
  final bool isStatic;

  /// whether this field is a constant
  @override
  final bool isConst;

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
    if (_entryPoints is EqualUnmodifiableSetView) return _entryPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  /// the relative path of the library
  @override
  final String relativePath;

  /// whether this field is readable
  @override
  final bool isReadable;

  /// whether this field is writeable
  @override
  final bool isWriteable;

  /// Create a copy of FieldDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FieldDeclarationCopyWith<_FieldDeclaration> get copyWith =>
      __$FieldDeclarationCopyWithImpl<_FieldDeclaration>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FieldDeclaration &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.typeFullLibraryName, typeFullLibraryName) ||
                other.typeFullLibraryName == typeFullLibraryName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isStatic, isStatic) ||
                other.isStatic == isStatic) &&
            (identical(other.isConst, isConst) || other.isConst == isConst) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            const DeepCollectionEquality()
                .equals(other._entryPoints, _entryPoints) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath) &&
            (identical(other.isReadable, isReadable) ||
                other.isReadable == isReadable) &&
            (identical(other.isWriteable, isWriteable) ||
                other.isWriteable == isWriteable));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      typeName,
      typeFullLibraryName,
      name,
      isDeprecated,
      isStatic,
      isConst,
      isExperimental,
      const DeepCollectionEquality().hash(_entryPoints),
      relativePath,
      isReadable,
      isWriteable);

  @override
  String toString() {
    return 'FieldDeclaration(typeName: $typeName, typeFullLibraryName: $typeFullLibraryName, name: $name, isDeprecated: $isDeprecated, isStatic: $isStatic, isConst: $isConst, isExperimental: $isExperimental, entryPoints: $entryPoints, relativePath: $relativePath, isReadable: $isReadable, isWriteable: $isWriteable)';
  }
}

/// @nodoc
abstract mixin class _$FieldDeclarationCopyWith<$Res>
    implements $FieldDeclarationCopyWith<$Res> {
  factory _$FieldDeclarationCopyWith(
          _FieldDeclaration value, $Res Function(_FieldDeclaration) _then) =
      __$FieldDeclarationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String typeName,
      String? typeFullLibraryName,
      String name,
      bool isDeprecated,
      bool isStatic,
      bool isConst,
      bool isExperimental,
      Set<String>? entryPoints,
      String relativePath,
      bool isReadable,
      bool isWriteable});
}

/// @nodoc
class __$FieldDeclarationCopyWithImpl<$Res>
    implements _$FieldDeclarationCopyWith<$Res> {
  __$FieldDeclarationCopyWithImpl(this._self, this._then);

  final _FieldDeclaration _self;
  final $Res Function(_FieldDeclaration) _then;

  /// Create a copy of FieldDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? typeName = null,
    Object? typeFullLibraryName = freezed,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isStatic = null,
    Object? isConst = null,
    Object? isExperimental = null,
    Object? entryPoints = freezed,
    Object? relativePath = null,
    Object? isReadable = null,
    Object? isWriteable = null,
  }) {
    return _then(_FieldDeclaration(
      typeName: null == typeName
          ? _self.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      typeFullLibraryName: freezed == typeFullLibraryName
          ? _self.typeFullLibraryName
          : typeFullLibraryName // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _self.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isStatic: null == isStatic
          ? _self.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
      isConst: null == isConst
          ? _self.isConst
          : isConst // ignore: cast_nullable_to_non_nullable
              as bool,
      isExperimental: null == isExperimental
          ? _self.isExperimental
          : isExperimental // ignore: cast_nullable_to_non_nullable
              as bool,
      entryPoints: freezed == entryPoints
          ? _self._entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
      isReadable: null == isReadable
          ? _self.isReadable
          : isReadable // ignore: cast_nullable_to_non_nullable
              as bool,
      isWriteable: null == isWriteable
          ? _self.isWriteable
          : isWriteable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
