// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interface_declaration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$InterfaceDeclaration {
  /// name of this interface
  String get name => throw _privateConstructorUsedError;

  /// whether this interface is deprecated
  bool get isDeprecated => throw _privateConstructorUsedError;

  /// whether this interface is experimental
  bool get isExperimental => throw _privateConstructorUsedError;

  /// determines if this declaration is sealed
  bool get isSealed => throw _privateConstructorUsedError;

  /// determines if this declaration is abstract
  bool get isAbstract => throw _privateConstructorUsedError;

  /// usages of this interface
  Set<TypeUsage> get typeUsages => throw _privateConstructorUsedError;

  /// list of type parameter names
  List<String> get typeParameterNames => throw _privateConstructorUsedError;

  /// set of super type names
  Set<String> get superTypeNames => throw _privateConstructorUsedError;

  /// executables that belong to this interface
  List<ExecutableDeclaration> get executableDeclarations =>
      throw _privateConstructorUsedError;

  /// fields that belong to this interface
  List<FieldDeclaration> get fieldDeclarations =>
      throw _privateConstructorUsedError;

  /// entry points this interface is reachable through
  Set<String>? get entryPoints => throw _privateConstructorUsedError;

  /// the relative path of the library
  String get relativePath => throw _privateConstructorUsedError;

  /// Create a copy of InterfaceDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InterfaceDeclarationCopyWith<InterfaceDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InterfaceDeclarationCopyWith<$Res> {
  factory $InterfaceDeclarationCopyWith(InterfaceDeclaration value,
          $Res Function(InterfaceDeclaration) then) =
      _$InterfaceDeclarationCopyWithImpl<$Res, InterfaceDeclaration>;
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
class _$InterfaceDeclarationCopyWithImpl<$Res,
        $Val extends InterfaceDeclaration>
    implements $InterfaceDeclarationCopyWith<$Res> {
  _$InterfaceDeclarationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isExperimental: null == isExperimental
          ? _value.isExperimental
          : isExperimental // ignore: cast_nullable_to_non_nullable
              as bool,
      isSealed: null == isSealed
          ? _value.isSealed
          : isSealed // ignore: cast_nullable_to_non_nullable
              as bool,
      isAbstract: null == isAbstract
          ? _value.isAbstract
          : isAbstract // ignore: cast_nullable_to_non_nullable
              as bool,
      typeUsages: null == typeUsages
          ? _value.typeUsages
          : typeUsages // ignore: cast_nullable_to_non_nullable
              as Set<TypeUsage>,
      typeParameterNames: null == typeParameterNames
          ? _value.typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      superTypeNames: null == superTypeNames
          ? _value.superTypeNames
          : superTypeNames // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      executableDeclarations: null == executableDeclarations
          ? _value.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: null == fieldDeclarations
          ? _value.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
      entryPoints: freezed == entryPoints
          ? _value.entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      relativePath: null == relativePath
          ? _value.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InterfaceDeclarationImplCopyWith<$Res>
    implements $InterfaceDeclarationCopyWith<$Res> {
  factory _$$InterfaceDeclarationImplCopyWith(_$InterfaceDeclarationImpl value,
          $Res Function(_$InterfaceDeclarationImpl) then) =
      __$$InterfaceDeclarationImplCopyWithImpl<$Res>;
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
class __$$InterfaceDeclarationImplCopyWithImpl<$Res>
    extends _$InterfaceDeclarationCopyWithImpl<$Res, _$InterfaceDeclarationImpl>
    implements _$$InterfaceDeclarationImplCopyWith<$Res> {
  __$$InterfaceDeclarationImplCopyWithImpl(_$InterfaceDeclarationImpl _value,
      $Res Function(_$InterfaceDeclarationImpl) _then)
      : super(_value, _then);

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
    return _then(_$InterfaceDeclarationImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDeprecated: null == isDeprecated
          ? _value.isDeprecated
          : isDeprecated // ignore: cast_nullable_to_non_nullable
              as bool,
      isExperimental: null == isExperimental
          ? _value.isExperimental
          : isExperimental // ignore: cast_nullable_to_non_nullable
              as bool,
      isSealed: null == isSealed
          ? _value.isSealed
          : isSealed // ignore: cast_nullable_to_non_nullable
              as bool,
      isAbstract: null == isAbstract
          ? _value.isAbstract
          : isAbstract // ignore: cast_nullable_to_non_nullable
              as bool,
      typeUsages: null == typeUsages
          ? _value._typeUsages
          : typeUsages // ignore: cast_nullable_to_non_nullable
              as Set<TypeUsage>,
      typeParameterNames: null == typeParameterNames
          ? _value._typeParameterNames
          : typeParameterNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      superTypeNames: null == superTypeNames
          ? _value._superTypeNames
          : superTypeNames // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      executableDeclarations: null == executableDeclarations
          ? _value._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: null == fieldDeclarations
          ? _value._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
      entryPoints: freezed == entryPoints
          ? _value._entryPoints
          : entryPoints // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
      relativePath: null == relativePath
          ? _value.relativePath
          : relativePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InterfaceDeclarationImpl extends _InterfaceDeclaration {
  const _$InterfaceDeclarationImpl(
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

  @override
  String toString() {
    return 'InterfaceDeclaration(name: $name, isDeprecated: $isDeprecated, isExperimental: $isExperimental, isSealed: $isSealed, isAbstract: $isAbstract, typeUsages: $typeUsages, typeParameterNames: $typeParameterNames, superTypeNames: $superTypeNames, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, entryPoints: $entryPoints, relativePath: $relativePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InterfaceDeclarationImpl &&
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

  /// Create a copy of InterfaceDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InterfaceDeclarationImplCopyWith<_$InterfaceDeclarationImpl>
      get copyWith =>
          __$$InterfaceDeclarationImplCopyWithImpl<_$InterfaceDeclarationImpl>(
              this, _$identity);
}

abstract class _InterfaceDeclaration extends InterfaceDeclaration
    implements Declaration {
  const factory _InterfaceDeclaration(
      {required final String name,
      required final bool isDeprecated,
      required final bool isExperimental,
      required final bool isSealed,
      required final bool isAbstract,
      required final Set<TypeUsage> typeUsages,
      required final List<String> typeParameterNames,
      required final Set<String> superTypeNames,
      required final List<ExecutableDeclaration> executableDeclarations,
      required final List<FieldDeclaration> fieldDeclarations,
      final Set<String>? entryPoints,
      required final String relativePath}) = _$InterfaceDeclarationImpl;
  const _InterfaceDeclaration._() : super._();

  /// name of this interface
  @override
  String get name;

  /// whether this interface is deprecated
  @override
  bool get isDeprecated;

  /// whether this interface is experimental
  @override
  bool get isExperimental;

  /// determines if this declaration is sealed
  @override
  bool get isSealed;

  /// determines if this declaration is abstract
  @override
  bool get isAbstract;

  /// usages of this interface
  @override
  Set<TypeUsage> get typeUsages;

  /// list of type parameter names
  @override
  List<String> get typeParameterNames;

  /// set of super type names
  @override
  Set<String> get superTypeNames;

  /// executables that belong to this interface
  @override
  List<ExecutableDeclaration> get executableDeclarations;

  /// fields that belong to this interface
  @override
  List<FieldDeclaration> get fieldDeclarations;

  /// entry points this interface is reachable through
  @override
  Set<String>? get entryPoints;

  /// the relative path of the library
  @override
  String get relativePath;

  /// Create a copy of InterfaceDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InterfaceDeclarationImplCopyWith<_$InterfaceDeclarationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
