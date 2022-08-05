// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'executable_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExecutablParameterDeclaration _$ExecutablParameterDeclarationFromJson(
    Map<String, dynamic> json) {
  return _ExecutablParameterDeclaration.fromJson(json);
}

/// @nodoc
mixin _$ExecutablParameterDeclaration {
  bool get isRequired => throw _privateConstructorUsedError;
  bool get isNamed => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;
  String get typeName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExecutablParameterDeclarationCopyWith<ExecutablParameterDeclaration>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExecutablParameterDeclarationCopyWith<$Res> {
  factory $ExecutablParameterDeclarationCopyWith(
          ExecutablParameterDeclaration value,
          $Res Function(ExecutablParameterDeclaration) then) =
      _$ExecutablParameterDeclarationCopyWithImpl<$Res>;
  $Res call(
      {bool isRequired,
      bool isNamed,
      String name,
      bool isDeprecated,
      String typeName});
}

/// @nodoc
class _$ExecutablParameterDeclarationCopyWithImpl<$Res>
    implements $ExecutablParameterDeclarationCopyWith<$Res> {
  _$ExecutablParameterDeclarationCopyWithImpl(this._value, this._then);

  final ExecutablParameterDeclaration _value;
  // ignore: unused_field
  final $Res Function(ExecutablParameterDeclaration) _then;

  @override
  $Res call({
    Object? isRequired = freezed,
    Object? isNamed = freezed,
    Object? name = freezed,
    Object? isDeprecated = freezed,
    Object? typeName = freezed,
  }) {
    return _then(_value.copyWith(
      isRequired: isRequired == freezed
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      isNamed: isNamed == freezed
          ? _value.isNamed
          : isNamed // ignore: cast_nullable_to_non_nullable
              as bool,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      typeName: typeName == freezed
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ExecutablParameterDeclarationCopyWith<$Res>
    implements $ExecutablParameterDeclarationCopyWith<$Res> {
  factory _$$_ExecutablParameterDeclarationCopyWith(
          _$_ExecutablParameterDeclaration value,
          $Res Function(_$_ExecutablParameterDeclaration) then) =
      __$$_ExecutablParameterDeclarationCopyWithImpl<$Res>;
  @override
  $Res call(
      {bool isRequired,
      bool isNamed,
      String name,
      bool isDeprecated,
      String typeName});
}

/// @nodoc
class __$$_ExecutablParameterDeclarationCopyWithImpl<$Res>
    extends _$ExecutablParameterDeclarationCopyWithImpl<$Res>
    implements _$$_ExecutablParameterDeclarationCopyWith<$Res> {
  __$$_ExecutablParameterDeclarationCopyWithImpl(
      _$_ExecutablParameterDeclaration _value,
      $Res Function(_$_ExecutablParameterDeclaration) _then)
      : super(_value, (v) => _then(v as _$_ExecutablParameterDeclaration));

  @override
  _$_ExecutablParameterDeclaration get _value =>
      super._value as _$_ExecutablParameterDeclaration;

  @override
  $Res call({
    Object? isRequired = freezed,
    Object? isNamed = freezed,
    Object? name = freezed,
    Object? isDeprecated = freezed,
    Object? typeName = freezed,
  }) {
    return _then(_$_ExecutablParameterDeclaration(
      isRequired: isRequired == freezed
          ? _value.isRequired
          : isRequired // ignore: cast_nullable_to_non_nullable
              as bool,
      isNamed: isNamed == freezed
          ? _value.isNamed
          : isNamed // ignore: cast_nullable_to_non_nullable
              as bool,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      typeName: typeName == freezed
          ? _value.typeName
          : typeName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExecutablParameterDeclaration extends _ExecutablParameterDeclaration {
  const _$_ExecutablParameterDeclaration(
      {required this.isRequired,
      required this.isNamed,
      required this.name,
      required this.isDeprecated,
      required this.typeName})
      : super._();

  factory _$_ExecutablParameterDeclaration.fromJson(
          Map<String, dynamic> json) =>
      _$$_ExecutablParameterDeclarationFromJson(json);

  @override
  final bool isRequired;
  @override
  final bool isNamed;
  @override
  final String name;
  @override
  final bool isDeprecated;
  @override
  final String typeName;

  @override
  String toString() {
    return 'ExecutablParameterDeclaration(isRequired: $isRequired, isNamed: $isNamed, name: $name, isDeprecated: $isDeprecated, typeName: $typeName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExecutablParameterDeclaration &&
            const DeepCollectionEquality()
                .equals(other.isRequired, isRequired) &&
            const DeepCollectionEquality().equals(other.isNamed, isNamed) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.isDeprecated, isDeprecated) &&
            const DeepCollectionEquality().equals(other.typeName, typeName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(isRequired),
      const DeepCollectionEquality().hash(isNamed),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(isDeprecated),
      const DeepCollectionEquality().hash(typeName));

  @JsonKey(ignore: true)
  @override
  _$$_ExecutablParameterDeclarationCopyWith<_$_ExecutablParameterDeclaration>
      get copyWith => __$$_ExecutablParameterDeclarationCopyWithImpl<
          _$_ExecutablParameterDeclaration>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExecutablParameterDeclarationToJson(
      this,
    );
  }
}

abstract class _ExecutablParameterDeclaration
    extends ExecutablParameterDeclaration implements Declaration {
  const factory _ExecutablParameterDeclaration(
      {required final bool isRequired,
      required final bool isNamed,
      required final String name,
      required final bool isDeprecated,
      required final String typeName}) = _$_ExecutablParameterDeclaration;
  const _ExecutablParameterDeclaration._() : super._();

  factory _ExecutablParameterDeclaration.fromJson(Map<String, dynamic> json) =
      _$_ExecutablParameterDeclaration.fromJson;

  @override
  bool get isRequired;
  @override
  bool get isNamed;
  @override
  String get name;
  @override
  bool get isDeprecated;
  @override
  String get typeName;
  @override
  @JsonKey(ignore: true)
  _$$_ExecutablParameterDeclarationCopyWith<_$_ExecutablParameterDeclaration>
      get copyWith => throw _privateConstructorUsedError;
}

ExecutableDeclaration _$ExecutableDeclarationFromJson(
    Map<String, dynamic> json) {
  return _ExecutableDeclaration.fromJson(json);
}

/// @nodoc
mixin _$ExecutableDeclaration {
  String get returnTypeName => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;
  List<ExecutablParameterDeclaration> get parameters =>
      throw _privateConstructorUsedError;
  List<String> get typeParameterNames => throw _privateConstructorUsedError;
  ExecutableType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExecutableDeclarationCopyWith<ExecutableDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExecutableDeclarationCopyWith<$Res> {
  factory $ExecutableDeclarationCopyWith(ExecutableDeclaration value,
          $Res Function(ExecutableDeclaration) then) =
      _$ExecutableDeclarationCopyWithImpl<$Res>;
  $Res call(
      {String returnTypeName,
      String name,
      bool isDeprecated,
      List<ExecutablParameterDeclaration> parameters,
      List<String> typeParameterNames,
      ExecutableType type});
}

/// @nodoc
class _$ExecutableDeclarationCopyWithImpl<$Res>
    implements $ExecutableDeclarationCopyWith<$Res> {
  _$ExecutableDeclarationCopyWithImpl(this._value, this._then);

  final ExecutableDeclaration _value;
  // ignore: unused_field
  final $Res Function(ExecutableDeclaration) _then;

  @override
  $Res call({
    Object? returnTypeName = freezed,
    Object? name = freezed,
    Object? isDeprecated = freezed,
    Object? parameters = freezed,
    Object? typeParameterNames = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      returnTypeName: returnTypeName == freezed
          ? _value.returnTypeName
          : returnTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      parameters: parameters == freezed
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ExecutablParameterDeclaration>,
      typeParameterNames: typeParameterNames == freezed
          ? _value.typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExecutableType,
    ));
  }
}

/// @nodoc
abstract class _$$_ExecutableDeclarationCopyWith<$Res>
    implements $ExecutableDeclarationCopyWith<$Res> {
  factory _$$_ExecutableDeclarationCopyWith(_$_ExecutableDeclaration value,
          $Res Function(_$_ExecutableDeclaration) then) =
      __$$_ExecutableDeclarationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String returnTypeName,
      String name,
      bool isDeprecated,
      List<ExecutablParameterDeclaration> parameters,
      List<String> typeParameterNames,
      ExecutableType type});
}

/// @nodoc
class __$$_ExecutableDeclarationCopyWithImpl<$Res>
    extends _$ExecutableDeclarationCopyWithImpl<$Res>
    implements _$$_ExecutableDeclarationCopyWith<$Res> {
  __$$_ExecutableDeclarationCopyWithImpl(_$_ExecutableDeclaration _value,
      $Res Function(_$_ExecutableDeclaration) _then)
      : super(_value, (v) => _then(v as _$_ExecutableDeclaration));

  @override
  _$_ExecutableDeclaration get _value =>
      super._value as _$_ExecutableDeclaration;

  @override
  $Res call({
    Object? returnTypeName = freezed,
    Object? name = freezed,
    Object? isDeprecated = freezed,
    Object? parameters = freezed,
    Object? typeParameterNames = freezed,
    Object? type = freezed,
  }) {
    return _then(_$_ExecutableDeclaration(
      returnTypeName: returnTypeName == freezed
          ? _value.returnTypeName
          : returnTypeName // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      parameters: parameters == freezed
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ExecutablParameterDeclaration>,
      typeParameterNames: typeParameterNames == freezed
          ? _value._typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ExecutableType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExecutableDeclaration extends _ExecutableDeclaration {
  const _$_ExecutableDeclaration(
      {required this.returnTypeName,
      required this.name,
      required this.isDeprecated,
      required final List<ExecutablParameterDeclaration> parameters,
      required final List<String> typeParameterNames,
      required this.type})
      : _parameters = parameters,
        _typeParameterNames = typeParameterNames,
        super._();

  factory _$_ExecutableDeclaration.fromJson(Map<String, dynamic> json) =>
      _$$_ExecutableDeclarationFromJson(json);

  @override
  final String returnTypeName;
  @override
  final String name;
  @override
  final bool isDeprecated;
  final List<ExecutablParameterDeclaration> _parameters;
  @override
  List<ExecutablParameterDeclaration> get parameters {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parameters);
  }

  final List<String> _typeParameterNames;
  @override
  List<String> get typeParameterNames {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeParameterNames);
  }

  @override
  final ExecutableType type;

  @override
  String toString() {
    return 'ExecutableDeclaration(returnTypeName: $returnTypeName, name: $name, isDeprecated: $isDeprecated, parameters: $parameters, typeParameterNames: $typeParameterNames, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExecutableDeclaration &&
            const DeepCollectionEquality()
                .equals(other.returnTypeName, returnTypeName) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.isDeprecated, isDeprecated) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            const DeepCollectionEquality()
                .equals(other._typeParameterNames, _typeParameterNames) &&
            const DeepCollectionEquality().equals(other.type, type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(returnTypeName),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(isDeprecated),
      const DeepCollectionEquality().hash(_parameters),
      const DeepCollectionEquality().hash(_typeParameterNames),
      const DeepCollectionEquality().hash(type));

  @JsonKey(ignore: true)
  @override
  _$$_ExecutableDeclarationCopyWith<_$_ExecutableDeclaration> get copyWith =>
      __$$_ExecutableDeclarationCopyWithImpl<_$_ExecutableDeclaration>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExecutableDeclarationToJson(
      this,
    );
  }
}

abstract class _ExecutableDeclaration extends ExecutableDeclaration {
  const factory _ExecutableDeclaration(
      {required final String returnTypeName,
      required final String name,
      required final bool isDeprecated,
      required final List<ExecutablParameterDeclaration> parameters,
      required final List<String> typeParameterNames,
      required final ExecutableType type}) = _$_ExecutableDeclaration;
  const _ExecutableDeclaration._() : super._();

  factory _ExecutableDeclaration.fromJson(Map<String, dynamic> json) =
      _$_ExecutableDeclaration.fromJson;

  @override
  String get returnTypeName;
  @override
  String get name;
  @override
  bool get isDeprecated;
  @override
  List<ExecutablParameterDeclaration> get parameters;
  @override
  List<String> get typeParameterNames;
  @override
  ExecutableType get type;
  @override
  @JsonKey(ignore: true)
  _$$_ExecutableDeclarationCopyWith<_$_ExecutableDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}
