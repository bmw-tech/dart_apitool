// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interface_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InterfaceDeclaration {
  /// name of this interface
  String get name;

  /// whether this interface is deprecated
  bool get isDeprecated;

  /// whether this interface is experimental
  bool get isExperimental;

  /// determines if this declaration is sealed
  bool get isSealed;

  /// determines if this declaration is abstract
  bool get isAbstract;

  /// usages of this interface
  Set<TypeUsage> get typeUsages;

  /// list of type parameter names
  List<String> get typeParameterNames;

  /// set of super type names
  Set<String> get superTypeNames;

  /// executables that belong to this interface
  List<ExecutableDeclaration> get executableDeclarations;

  /// fields that belong to this interface
  List<FieldDeclaration> get fieldDeclarations;

  /// entry points this interface is reachable through
  Set<String>? get entryPoints;

  /// the relative path of the library
  String get relativePath;

  /// Create a copy of InterfaceDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InterfaceDeclarationCopyWith<InterfaceDeclaration> get copyWith =>
      _$InterfaceDeclarationCopyWithImpl<InterfaceDeclaration>(
          this as InterfaceDeclaration, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InterfaceDeclaration &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            (identical(other.isSealed, isSealed) ||
                other.isSealed == isSealed) &&
            (identical(other.isAbstract, isAbstract) ||
                other.isAbstract == isAbstract) &&
            const DeepCollectionEquality()
                .equals(other.typeUsages, typeUsages) &&
            const DeepCollectionEquality()
                .equals(other.typeParameterNames, typeParameterNames) &&
            const DeepCollectionEquality()
                .equals(other.superTypeNames, superTypeNames) &&
            const DeepCollectionEquality()
                .equals(other.executableDeclarations, executableDeclarations) &&
            const DeepCollectionEquality()
                .equals(other.fieldDeclarations, fieldDeclarations) &&
            const DeepCollectionEquality()
                .equals(other.entryPoints, entryPoints) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      isDeprecated,
      isExperimental,
      isSealed,
      isAbstract,
      const DeepCollectionEquality().hash(typeUsages),
      const DeepCollectionEquality().hash(typeParameterNames),
      const DeepCollectionEquality().hash(superTypeNames),
      const DeepCollectionEquality().hash(executableDeclarations),
      const DeepCollectionEquality().hash(fieldDeclarations),
      const DeepCollectionEquality().hash(entryPoints),
      relativePath);

  @override
  String toString() {
    return 'InterfaceDeclaration(name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, isSealed: $isSealed, isAbstract: $isAbstract, typeUsages: $typeUsages, typeParameterNames: $typeParameterNames, superTypeNames: $superTypeNames, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class $InterfaceDeclarationCopyWith<$Res> {
  factory $InterfaceDeclarationCopyWith(InterfaceDeclaration value,
          $Res Function(InterfaceDeclaration) _then) =
      _$InterfaceDeclarationCopyWithImpl;
  @useResult
  $Res call(
      {String name,
      bool isDeprecated,
      bool isExperimental,
      bool isSealed,
      bool isAbstract,
      Set<TypeUsage> typeUsages,
      List<String> typeParameterNames,
      Set<String> superTypeNames,
      List<ExecutableDeclaration> executableDeclarations,
      List<FieldDeclaration> fieldDeclarations,
      Set<String>? entryPoints,
      String relativePath});
}

/// @nodoc
class _$InterfaceDeclarationCopyWithImpl<$Res>
    implements $InterfaceDeclarationCopyWith<$Res> {
  _$InterfaceDeclarationCopyWithImpl(this._self, this._then);

  final InterfaceDeclaration _self;
  final $Res Function(InterfaceDeclaration) _then;

  /// Create a copy of InterfaceDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? isSealed = null,
    Object? isAbstract = null,
    Object? typeUsages = null,
    Object? typeParameterNames = null,
    Object? superTypeNames = null,
    Object? executableDeclarations = null,
    Object? fieldDeclarations = null,
    Object? entryPoints = freezed,
    Object? relativePath = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _self.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isExperimental: null == isExperimental
          ? _self.isExperimental
          : isExperimental // ignore: cast_nullable_to_non_nullable
              as bool,
      isSealed: null == isSealed
          ? _self.isSealed
          : isSealed // ignore: cast_nullable_to_non_nullable
              as bool,
      isAbstract: null == isAbstract
          ? _self.isAbstract
          : isAbstract // ignore: cast_nullable_to_non_nullable
              as bool,
      typeUsages: null == typeUsages
          ? _self.typeUsages
          : typeUsages // ignore: cast_nullable_to_non_nullable
              as Set<TypeUsage>,
      typeParameterNames: null == typeParameterNames
          ? _self.typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      superTypeNames: null == superTypeNames
          ? _self.superTypeNames
          : superTypeNames // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      executableDeclarations: null == executableDeclarations
          ? _self.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: null == fieldDeclarations
          ? _self.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
      entryPoints: freezed == entryPoints
          ? _self.entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [InterfaceDeclaration].
extension InterfaceDeclarationPatterns on InterfaceDeclaration {
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
    TResult Function(_InterfaceDeclaration value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclaration() when $default != null:
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
    TResult Function(_InterfaceDeclaration value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclaration():
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
    TResult? Function(_InterfaceDeclaration value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclaration() when $default != null:
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
            String name,
            bool isDeprecated,
            bool isExperimental,
            bool isSealed,
            bool isAbstract,
            Set<TypeUsage> typeUsages,
            List<String> typeParameterNames,
            Set<String> superTypeNames,
            List<ExecutableDeclaration> executableDeclarations,
            List<FieldDeclaration> fieldDeclarations,
            Set<String>? entryPoints,
            String relativePath)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclaration() when $default != null:
        return $default(
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.isSealed,
            _that.isAbstract,
            _that.typeUsages,
            _that.typeParameterNames,
            _that.superTypeNames,
            _that.executableDeclarations,
            _that.fieldDeclarations,
            _that.entryPoints,
            _that.relativePath);
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
            String name,
            bool isDeprecated,
            bool isExperimental,
            bool isSealed,
            bool isAbstract,
            Set<TypeUsage> typeUsages,
            List<String> typeParameterNames,
            Set<String> superTypeNames,
            List<ExecutableDeclaration> executableDeclarations,
            List<FieldDeclaration> fieldDeclarations,
            Set<String>? entryPoints,
            String relativePath)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclaration():
        return $default(
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.isSealed,
            _that.isAbstract,
            _that.typeUsages,
            _that.typeParameterNames,
            _that.superTypeNames,
            _that.executableDeclarations,
            _that.fieldDeclarations,
            _that.entryPoints,
            _that.relativePath);
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
            String name,
            bool isDeprecated,
            bool isExperimental,
            bool isSealed,
            bool isAbstract,
            Set<TypeUsage> typeUsages,
            List<String> typeParameterNames,
            Set<String> superTypeNames,
            List<ExecutableDeclaration> executableDeclarations,
            List<FieldDeclaration> fieldDeclarations,
            Set<String>? entryPoints,
            String relativePath)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclaration() when $default != null:
        return $default(
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.isSealed,
            _that.isAbstract,
            _that.typeUsages,
            _that.typeParameterNames,
            _that.superTypeNames,
            _that.executableDeclarations,
            _that.fieldDeclarations,
            _that.entryPoints,
            _that.relativePath);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _InterfaceDeclaration extends InterfaceDeclaration
    implements Declaration {
  const _InterfaceDeclaration(
      {required this.name,
      required this.isDeprecated,
      required this.isExperimental,
      required this.isSealed,
      required this.isAbstract,
      required final Set<TypeUsage> typeUsages,
      required final List<String> typeParameterNames,
      required final Set<String> superTypeNames,
      required final List<ExecutableDeclaration> executableDeclarations,
      required final List<FieldDeclaration> fieldDeclarations,
      final Set<String>? entryPoints,
      required this.relativePath})
      : _typeUsages = typeUsages,
        _typeParameterNames = typeParameterNames,
        _superTypeNames = superTypeNames,
        _executableDeclarations = executableDeclarations,
        _fieldDeclarations = fieldDeclarations,
        _entryPoints = entryPoints,
        super._();

  /// name of this interface
  @override
  final String name;

  /// whether this interface is deprecated
  @override
  final bool isDeprecated;

  /// whether this interface is experimental
  @override
  final bool isExperimental;

  /// determines if this declaration is sealed
  @override
  final bool isSealed;

  /// determines if this declaration is abstract
  @override
  final bool isAbstract;

  /// usages of this interface
  final Set<TypeUsage> _typeUsages;

  /// usages of this interface
  @override
  Set<TypeUsage> get typeUsages {
    if (_typeUsages is EqualUnmodifiableSetView) return _typeUsages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_typeUsages);
  }

  /// list of type parameter names
  final List<String> _typeParameterNames;

  /// list of type parameter names
  @override
  List<String> get typeParameterNames {
    if (_typeParameterNames is EqualUnmodifiableListView)
      return _typeParameterNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeParameterNames);
  }

  /// set of super type names
  final Set<String> _superTypeNames;

  /// set of super type names
  @override
  Set<String> get superTypeNames {
    if (_superTypeNames is EqualUnmodifiableSetView) return _superTypeNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_superTypeNames);
  }

  /// executables that belong to this interface
  final List<ExecutableDeclaration> _executableDeclarations;

  /// executables that belong to this interface
  @override
  List<ExecutableDeclaration> get executableDeclarations {
    if (_executableDeclarations is EqualUnmodifiableListView)
      return _executableDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_executableDeclarations);
  }

  /// fields that belong to this interface
  final List<FieldDeclaration> _fieldDeclarations;

  /// fields that belong to this interface
  @override
  List<FieldDeclaration> get fieldDeclarations {
    if (_fieldDeclarations is EqualUnmodifiableListView)
      return _fieldDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fieldDeclarations);
  }

  /// entry points this interface is reachable through
  final Set<String>? _entryPoints;

  /// entry points this interface is reachable through
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

  /// Create a copy of InterfaceDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InterfaceDeclarationCopyWith<_InterfaceDeclaration> get copyWith =>
      __$InterfaceDeclarationCopyWithImpl<_InterfaceDeclaration>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InterfaceDeclaration &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            (identical(other.isSealed, isSealed) ||
                other.isSealed == isSealed) &&
            (identical(other.isAbstract, isAbstract) ||
                other.isAbstract == isAbstract) &&
            const DeepCollectionEquality()
                .equals(other._typeUsages, _typeUsages) &&
            const DeepCollectionEquality()
                .equals(other._typeParameterNames, _typeParameterNames) &&
            const DeepCollectionEquality()
                .equals(other._superTypeNames, _superTypeNames) &&
            const DeepCollectionEquality().equals(
                other._executableDeclarations, _executableDeclarations) &&
            const DeepCollectionEquality()
                .equals(other._fieldDeclarations, _fieldDeclarations) &&
            const DeepCollectionEquality()
                .equals(other._entryPoints, _entryPoints) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      isDeprecated,
      isExperimental,
      isSealed,
      isAbstract,
      const DeepCollectionEquality().hash(_typeUsages),
      const DeepCollectionEquality().hash(_typeParameterNames),
      const DeepCollectionEquality().hash(_superTypeNames),
      const DeepCollectionEquality().hash(_executableDeclarations),
      const DeepCollectionEquality().hash(_fieldDeclarations),
      const DeepCollectionEquality().hash(_entryPoints),
      relativePath);

  @override
  String toString() {
    return 'InterfaceDeclaration(name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, isSealed: $isSealed, isAbstract: $isAbstract, typeUsages: $typeUsages, typeParameterNames: $typeParameterNames, superTypeNames: $superTypeNames, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class _$InterfaceDeclarationCopyWith<$Res>
    implements $InterfaceDeclarationCopyWith<$Res> {
  factory _$InterfaceDeclarationCopyWith(_InterfaceDeclaration value,
          $Res Function(_InterfaceDeclaration) _then) =
      __$InterfaceDeclarationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      bool isDeprecated,
      bool isExperimental,
      bool isSealed,
      bool isAbstract,
      Set<TypeUsage> typeUsages,
      List<String> typeParameterNames,
      Set<String> superTypeNames,
      List<ExecutableDeclaration> executableDeclarations,
      List<FieldDeclaration> fieldDeclarations,
      Set<String>? entryPoints,
      String relativePath});
}

/// @nodoc
class __$InterfaceDeclarationCopyWithImpl<$Res>
    implements _$InterfaceDeclarationCopyWith<$Res> {
  __$InterfaceDeclarationCopyWithImpl(this._self, this._then);

  final _InterfaceDeclaration _self;
  final $Res Function(_InterfaceDeclaration) _then;

  /// Create a copy of InterfaceDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? isSealed = null,
    Object? isAbstract = null,
    Object? typeUsages = null,
    Object? typeParameterNames = null,
    Object? superTypeNames = null,
    Object? executableDeclarations = null,
    Object? fieldDeclarations = null,
    Object? entryPoints = freezed,
    Object? relativePath = null,
  }) {
    return _then(_InterfaceDeclaration(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _self.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isExperimental: null == isExperimental
          ? _self.isExperimental
          : isExperimental // ignore: cast_nullable_to_non_nullable
              as bool,
      isSealed: null == isSealed
          ? _self.isSealed
          : isSealed // ignore: cast_nullable_to_non_nullable
              as bool,
      isAbstract: null == isAbstract
          ? _self.isAbstract
          : isAbstract // ignore: cast_nullable_to_non_nullable
              as bool,
      typeUsages: null == typeUsages
          ? _self._typeUsages
          : typeUsages // ignore: cast_nullable_to_non_nullable
              as Set<TypeUsage>,
      typeParameterNames: null == typeParameterNames
          ? _self._typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      superTypeNames: null == superTypeNames
          ? _self._superTypeNames
          : superTypeNames // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      executableDeclarations: null == executableDeclarations
          ? _self._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: null == fieldDeclarations
          ? _self._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
      entryPoints: freezed == entryPoints
          ? _self._entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
