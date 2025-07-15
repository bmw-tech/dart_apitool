// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'executable_declaration_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExecutableParameterDeclarationStorageV3 {
  bool get isRequired;
  bool get isNamed;
  String get name;
  bool get isDeprecated;
  bool get isExperimental;
  String get typeName;
  String get relativePath;

  /// Create a copy of ExecutableParameterDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExecutableParameterDeclarationStorageV3CopyWith<
          ExecutableParameterDeclarationStorageV3>
      get copyWith => _$ExecutableParameterDeclarationStorageV3CopyWithImpl<
              ExecutableParameterDeclarationStorageV3>(
          this as ExecutableParameterDeclarationStorageV3, _$identity);

  /// Serializes this ExecutableParameterDeclarationStorageV3 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExecutableParameterDeclarationStorageV3 &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.isNamed, isNamed) || other.isNamed == isNamed) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isRequired, isNamed, name,
      isDeprecated, isExperimental, typeName, relativePath);

  @override
  String toString() {
    return 'ExecutableParameterDeclarationStorageV3(isRequired: $isRequired, isNamed: $isNamed, name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, typeName: $typeName, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class $ExecutableParameterDeclarationStorageV3CopyWith<$Res> {
  factory $ExecutableParameterDeclarationStorageV3CopyWith(
          ExecutableParameterDeclarationStorageV3 value,
          $Res Function(ExecutableParameterDeclarationStorageV3) _then) =
      _$ExecutableParameterDeclarationStorageV3CopyWithImpl;
  @useResult
  $Res call(
      {bool isRequired,
      bool isNamed,
      String name,
      bool isDeprecated,
      bool isExperimental,
      String typeName,
      String relativePath});
}

/// @nodoc
class _$ExecutableParameterDeclarationStorageV3CopyWithImpl<$Res>
    implements $ExecutableParameterDeclarationStorageV3CopyWith<$Res> {
  _$ExecutableParameterDeclarationStorageV3CopyWithImpl(this._self, this._then);

  final ExecutableParameterDeclarationStorageV3 _self;
  final $Res Function(ExecutableParameterDeclarationStorageV3) _then;

  /// Create a copy of ExecutableParameterDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRequired = null,
    Object? isNamed = null,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? typeName = null,
    Object? relativePath = null,
  }) {
    return _then(_self.copyWith(
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      isNamed: null == isNamed
          ? _self.isNamed
          : isNamed // ignore: cast_nullable_to_non_nullable
              as bool,
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
      typeName: null == typeName
          ? _self.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExecutableParameterDeclarationStorageV3].
extension ExecutableParameterDeclarationStorageV3Patterns
    on ExecutableParameterDeclarationStorageV3 {
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
    TResult Function(_ExecutableParameterDeclarationStorageV3 value)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExecutableParameterDeclarationStorageV3() when $default != null:
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
    TResult Function(_ExecutableParameterDeclarationStorageV3 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutableParameterDeclarationStorageV3():
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
    TResult? Function(_ExecutableParameterDeclarationStorageV3 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutableParameterDeclarationStorageV3() when $default != null:
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
            bool isRequired,
            bool isNamed,
            String name,
            bool isDeprecated,
            bool isExperimental,
            String typeName,
            String relativePath)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExecutableParameterDeclarationStorageV3() when $default != null:
        return $default(
            _that.isRequired,
            _that.isNamed,
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.typeName,
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
            bool isRequired,
            bool isNamed,
            String name,
            bool isDeprecated,
            bool isExperimental,
            String typeName,
            String relativePath)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutableParameterDeclarationStorageV3():
        return $default(
            _that.isRequired,
            _that.isNamed,
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.typeName,
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
            bool isRequired,
            bool isNamed,
            String name,
            bool isDeprecated,
            bool isExperimental,
            String typeName,
            String relativePath)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutableParameterDeclarationStorageV3() when $default != null:
        return $default(
            _that.isRequired,
            _that.isNamed,
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.typeName,
            _that.relativePath);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExecutableParameterDeclarationStorageV3
    extends ExecutableParameterDeclarationStorageV3 {
  const _ExecutableParameterDeclarationStorageV3(
      {required this.isRequired,
      required this.isNamed,
      required this.name,
      required this.isDeprecated,
      required this.isExperimental,
      required this.typeName,
      required this.relativePath})
      : super._();
  factory _ExecutableParameterDeclarationStorageV3.fromJson(
          Map<String, dynamic> json) =>
      _$ExecutableParameterDeclarationStorageV3FromJson(json);

  @override
  final bool isRequired;
  @override
  final bool isNamed;
  @override
  final String name;
  @override
  final bool isDeprecated;
  @override
  final bool isExperimental;
  @override
  final String typeName;
  @override
  final String relativePath;

  /// Create a copy of ExecutableParameterDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExecutableParameterDeclarationStorageV3CopyWith<
          _ExecutableParameterDeclarationStorageV3>
      get copyWith => __$ExecutableParameterDeclarationStorageV3CopyWithImpl<
          _ExecutableParameterDeclarationStorageV3>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExecutableParameterDeclarationStorageV3ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExecutableParameterDeclarationStorageV3 &&
            (identical(other.isRequired, isRequired) ||
                other.isRequired == isRequired) &&
            (identical(other.isNamed, isNamed) || other.isNamed == isNamed) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isRequired, isNamed, name,
      isDeprecated, isExperimental, typeName, relativePath);

  @override
  String toString() {
    return 'ExecutableParameterDeclarationStorageV3(isRequired: $isRequired, isNamed: $isNamed, name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, typeName: $typeName, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class _$ExecutableParameterDeclarationStorageV3CopyWith<$Res>
    implements $ExecutableParameterDeclarationStorageV3CopyWith<$Res> {
  factory _$ExecutableParameterDeclarationStorageV3CopyWith(
          _ExecutableParameterDeclarationStorageV3 value,
          $Res Function(_ExecutableParameterDeclarationStorageV3) _then) =
      __$ExecutableParameterDeclarationStorageV3CopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isRequired,
      bool isNamed,
      String name,
      bool isDeprecated,
      bool isExperimental,
      String typeName,
      String relativePath});
}

/// @nodoc
class __$ExecutableParameterDeclarationStorageV3CopyWithImpl<$Res>
    implements _$ExecutableParameterDeclarationStorageV3CopyWith<$Res> {
  __$ExecutableParameterDeclarationStorageV3CopyWithImpl(
      this._self, this._then);

  final _ExecutableParameterDeclarationStorageV3 _self;
  final $Res Function(_ExecutableParameterDeclarationStorageV3) _then;

  /// Create a copy of ExecutableParameterDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isRequired = null,
    Object? isNamed = null,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? typeName = null,
    Object? relativePath = null,
  }) {
    return _then(_ExecutableParameterDeclarationStorageV3(
      isRequired: null == isRequired
          ? _self.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      isNamed: null == isNamed
          ? _self.isNamed
          : isNamed // ignore: cast_nullable_to_non_nullable
              as bool,
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
      typeName: null == typeName
          ? _self.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ExecutableDeclarationStorageV3 {
  String get returnTypeName;
  String get name;
  bool get isDeprecated;
  bool get isExperimental;
  List<ExecutableParameterDeclarationStorageV3> get parameters;
  List<String> get typeParameterNames;
  ExecutableTypeStorageV3 get type;
  bool get isStatic;
  Set<String> get entryPoints;
  String get relativePath;

  /// Create a copy of ExecutableDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExecutableDeclarationStorageV3CopyWith<ExecutableDeclarationStorageV3>
      get copyWith => _$ExecutableDeclarationStorageV3CopyWithImpl<
              ExecutableDeclarationStorageV3>(
          this as ExecutableDeclarationStorageV3, _$identity);

  /// Serializes this ExecutableDeclarationStorageV3 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExecutableDeclarationStorageV3 &&
            (identical(other.returnTypeName, returnTypeName) ||
                other.returnTypeName == returnTypeName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            const DeepCollectionEquality()
                .equals(other.parameters, parameters) &&
            const DeepCollectionEquality()
                .equals(other.typeParameterNames, typeParameterNames) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isStatic, isStatic) ||
                other.isStatic == isStatic) &&
            const DeepCollectionEquality()
                .equals(other.entryPoints, entryPoints) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      returnTypeName,
      name,
      isDeprecated,
      isExperimental,
      const DeepCollectionEquality().hash(parameters),
      const DeepCollectionEquality().hash(typeParameterNames),
      type,
      isStatic,
      const DeepCollectionEquality().hash(entryPoints),
      relativePath);

  @override
  String toString() {
    return 'ExecutableDeclarationStorageV3(returnTypeName: $returnTypeName, name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, parameters: $parameters, typeParameterNames: $typeParameterNames, type: $type, isStatic: $isStatic, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class $ExecutableDeclarationStorageV3CopyWith<$Res> {
  factory $ExecutableDeclarationStorageV3CopyWith(
          ExecutableDeclarationStorageV3 value,
          $Res Function(ExecutableDeclarationStorageV3) _then) =
      _$ExecutableDeclarationStorageV3CopyWithImpl;
  @useResult
  $Res call(
      {String returnTypeName,
      String name,
      bool isDeprecated,
      bool isExperimental,
      List<ExecutableParameterDeclarationStorageV3> parameters,
      List<String> typeParameterNames,
      ExecutableTypeStorageV3 type,
      bool isStatic,
      Set<String> entryPoints,
      String relativePath});
}

/// @nodoc
class _$ExecutableDeclarationStorageV3CopyWithImpl<$Res>
    implements $ExecutableDeclarationStorageV3CopyWith<$Res> {
  _$ExecutableDeclarationStorageV3CopyWithImpl(this._self, this._then);

  final ExecutableDeclarationStorageV3 _self;
  final $Res Function(ExecutableDeclarationStorageV3) _then;

  /// Create a copy of ExecutableDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? returnTypeName = null,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? parameters = null,
    Object? typeParameterNames = null,
    Object? type = null,
    Object? isStatic = null,
    Object? entryPoints = null,
    Object? relativePath = null,
  }) {
    return _then(_self.copyWith(
      returnTypeName: null == returnTypeName
          ? _self.returnTypeName
          : returnTypeName // ignore: cast_nullable_to_non_nullable
              as String,
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
      parameters: null == parameters
          ? _self.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ExecutableParameterDeclarationStorageV3>,
      typeParameterNames: null == typeParameterNames
          ? _self.typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExecutableTypeStorageV3,
      isStatic: null == isStatic
          ? _self.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
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

/// Adds pattern-matching-related methods to [ExecutableDeclarationStorageV3].
extension ExecutableDeclarationStorageV3Patterns
    on ExecutableDeclarationStorageV3 {
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
    TResult Function(_ExecutableDeclarationStorageV3 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExecutableDeclarationStorageV3() when $default != null:
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
    TResult Function(_ExecutableDeclarationStorageV3 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutableDeclarationStorageV3():
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
    TResult? Function(_ExecutableDeclarationStorageV3 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutableDeclarationStorageV3() when $default != null:
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
            String returnTypeName,
            String name,
            bool isDeprecated,
            bool isExperimental,
            List<ExecutableParameterDeclarationStorageV3> parameters,
            List<String> typeParameterNames,
            ExecutableTypeStorageV3 type,
            bool isStatic,
            Set<String> entryPoints,
            String relativePath)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExecutableDeclarationStorageV3() when $default != null:
        return $default(
            _that.returnTypeName,
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.parameters,
            _that.typeParameterNames,
            _that.type,
            _that.isStatic,
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
            String returnTypeName,
            String name,
            bool isDeprecated,
            bool isExperimental,
            List<ExecutableParameterDeclarationStorageV3> parameters,
            List<String> typeParameterNames,
            ExecutableTypeStorageV3 type,
            bool isStatic,
            Set<String> entryPoints,
            String relativePath)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutableDeclarationStorageV3():
        return $default(
            _that.returnTypeName,
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.parameters,
            _that.typeParameterNames,
            _that.type,
            _that.isStatic,
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
            String returnTypeName,
            String name,
            bool isDeprecated,
            bool isExperimental,
            List<ExecutableParameterDeclarationStorageV3> parameters,
            List<String> typeParameterNames,
            ExecutableTypeStorageV3 type,
            bool isStatic,
            Set<String> entryPoints,
            String relativePath)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExecutableDeclarationStorageV3() when $default != null:
        return $default(
            _that.returnTypeName,
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.parameters,
            _that.typeParameterNames,
            _that.type,
            _that.isStatic,
            _that.entryPoints,
            _that.relativePath);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExecutableDeclarationStorageV3 extends ExecutableDeclarationStorageV3 {
  const _ExecutableDeclarationStorageV3(
      {required this.returnTypeName,
      required this.name,
      required this.isDeprecated,
      required this.isExperimental,
      required final List<ExecutableParameterDeclarationStorageV3> parameters,
      required final List<String> typeParameterNames,
      required this.type,
      required this.isStatic,
      required final Set<String> entryPoints,
      required this.relativePath})
      : _parameters = parameters,
        _typeParameterNames = typeParameterNames,
        _entryPoints = entryPoints,
        super._();
  factory _ExecutableDeclarationStorageV3.fromJson(Map<String, dynamic> json) =>
      _$ExecutableDeclarationStorageV3FromJson(json);

  @override
  final String returnTypeName;
  @override
  final String name;
  @override
  final bool isDeprecated;
  @override
  final bool isExperimental;
  final List<ExecutableParameterDeclarationStorageV3> _parameters;
  @override
  List<ExecutableParameterDeclarationStorageV3> get parameters {
    if (_parameters is EqualUnmodifiableListView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parameters);
  }

  final List<String> _typeParameterNames;
  @override
  List<String> get typeParameterNames {
    if (_typeParameterNames is EqualUnmodifiableListView)
      return _typeParameterNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeParameterNames);
  }

  @override
  final ExecutableTypeStorageV3 type;
  @override
  final bool isStatic;
  final Set<String> _entryPoints;
  @override
  Set<String> get entryPoints {
    if (_entryPoints is EqualUnmodifiableSetView) return _entryPoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_entryPoints);
  }

  @override
  final String relativePath;

  /// Create a copy of ExecutableDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExecutableDeclarationStorageV3CopyWith<_ExecutableDeclarationStorageV3>
      get copyWith => __$ExecutableDeclarationStorageV3CopyWithImpl<
          _ExecutableDeclarationStorageV3>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExecutableDeclarationStorageV3ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExecutableDeclarationStorageV3 &&
            (identical(other.returnTypeName, returnTypeName) ||
                other.returnTypeName == returnTypeName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            const DeepCollectionEquality()
                .equals(other._typeParameterNames, _typeParameterNames) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isStatic, isStatic) ||
                other.isStatic == isStatic) &&
            const DeepCollectionEquality()
                .equals(other._entryPoints, _entryPoints) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      returnTypeName,
      name,
      isDeprecated,
      isExperimental,
      const DeepCollectionEquality().hash(_parameters),
      const DeepCollectionEquality().hash(_typeParameterNames),
      type,
      isStatic,
      const DeepCollectionEquality().hash(_entryPoints),
      relativePath);

  @override
  String toString() {
    return 'ExecutableDeclarationStorageV3(returnTypeName: $returnTypeName, name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, parameters: $parameters, typeParameterNames: $typeParameterNames, type: $type, isStatic: $isStatic, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class _$ExecutableDeclarationStorageV3CopyWith<$Res>
    implements $ExecutableDeclarationStorageV3CopyWith<$Res> {
  factory _$ExecutableDeclarationStorageV3CopyWith(
          _ExecutableDeclarationStorageV3 value,
          $Res Function(_ExecutableDeclarationStorageV3) _then) =
      __$ExecutableDeclarationStorageV3CopyWithImpl;
  @override
  @useResult
  $Res call(
      {String returnTypeName,
      String name,
      bool isDeprecated,
      bool isExperimental,
      List<ExecutableParameterDeclarationStorageV3> parameters,
      List<String> typeParameterNames,
      ExecutableTypeStorageV3 type,
      bool isStatic,
      Set<String> entryPoints,
      String relativePath});
}

/// @nodoc
class __$ExecutableDeclarationStorageV3CopyWithImpl<$Res>
    implements _$ExecutableDeclarationStorageV3CopyWith<$Res> {
  __$ExecutableDeclarationStorageV3CopyWithImpl(this._self, this._then);

  final _ExecutableDeclarationStorageV3 _self;
  final $Res Function(_ExecutableDeclarationStorageV3) _then;

  /// Create a copy of ExecutableDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? returnTypeName = null,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? parameters = null,
    Object? typeParameterNames = null,
    Object? type = null,
    Object? isStatic = null,
    Object? entryPoints = null,
    Object? relativePath = null,
  }) {
    return _then(_ExecutableDeclarationStorageV3(
      returnTypeName: null == returnTypeName
          ? _self.returnTypeName
          : returnTypeName // ignore: cast_nullable_to_non_nullable
              as String,
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
      parameters: null == parameters
          ? _self._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ExecutableParameterDeclarationStorageV3>,
      typeParameterNames: null == typeParameterNames
          ? _self._typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExecutableTypeStorageV3,
      isStatic: null == isStatic
          ? _self.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
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
