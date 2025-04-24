// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'executable_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExecutableParameterDeclaration {
  /// whether the parameter is required
  bool get isRequired;

  /// whether the parameter is named
  bool get isNamed;

  /// the name of the parameter
  String get name;

  /// whether the parameter is deprecated
  bool get isDeprecated;

  /// whether the parameter is experimental
  bool get isExperimental;

  /// type name of this parameter
  String get typeName;

  /// the type library path
  String? get typeFullLibraryName;

  /// the relative path of the library
  String get relativePath;

  /// Create a copy of ExecutableParameterDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExecutableParameterDeclarationCopyWith<ExecutableParameterDeclaration>
      get copyWith => _$ExecutableParameterDeclarationCopyWithImpl<
              ExecutableParameterDeclaration>(
          this as ExecutableParameterDeclaration, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExecutableParameterDeclaration &&
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
            (identical(other.typeFullLibraryName, typeFullLibraryName) ||
                other.typeFullLibraryName == typeFullLibraryName) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isRequired,
      isNamed,
      name,
      isDeprecated,
      isExperimental,
      typeName,
      typeFullLibraryName,
      relativePath);

  @override
  String toString() {
    return 'ExecutableParameterDeclaration(isRequired: $isRequired, isNamed: $isNamed, name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, typeName: $typeName, typeFullLibraryName: $typeFullLibraryName, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class $ExecutableParameterDeclarationCopyWith<$Res> {
  factory $ExecutableParameterDeclarationCopyWith(
          ExecutableParameterDeclaration value,
          $Res Function(ExecutableParameterDeclaration) _then) =
      _$ExecutableParameterDeclarationCopyWithImpl;
  @useResult
  $Res call(
      {bool isRequired,
      bool isNamed,
      String name,
      bool isDeprecated,
      bool isExperimental,
      String typeName,
      String? typeFullLibraryName,
      String relativePath});
}

/// @nodoc
class _$ExecutableParameterDeclarationCopyWithImpl<$Res>
    implements $ExecutableParameterDeclarationCopyWith<$Res> {
  _$ExecutableParameterDeclarationCopyWithImpl(this._self, this._then);

  final ExecutableParameterDeclaration _self;
  final $Res Function(ExecutableParameterDeclaration) _then;

  /// Create a copy of ExecutableParameterDeclaration
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
    Object? typeFullLibraryName = freezed,
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
      typeFullLibraryName: freezed == typeFullLibraryName
          ? _self.typeFullLibraryName
          : typeFullLibraryName // ignore: cast_nullable_to_non_nullable
              as String?,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _ExecutableParameterDeclaration extends ExecutableParameterDeclaration
    implements Declaration {
  const _ExecutableParameterDeclaration(
      {required this.isRequired,
      required this.isNamed,
      required this.name,
      required this.isDeprecated,
      required this.isExperimental,
      required this.typeName,
      required this.typeFullLibraryName,
      required this.relativePath})
      : super._();

  /// whether the parameter is required
  @override
  final bool isRequired;

  /// whether the parameter is named
  @override
  final bool isNamed;

  /// the name of the parameter
  @override
  final String name;

  /// whether the parameter is deprecated
  @override
  final bool isDeprecated;

  /// whether the parameter is experimental
  @override
  final bool isExperimental;

  /// type name of this parameter
  @override
  final String typeName;

  /// the type library path
  @override
  final String? typeFullLibraryName;

  /// the relative path of the library
  @override
  final String relativePath;

  /// Create a copy of ExecutableParameterDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExecutableParameterDeclarationCopyWith<_ExecutableParameterDeclaration>
      get copyWith => __$ExecutableParameterDeclarationCopyWithImpl<
          _ExecutableParameterDeclaration>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExecutableParameterDeclaration &&
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
            (identical(other.typeFullLibraryName, typeFullLibraryName) ||
                other.typeFullLibraryName == typeFullLibraryName) &&
            (identical(other.relativePath, relativePath) ||
                other.relativePath == relativePath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isRequired,
      isNamed,
      name,
      isDeprecated,
      isExperimental,
      typeName,
      typeFullLibraryName,
      relativePath);

  @override
  String toString() {
    return 'ExecutableParameterDeclaration(isRequired: $isRequired, isNamed: $isNamed, name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, typeName: $typeName, typeFullLibraryName: $typeFullLibraryName, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class _$ExecutableParameterDeclarationCopyWith<$Res>
    implements $ExecutableParameterDeclarationCopyWith<$Res> {
  factory _$ExecutableParameterDeclarationCopyWith(
          _ExecutableParameterDeclaration value,
          $Res Function(_ExecutableParameterDeclaration) _then) =
      __$ExecutableParameterDeclarationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool isRequired,
      bool isNamed,
      String name,
      bool isDeprecated,
      bool isExperimental,
      String typeName,
      String? typeFullLibraryName,
      String relativePath});
}

/// @nodoc
class __$ExecutableParameterDeclarationCopyWithImpl<$Res>
    implements _$ExecutableParameterDeclarationCopyWith<$Res> {
  __$ExecutableParameterDeclarationCopyWithImpl(this._self, this._then);

  final _ExecutableParameterDeclaration _self;
  final $Res Function(_ExecutableParameterDeclaration) _then;

  /// Create a copy of ExecutableParameterDeclaration
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
    Object? typeFullLibraryName = freezed,
    Object? relativePath = null,
  }) {
    return _then(_ExecutableParameterDeclaration(
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
      typeFullLibraryName: freezed == typeFullLibraryName
          ? _self.typeFullLibraryName
          : typeFullLibraryName // ignore: cast_nullable_to_non_nullable
              as String?,
      relativePath: null == relativePath
          ? _self.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$ExecutableDeclaration {
  /// name of the return type
  String get returnTypeName; // full library name of the return type
  String? get returnTypeFullLibraryName;

  /// name of the executable
  String get name;

  /// whether the executable is deprecated
  bool get isDeprecated;

  /// whether the executable is experimental
  bool get isExperimental;

  /// list of the executables parameters ([ExecutableOParameterDeclaration]s)
  List<ExecutableParameterDeclaration> get parameters;

  /// type parameter names of this executable
  List<String> get typeParameterNames;

  /// type of the executable
  ExecutableType get type;

  /// whether the executable is a static method
  bool get isStatic;

  /// entry points for this executable
  Set<String>? get entryPoints;

  /// the relative path of the library
  String get relativePath;

  /// Create a copy of ExecutableDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExecutableDeclarationCopyWith<ExecutableDeclaration> get copyWith =>
      _$ExecutableDeclarationCopyWithImpl<ExecutableDeclaration>(
          this as ExecutableDeclaration, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExecutableDeclaration &&
            (identical(other.returnTypeName, returnTypeName) ||
                other.returnTypeName == returnTypeName) &&
            (identical(other.returnTypeFullLibraryName,
                    returnTypeFullLibraryName) ||
                other.returnTypeFullLibraryName == returnTypeFullLibraryName) &&
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

  @override
  int get hashCode => Object.hash(
      runtimeType,
      returnTypeName,
      returnTypeFullLibraryName,
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
    return 'ExecutableDeclaration(returnTypeName: $returnTypeName, returnTypeFullLibraryName: $returnTypeFullLibraryName, name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, parameters: $parameters, typeParameterNames: $typeParameterNames, type: $type, isStatic: $isStatic, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class $ExecutableDeclarationCopyWith<$Res> {
  factory $ExecutableDeclarationCopyWith(ExecutableDeclaration value,
          $Res Function(ExecutableDeclaration) _then) =
      _$ExecutableDeclarationCopyWithImpl;
  @useResult
  $Res call(
      {String returnTypeName,
      String? returnTypeFullLibraryName,
      String name,
      bool isDeprecated,
      bool isExperimental,
      List<ExecutableParameterDeclaration> parameters,
      List<String> typeParameterNames,
      ExecutableType type,
      bool isStatic,
      Set<String>? entryPoints,
      String relativePath});
}

/// @nodoc
class _$ExecutableDeclarationCopyWithImpl<$Res>
    implements $ExecutableDeclarationCopyWith<$Res> {
  _$ExecutableDeclarationCopyWithImpl(this._self, this._then);

  final ExecutableDeclaration _self;
  final $Res Function(ExecutableDeclaration) _then;

  /// Create a copy of ExecutableDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? returnTypeName = null,
    Object? returnTypeFullLibraryName = freezed,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? parameters = null,
    Object? typeParameterNames = null,
    Object? type = null,
    Object? isStatic = null,
    Object? entryPoints = freezed,
    Object? relativePath = null,
  }) {
    return _then(_self.copyWith(
      returnTypeName: null == returnTypeName
          ? _self.returnTypeName
          : returnTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      returnTypeFullLibraryName: freezed == returnTypeFullLibraryName
          ? _self.returnTypeFullLibraryName
          : returnTypeFullLibraryName // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as List<ExecutableParameterDeclaration>,
      typeParameterNames: null == typeParameterNames
          ? _self.typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExecutableType,
      isStatic: null == isStatic
          ? _self.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
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

/// @nodoc

class _ExecutableDeclaration extends ExecutableDeclaration {
  const _ExecutableDeclaration(
      {required this.returnTypeName,
      required this.returnTypeFullLibraryName,
      required this.name,
      required this.isDeprecated,
      required this.isExperimental,
      required final List<ExecutableParameterDeclaration> parameters,
      required final List<String> typeParameterNames,
      required this.type,
      required this.isStatic,
      final Set<String>? entryPoints,
      required this.relativePath})
      : _parameters = parameters,
        _typeParameterNames = typeParameterNames,
        _entryPoints = entryPoints,
        super._();

  /// name of the return type
  @override
  final String returnTypeName;
// full library name of the return type
  @override
  final String? returnTypeFullLibraryName;

  /// name of the executable
  @override
  final String name;

  /// whether the executable is deprecated
  @override
  final bool isDeprecated;

  /// whether the executable is experimental
  @override
  final bool isExperimental;

  /// list of the executables parameters ([ExecutableOParameterDeclaration]s)
  final List<ExecutableParameterDeclaration> _parameters;

  /// list of the executables parameters ([ExecutableOParameterDeclaration]s)
  @override
  List<ExecutableParameterDeclaration> get parameters {
    if (_parameters is EqualUnmodifiableListView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parameters);
  }

  /// type parameter names of this executable
  final List<String> _typeParameterNames;

  /// type parameter names of this executable
  @override
  List<String> get typeParameterNames {
    if (_typeParameterNames is EqualUnmodifiableListView)
      return _typeParameterNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeParameterNames);
  }

  /// type of the executable
  @override
  final ExecutableType type;

  /// whether the executable is a static method
  @override
  final bool isStatic;

  /// entry points for this executable
  final Set<String>? _entryPoints;

  /// entry points for this executable
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

  /// Create a copy of ExecutableDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExecutableDeclarationCopyWith<_ExecutableDeclaration> get copyWith =>
      __$ExecutableDeclarationCopyWithImpl<_ExecutableDeclaration>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExecutableDeclaration &&
            (identical(other.returnTypeName, returnTypeName) ||
                other.returnTypeName == returnTypeName) &&
            (identical(other.returnTypeFullLibraryName,
                    returnTypeFullLibraryName) ||
                other.returnTypeFullLibraryName == returnTypeFullLibraryName) &&
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

  @override
  int get hashCode => Object.hash(
      runtimeType,
      returnTypeName,
      returnTypeFullLibraryName,
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
    return 'ExecutableDeclaration(returnTypeName: $returnTypeName, returnTypeFullLibraryName: $returnTypeFullLibraryName, name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, parameters: $parameters, typeParameterNames: $typeParameterNames, type: $type, isStatic: $isStatic, entryPoints: $entryPoints, relativePath: $relativePath)';
  }
}

/// @nodoc
abstract mixin class _$ExecutableDeclarationCopyWith<$Res>
    implements $ExecutableDeclarationCopyWith<$Res> {
  factory _$ExecutableDeclarationCopyWith(_ExecutableDeclaration value,
          $Res Function(_ExecutableDeclaration) _then) =
      __$ExecutableDeclarationCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String returnTypeName,
      String? returnTypeFullLibraryName,
      String name,
      bool isDeprecated,
      bool isExperimental,
      List<ExecutableParameterDeclaration> parameters,
      List<String> typeParameterNames,
      ExecutableType type,
      bool isStatic,
      Set<String>? entryPoints,
      String relativePath});
}

/// @nodoc
class __$ExecutableDeclarationCopyWithImpl<$Res>
    implements _$ExecutableDeclarationCopyWith<$Res> {
  __$ExecutableDeclarationCopyWithImpl(this._self, this._then);

  final _ExecutableDeclaration _self;
  final $Res Function(_ExecutableDeclaration) _then;

  /// Create a copy of ExecutableDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? returnTypeName = null,
    Object? returnTypeFullLibraryName = freezed,
    Object? name = null,
    Object? isDeprecated = null,
    Object? isExperimental = null,
    Object? parameters = null,
    Object? typeParameterNames = null,
    Object? type = null,
    Object? isStatic = null,
    Object? entryPoints = freezed,
    Object? relativePath = null,
  }) {
    return _then(_ExecutableDeclaration(
      returnTypeName: null == returnTypeName
          ? _self.returnTypeName
          : returnTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      returnTypeFullLibraryName: freezed == returnTypeFullLibraryName
          ? _self.returnTypeFullLibraryName
          : returnTypeFullLibraryName // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as List<ExecutableParameterDeclaration>,
      typeParameterNames: null == typeParameterNames
          ? _self._typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExecutableType,
      isStatic: null == isStatic
          ? _self.isStatic
          : isStatic // ignore: cast_nullable_to_non_nullable
              as bool,
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
