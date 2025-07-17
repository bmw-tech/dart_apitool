// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_declaration_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldDeclarationStorageV3 {
  String get typeName;
  String get name;
  bool get isDeprecated;
  bool get isExperimental;
  bool get isStatic;
  Set<String> get entryPoints;
  String get relativePath;
  bool get isReadable;
  bool get isWriteable;

  /// Create a copy of FieldDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FieldDeclarationStorageV3CopyWith<FieldDeclarationStorageV3> get copyWith =>
      _$FieldDeclarationStorageV3CopyWithImpl<FieldDeclarationStorageV3>(
          this as FieldDeclarationStorageV3, _$identity);

  /// Serializes this FieldDeclarationStorageV3 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FieldDeclarationStorageV3 &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            (identical(other.isStatic, isStatic) ||
                other.isStatic == isStatic) &&
            const DeepCollectionEquality()
                .equals(other.entryPoints, entryPoints) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath) &&
            (identical(other.isReadable, isReadable) ||
                other.isReadable == isReadable) &&
            (identical(other.isWriteable, isWriteable) ||
                other.isWriteable == isWriteable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      typeName,
      name,
      isDeprecated,
      isExperimental,
      isStatic,
      const DeepCollectionEquality().hash(entryPoints),
      relativePath,
      isReadable,
      isWriteable);

  @override
  String toString() {
    return 'FieldDeclarationStorageV3(typeName: $typeName, name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, isStatic: $isStatic, entryPoints: $entryPoints, relativePath: $relativePath, isReadable: $isReadable, isWriteable: $isWriteable)';
  }
}

/// @nodoc
abstract mixin class $FieldDeclarationStorageV3CopyWith<$Res> {
  factory $FieldDeclarationStorageV3CopyWith(FieldDeclarationStorageV3 value,
          $Res Function(FieldDeclarationStorageV3) _then) =
      _$FieldDeclarationStorageV3CopyWithImpl;
  @useResult
  $Res call(
      {String typeName,
      String name,
      bool isDeprecated,
      bool isExperimental,
      bool isStatic,
      Set<String> entryPoints,
      String relativePath,
      bool isReadable,
      bool isWriteable});
}

/// @nodoc
class _$FieldDeclarationStorageV3CopyWithImpl<$Res>
    implements $FieldDeclarationStorageV3CopyWith<$Res> {
  _$FieldDeclarationStorageV3CopyWithImpl(this._self, this._then);

  final FieldDeclarationStorageV3 _self;
  final $Res Function(FieldDeclarationStorageV3) _then;

  /// Create a copy of FieldDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? typeName = null,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? isStatic = null,
    Object? entryPoints = null,
    Object? relativePath = null,
    Object? isReadable = null,
    Object? isWriteable = null,
  }) {
    return _then(_self.copyWith(
      typeName: null == typeName
          ? _self.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
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

/// Adds pattern-matching-related methods to [FieldDeclarationStorageV3].
extension FieldDeclarationStorageV3Patterns on FieldDeclarationStorageV3 {
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
    TResult Function(_FieldDeclarationStorageV3 value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FieldDeclarationStorageV3() when $default != null:
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
    TResult Function(_FieldDeclarationStorageV3 value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldDeclarationStorageV3():
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
    TResult? Function(_FieldDeclarationStorageV3 value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldDeclarationStorageV3() when $default != null:
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
            String name,
            bool isDeprecated,
            bool isExperimental,
            bool isStatic,
            Set<String> entryPoints,
            String relativePath,
            bool isReadable,
            bool isWriteable)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _FieldDeclarationStorageV3() when $default != null:
        return $default(
            _that.typeName,
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.isStatic,
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
            String name,
            bool isDeprecated,
            bool isExperimental,
            bool isStatic,
            Set<String> entryPoints,
            String relativePath,
            bool isReadable,
            bool isWriteable)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldDeclarationStorageV3():
        return $default(
            _that.typeName,
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.isStatic,
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
            String name,
            bool isDeprecated,
            bool isExperimental,
            bool isStatic,
            Set<String> entryPoints,
            String relativePath,
            bool isReadable,
            bool isWriteable)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _FieldDeclarationStorageV3() when $default != null:
        return $default(
            _that.typeName,
            _that.name,
            _that.isDeprecated,
            _that.isExperimental,
            _that.isStatic,
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
@JsonSerializable()
class _FieldDeclarationStorageV3 extends FieldDeclarationStorageV3 {
  const _FieldDeclarationStorageV3(
      {required this.typeName,
      required this.name,
      required this.isDeprecated,
      required this.isExperimental,
      required this.isStatic,
      required final Set<String> entryPoints,
      required this.relativePath,
      required this.isReadable,
      required this.isWriteable})
      : _entryPoints = entryPoints,
        super._();
  factory _FieldDeclarationStorageV3.fromJson(Map<String, dynamic> json) =>
      _$FieldDeclarationStorageV3FromJson(json);

  @override
  final String typeName;
  @override
  final String name;
  @override
  final bool isDeprecated;
  @override
  final bool isExperimental;
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
  @override
  final bool isReadable;
  @override
  final bool isWriteable;

  /// Create a copy of FieldDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FieldDeclarationStorageV3CopyWith<_FieldDeclarationStorageV3>
      get copyWith =>
          __$FieldDeclarationStorageV3CopyWithImpl<_FieldDeclarationStorageV3>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FieldDeclarationStorageV3ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FieldDeclarationStorageV3 &&
            (identical(other.typeName, typeName) ||
                other.typeName == typeName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isDeprecated, isDeprecated) ||
                other.isDeprecated == isDeprecated) &&
            (identical(other.isExperimental, isExperimental) ||
                other.isExperimental == isExperimental) &&
            (identical(other.isStatic, isStatic) ||
                other.isStatic == isStatic) &&
            const DeepCollectionEquality()
                .equals(other._entryPoints, _entryPoints) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath) &&
            (identical(other.isReadable, isReadable) ||
                other.isReadable == isReadable) &&
            (identical(other.isWriteable, isWriteable) ||
                other.isWriteable == isWriteable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      typeName,
      name,
      isDeprecated,
      isExperimental,
      isStatic,
      const DeepCollectionEquality().hash(_entryPoints),
      relativePath,
      isReadable,
      isWriteable);

  @override
  String toString() {
    return 'FieldDeclarationStorageV3(typeName: $typeName, name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, isStatic: $isStatic, entryPoints: $entryPoints, relativePath: $relativePath, isReadable: $isReadable, isWriteable: $isWriteable)';
  }
}

/// @nodoc
abstract mixin class _$FieldDeclarationStorageV3CopyWith<$Res>
    implements $FieldDeclarationStorageV3CopyWith<$Res> {
  factory _$FieldDeclarationStorageV3CopyWith(_FieldDeclarationStorageV3 value,
          $Res Function(_FieldDeclarationStorageV3) _then) =
      __$FieldDeclarationStorageV3CopyWithImpl;
  @override
  @useResult
  $Res call(
      {String typeName,
      String name,
      bool isDeprecated,
      bool isExperimental,
      bool isStatic,
      Set<String> entryPoints,
      String relativePath,
      bool isReadable,
      bool isWriteable});
}

/// @nodoc
class __$FieldDeclarationStorageV3CopyWithImpl<$Res>
    implements _$FieldDeclarationStorageV3CopyWith<$Res> {
  __$FieldDeclarationStorageV3CopyWithImpl(this._self, this._then);

  final _FieldDeclarationStorageV3 _self;
  final $Res Function(_FieldDeclarationStorageV3) _then;

  /// Create a copy of FieldDeclarationStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? typeName = null,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? isStatic = null,
    Object? entryPoints = null,
    Object? relativePath = null,
    Object? isReadable = null,
    Object? isWriteable = null,
  }) {
    return _then(_FieldDeclarationStorageV3(
      typeName: null == typeName
          ? _self.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
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
