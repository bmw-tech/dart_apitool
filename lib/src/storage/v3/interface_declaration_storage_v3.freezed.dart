// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interface_declaration_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InterfaceDeclarationStorageV3 {
  String get name;
  bool get isDeprecated;
  bool get isExperimental;
  bool get isSealed;
  bool get isRequired;
  List<String> get typeParameterNames;
  List<String> get superTypeNames;
  List<ExecutableDeclarationStorageV3> get executableDeclarations;
  List<FieldDeclarationStorageV3> get fieldDeclarations;
  Set<String> get entryPoints;
  String get relativePath;

  /// Create a copy of InterfaceDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $InterfaceDeclarationStorageV3CopyWith<InterfaceDeclarationStorageV3>
      get copyWith => _$InterfaceDeclarationStorageV3CopyWithImpl<
              InterfaceDeclarationStorageV3>(
          this as InterfaceDeclarationStorageV3, _$identity);

  /// Serializes this InterfaceDeclarationStorageV3 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is InterfaceDeclarationStorageV3 &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            (identical(other.isSealed, isSealed) ||
                other.isSealed == isSealed) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      isDeprecated,
      isExperimental,
      isSealed,
      isRequired,
      const DeepCollectionEquality().hash(typeParameterNames),
      const DeepCollectionEquality().hash(superTypeNames),
      const DeepCollectionEquality().hash(executableDeclarations),
      const DeepCollectionEquality().hash(fieldDeclarations),
      const DeepCollectionEquality().hash(entryPoints),
      relativePath);

  @override
  String toString() {
    return 'InterfaceDeclarationStorageV3(name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, isSealed: $isSealed, isRequired: $isRequired, typeParameterNames: $typeParameterNames, superTypeNames: $superTypeNames, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class $InterfaceDeclarationStorageV3CopyWith<$Res> {
  factory $InterfaceDeclarationStorageV3CopyWith(
          InterfaceDeclarationStorageV3 value,
          $Res Function(InterfaceDeclarationStorageV3) _then) =
      _$InterfaceDeclarationStorageV3CopyWithImpl;
  @useResult
  $Res call(
      {String name,
      bool isDeprecated,
      bool isExperimental,
      bool isSealed,
      bool isRequired,
      List<String> typeParameterNames,
      List<String> superTypeNames,
      List<ExecutableDeclarationStorageV3> executableDeclarations,
      List<FieldDeclarationStorageV3> fieldDeclarations,
      Set<String> entryPoints,
      String relativePath});
}

/// @nodoc
class _$InterfaceDeclarationStorageV3CopyWithImpl<$Res>
    implements $InterfaceDeclarationStorageV3CopyWith<$Res> {
  _$InterfaceDeclarationStorageV3CopyWithImpl(this._self, this._then);

  final InterfaceDeclarationStorageV3 _self;
  final $Res Function(InterfaceDeclarationStorageV3) _then;

  /// Create a copy of InterfaceDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? isSealed = null,
    Object? isRequired = null,
    Object? typeParameterNames = null,
    Object? superTypeNames = null,
    Object? executableDeclarations = null,
    Object? fieldDeclarations = null,
    Object? entryPoints = null,
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
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      typeParameterNames: null == typeParameterNames
          ? _self.typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      superTypeNames: null == superTypeNames
          ? _self.superTypeNames
          : superTypeNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      executableDeclarations: null == executableDeclarations
          ? _self.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclarationStorageV3>,
      fieldDeclarations: null == fieldDeclarations
          ? _self.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclarationStorageV3>,
      entryPoints: null == entryPoints
          ? _self.entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [InterfaceDeclarationStorageV3].
extension InterfaceDeclarationStorageV3Patterns
    on InterfaceDeclarationStorageV3 {
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
    TResult Function(_InterfaceDeclarationStorageV3 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclarationStorageV3() when $default != null:
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
    TResult Function(_InterfaceDeclarationStorageV3 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclarationStorageV3():
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
    TResult? Function(_InterfaceDeclarationStorageV3 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclarationStorageV3() when $default != null:
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
            bool isRequired,
            List<String> typeParameterNames,
            List<String> superTypeNames,
            List<ExecutableDeclarationStorageV3> executableDeclarations,
            List<FieldDeclarationStorageV3> fieldDeclarations,
            Set<String> entryPoints,
            String relativePath)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclarationStorageV3() when $default != null:
        return $default(
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.isSealed,
            _that.isRequired,
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
            bool isRequired,
            List<String> typeParameterNames,
            List<String> superTypeNames,
            List<ExecutableDeclarationStorageV3> executableDeclarations,
            List<FieldDeclarationStorageV3> fieldDeclarations,
            Set<String> entryPoints,
            String relativePath)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclarationStorageV3():
        return $default(
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.isSealed,
            _that.isRequired,
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
            bool isRequired,
            List<String> typeParameterNames,
            List<String> superTypeNames,
            List<ExecutableDeclarationStorageV3> executableDeclarations,
            List<FieldDeclarationStorageV3> fieldDeclarations,
            Set<String> entryPoints,
            String relativePath)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _InterfaceDeclarationStorageV3() when $default != null:
        return $default(
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.isSealed,
            _that.isRequired,
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
@JsonSerializable()
class _InterfaceDeclarationStorageV3 extends InterfaceDeclarationStorageV3 {
  const _InterfaceDeclarationStorageV3(
      {required this.name,
      required this.isDeprecated,
      required this.isExperimental,
      required this.isSealed,
      required this.isRequired,
      required final List<String> typeParameterNames,
      required final List<String> superTypeNames,
      required final List<ExecutableDeclarationStorageV3>
          executableDeclarations,
      required final List<FieldDeclarationStorageV3> fieldDeclarations,
      required final Set<String> entryPoints,
      required this.relativePath})
      : _typeParameterNames = typeParameterNames,
        _superTypeNames = superTypeNames,
        _executableDeclarations = executableDeclarations,
        _fieldDeclarations = fieldDeclarations,
        _entryPoints = entryPoints,
        super._();
  factory _InterfaceDeclarationStorageV3.fromJson(Map<String, dynamic> json) =>
      _$InterfaceDeclarationStorageV3FromJson(json);

  @override
  final String name;
  @override
  final bool isDeprecated;
  @override
  final bool isExperimental;
  @override
  final bool isSealed;
  @override
  final bool isRequired;
  final List<String> _typeParameterNames;
  @override
  List<String> get typeParameterNames {
    if (_typeParameterNames is EqualUnmodifiableListView)
      return _typeParameterNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeParameterNames);
  }

  final List<String> _superTypeNames;
  @override
  List<String> get superTypeNames {
    if (_superTypeNames is EqualUnmodifiableListView) return _superTypeNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_superTypeNames);
  }

  final List<ExecutableDeclarationStorageV3> _executableDeclarations;
  @override
  List<ExecutableDeclarationStorageV3> get executableDeclarations {
    if (_executableDeclarations is EqualUnmodifiableListView)
      return _executableDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_executableDeclarations);
  }

  final List<FieldDeclarationStorageV3> _fieldDeclarations;
  @override
  List<FieldDeclarationStorageV3> get fieldDeclarations {
    if (_fieldDeclarations is EqualUnmodifiableListView)
      return _fieldDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fieldDeclarations);
  }

  final Set<String> _entryPoints;
  @override
  Set<String> get entryPoints {
    if (_entryPoints is EqualUnmodifiableSetView) return _entryPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_entryPoints);
  }

  @override
  final String relativePath;

  /// Create a copy of InterfaceDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$InterfaceDeclarationStorageV3CopyWith<_InterfaceDeclarationStorageV3>
      get copyWith => __$InterfaceDeclarationStorageV3CopyWithImpl<
          _InterfaceDeclarationStorageV3>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$InterfaceDeclarationStorageV3ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _InterfaceDeclarationStorageV3 &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            (identical(other.isSealed, isSealed) ||
                other.isSealed == isSealed) &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      isDeprecated,
      isExperimental,
      isSealed,
      isRequired,
      const DeepCollectionEquality().hash(_typeParameterNames),
      const DeepCollectionEquality().hash(_superTypeNames),
      const DeepCollectionEquality().hash(_executableDeclarations),
      const DeepCollectionEquality().hash(_fieldDeclarations),
      const DeepCollectionEquality().hash(_entryPoints),
      relativePath);

  @override
  String toString() {
    return 'InterfaceDeclarationStorageV3(name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, isSealed: $isSealed, isRequired: $isRequired, typeParameterNames: $typeParameterNames, superTypeNames: $superTypeNames, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class _$InterfaceDeclarationStorageV3CopyWith<$Res>
    implements $InterfaceDeclarationStorageV3CopyWith<$Res> {
  factory _$InterfaceDeclarationStorageV3CopyWith(
          _InterfaceDeclarationStorageV3 value,
          $Res Function(_InterfaceDeclarationStorageV3) _then) =
      __$InterfaceDeclarationStorageV3CopyWithImpl;
  @override
  @useResult
  $Res call(
      {String name,
      bool isDeprecated,
      bool isExperimental,
      bool isSealed,
      bool isRequired,
      List<String> typeParameterNames,
      List<String> superTypeNames,
      List<ExecutableDeclarationStorageV3> executableDeclarations,
      List<FieldDeclarationStorageV3> fieldDeclarations,
      Set<String> entryPoints,
      String relativePath});
}

/// @nodoc
class __$InterfaceDeclarationStorageV3CopyWithImpl<$Res>
    implements _$InterfaceDeclarationStorageV3CopyWith<$Res> {
  __$InterfaceDeclarationStorageV3CopyWithImpl(this._self, this._then);

  final _InterfaceDeclarationStorageV3 _self;
  final $Res Function(_InterfaceDeclarationStorageV3) _then;

  /// Create a copy of InterfaceDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? isSealed = null,
    Object? isRequired = null,
    Object? typeParameterNames = null,
    Object? superTypeNames = null,
    Object? executableDeclarations = null,
    Object? fieldDeclarations = null,
    Object? entryPoints = null,
    Object? relativePath = null,
  }) {
    return _then(_InterfaceDeclarationStorageV3(
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
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      typeParameterNames: null == typeParameterNames
          ? _self._typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      superTypeNames: null == superTypeNames
          ? _self._superTypeNames
          : superTypeNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      executableDeclarations: null == executableDeclarations
          ? _self._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclarationStorageV3>,
      fieldDeclarations: null == fieldDeclarations
          ? _self._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclarationStorageV3>,
      entryPoints: null == entryPoints
          ? _self._entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
