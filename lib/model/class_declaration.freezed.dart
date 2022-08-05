// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'class_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClassDeclaration _$ClassDeclarationFromJson(Map<String, dynamic> json) {
  return _ClassDeclaration.fromJson(json);
}

/// @nodoc
mixin _$ClassDeclaration {
  String get name => throw _privateConstructorUsedError;
  bool get isDeprecated => throw _privateConstructorUsedError;
  List<String> get typeParameterNames => throw _privateConstructorUsedError;
  List<String> get superTypeNames => throw _privateConstructorUsedError;
  List<ExecutableDeclaration> get executableDeclarations =>
      throw _privateConstructorUsedError;
  List<FieldDeclaration> get fieldDeclarations =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClassDeclarationCopyWith<ClassDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassDeclarationCopyWith<$Res> {
  factory $ClassDeclarationCopyWith(
          ClassDeclaration value, $Res Function(ClassDeclaration) then) =
      _$ClassDeclarationCopyWithImpl<$Res>;
  $Res call(
      {String name,
      bool isDeprecated,
      List<String> typeParameterNames,
      List<String> superTypeNames,
      List<ExecutableDeclaration> executableDeclarations,
      List<FieldDeclaration> fieldDeclarations});
}

/// @nodoc
class _$ClassDeclarationCopyWithImpl<$Res>
    implements $ClassDeclarationCopyWith<$Res> {
  _$ClassDeclarationCopyWithImpl(this._value, this._then);

  final ClassDeclaration _value;
  // ignore: unused_field
  final $Res Function(ClassDeclaration) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? isDeprecated = freezed,
    Object? typeParameterNames = freezed,
    Object? superTypeNames = freezed,
    Object? executableDeclarations = freezed,
    Object? fieldDeclarations = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      typeParameterNames: typeParameterNames == freezed
          ? _value.typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      superTypeNames: superTypeNames == freezed
          ? _value.superTypeNames
          : superTypeNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      executableDeclarations: executableDeclarations == freezed
          ? _value.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: fieldDeclarations == freezed
          ? _value.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
    ));
  }
}

/// @nodoc
abstract class _$$_ClassDeclarationCopyWith<$Res>
    implements $ClassDeclarationCopyWith<$Res> {
  factory _$$_ClassDeclarationCopyWith(
          _$_ClassDeclaration value, $Res Function(_$_ClassDeclaration) then) =
      __$$_ClassDeclarationCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      bool isDeprecated,
      List<String> typeParameterNames,
      List<String> superTypeNames,
      List<ExecutableDeclaration> executableDeclarations,
      List<FieldDeclaration> fieldDeclarations});
}

/// @nodoc
class __$$_ClassDeclarationCopyWithImpl<$Res>
    extends _$ClassDeclarationCopyWithImpl<$Res>
    implements _$$_ClassDeclarationCopyWith<$Res> {
  __$$_ClassDeclarationCopyWithImpl(
      _$_ClassDeclaration _value, $Res Function(_$_ClassDeclaration) _then)
      : super(_value, (v) => _then(v as _$_ClassDeclaration));

  @override
  _$_ClassDeclaration get _value => super._value as _$_ClassDeclaration;

  @override
  $Res call({
    Object? name = freezed,
    Object? isDeprecated = freezed,
    Object? typeParameterNames = freezed,
    Object? superTypeNames = freezed,
    Object? executableDeclarations = freezed,
    Object? fieldDeclarations = freezed,
  }) {
    return _then(_$_ClassDeclaration(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: isDeprecated == freezed
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      typeParameterNames: typeParameterNames == freezed
          ? _value._typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      superTypeNames: superTypeNames == freezed
          ? _value._superTypeNames
          : superTypeNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      executableDeclarations: executableDeclarations == freezed
          ? _value._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: fieldDeclarations == freezed
          ? _value._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClassDeclaration extends _ClassDeclaration {
  const _$_ClassDeclaration(
      {required this.name,
      required this.isDeprecated,
      required final List<String> typeParameterNames,
      required final List<String> superTypeNames,
      required final List<ExecutableDeclaration> executableDeclarations,
      required final List<FieldDeclaration> fieldDeclarations})
      : _typeParameterNames = typeParameterNames,
        _superTypeNames = superTypeNames,
        _executableDeclarations = executableDeclarations,
        _fieldDeclarations = fieldDeclarations,
        super._();

  factory _$_ClassDeclaration.fromJson(Map<String, dynamic> json) =>
      _$$_ClassDeclarationFromJson(json);

  @override
  final String name;
  @override
  final bool isDeprecated;
  final List<String> _typeParameterNames;
  @override
  List<String> get typeParameterNames {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeParameterNames);
  }

  final List<String> _superTypeNames;
  @override
  List<String> get superTypeNames {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_superTypeNames);
  }

  final List<ExecutableDeclaration> _executableDeclarations;
  @override
  List<ExecutableDeclaration> get executableDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_executableDeclarations);
  }

  final List<FieldDeclaration> _fieldDeclarations;
  @override
  List<FieldDeclaration> get fieldDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fieldDeclarations);
  }

  @override
  String toString() {
    return 'ClassDeclaration(name: $name, isDeprecated: $isDeprecated, typeParameterNames: $typeParameterNames, superTypeNames: $superTypeNames, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClassDeclaration &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.isDeprecated, isDeprecated) &&
            const DeepCollectionEquality()
                .equals(other._typeParameterNames, _typeParameterNames) &&
            const DeepCollectionEquality()
                .equals(other._superTypeNames, _superTypeNames) &&
            const DeepCollectionEquality().equals(
                other._executableDeclarations, _executableDeclarations) &&
            const DeepCollectionEquality()
                .equals(other._fieldDeclarations, _fieldDeclarations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(isDeprecated),
      const DeepCollectionEquality().hash(_typeParameterNames),
      const DeepCollectionEquality().hash(_superTypeNames),
      const DeepCollectionEquality().hash(_executableDeclarations),
      const DeepCollectionEquality().hash(_fieldDeclarations));

  @JsonKey(ignore: true)
  @override
  _$$_ClassDeclarationCopyWith<_$_ClassDeclaration> get copyWith =>
      __$$_ClassDeclarationCopyWithImpl<_$_ClassDeclaration>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClassDeclarationToJson(
      this,
    );
  }
}

abstract class _ClassDeclaration extends ClassDeclaration
    implements Declaration {
  const factory _ClassDeclaration(
          {required final String name,
          required final bool isDeprecated,
          required final List<String> typeParameterNames,
          required final List<String> superTypeNames,
          required final List<ExecutableDeclaration> executableDeclarations,
          required final List<FieldDeclaration> fieldDeclarations}) =
      _$_ClassDeclaration;
  const _ClassDeclaration._() : super._();

  factory _ClassDeclaration.fromJson(Map<String, dynamic> json) =
      _$_ClassDeclaration.fromJson;

  @override
  String get name;
  @override
  bool get isDeprecated;
  @override
  List<String> get typeParameterNames;
  @override
  List<String> get superTypeNames;
  @override
  List<ExecutableDeclaration> get executableDeclarations;
  @override
  List<FieldDeclaration> get fieldDeclarations;
  @override
  @JsonKey(ignore: true)
  _$$_ClassDeclarationCopyWith<_$_ClassDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}
