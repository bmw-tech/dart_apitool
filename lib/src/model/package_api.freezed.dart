// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'package_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PackageApi {
  /// name of the package
  String get packageName => throw _privateConstructorUsedError;

  /// version of the package
  String? get packageVersion => throw _privateConstructorUsedError;

  /// path to the package
  String get packagePath => throw _privateConstructorUsedError;

  /// class declarations this package has
  List<ClassDeclaration> get classDeclarations =>
      throw _privateConstructorUsedError;

  /// root level executable declarations this package has
  List<ExecutableDeclaration> get executableDeclarations =>
      throw _privateConstructorUsedError;

  /// root level field declarations this package has
  List<FieldDeclaration> get fieldDeclarations =>
      throw _privateConstructorUsedError;

  /// type alias declarations this package has
  List<TypeAliasDeclaration> get typeAliasDeclarations =>
      throw _privateConstructorUsedError;

  /// the semantics of this model. This indicates if this model is compatible (e.g. for diffing) with another model
  Set<PackageApiSemantics> get semantics => throw _privateConstructorUsedError;

  /// used Android platform constraints
  AndroidPlatformConstraints? get androidPlatformConstraints =>
      throw _privateConstructorUsedError;

  /// used iOS platform constraints
  IOSPlatformConstraints? get iosPlatformConstraints =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PackageApiCopyWith<PackageApi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageApiCopyWith<$Res> {
  factory $PackageApiCopyWith(
          PackageApi value, $Res Function(PackageApi) then) =
      _$PackageApiCopyWithImpl<$Res>;
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
      List<ClassDeclaration> classDeclarations,
      List<ExecutableDeclaration> executableDeclarations,
      List<FieldDeclaration> fieldDeclarations,
      List<TypeAliasDeclaration> typeAliasDeclarations,
      Set<PackageApiSemantics> semantics,
      AndroidPlatformConstraints? androidPlatformConstraints,
      IOSPlatformConstraints? iosPlatformConstraints});

  $AndroidPlatformConstraintsCopyWith<$Res>? get androidPlatformConstraints;
  $IOSPlatformConstraintsCopyWith<$Res>? get iosPlatformConstraints;
}

/// @nodoc
class _$PackageApiCopyWithImpl<$Res> implements $PackageApiCopyWith<$Res> {
  _$PackageApiCopyWithImpl(this._value, this._then);

  final PackageApi _value;
  // ignore: unused_field
  final $Res Function(PackageApi) _then;

  @override
  $Res call({
    Object? packageName = freezed,
    Object? packageVersion = freezed,
    Object? packagePath = freezed,
    Object? classDeclarations = freezed,
    Object? executableDeclarations = freezed,
    Object? fieldDeclarations = freezed,
    Object? typeAliasDeclarations = freezed,
    Object? semantics = freezed,
    Object? androidPlatformConstraints = freezed,
    Object? iosPlatformConstraints = freezed,
  }) {
    return _then(_value.copyWith(
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageVersion: packageVersion == freezed
          ? _value.packageVersion
          : packageVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      packagePath: packagePath == freezed
          ? _value.packagePath
          : packagePath // ignore: cast_nullable_to_non_nullable
              as String,
      classDeclarations: classDeclarations == freezed
          ? _value.classDeclarations
          : classDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ClassDeclaration>,
      executableDeclarations: executableDeclarations == freezed
          ? _value.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: fieldDeclarations == freezed
          ? _value.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
      typeAliasDeclarations: typeAliasDeclarations == freezed
          ? _value.typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclaration>,
      semantics: semantics == freezed
          ? _value.semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      androidPlatformConstraints: androidPlatformConstraints == freezed
          ? _value.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraints?,
      iosPlatformConstraints: iosPlatformConstraints == freezed
          ? _value.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraints?,
    ));
  }

  @override
  $AndroidPlatformConstraintsCopyWith<$Res>? get androidPlatformConstraints {
    if (_value.androidPlatformConstraints == null) {
      return null;
    }

    return $AndroidPlatformConstraintsCopyWith<$Res>(
        _value.androidPlatformConstraints!, (value) {
      return _then(_value.copyWith(androidPlatformConstraints: value));
    });
  }

  @override
  $IOSPlatformConstraintsCopyWith<$Res>? get iosPlatformConstraints {
    if (_value.iosPlatformConstraints == null) {
      return null;
    }

    return $IOSPlatformConstraintsCopyWith<$Res>(_value.iosPlatformConstraints!,
        (value) {
      return _then(_value.copyWith(iosPlatformConstraints: value));
    });
  }
}

/// @nodoc
abstract class _$$_PackageApiCopyWith<$Res>
    implements $PackageApiCopyWith<$Res> {
  factory _$$_PackageApiCopyWith(
          _$_PackageApi value, $Res Function(_$_PackageApi) then) =
      __$$_PackageApiCopyWithImpl<$Res>;
  @override
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
      List<ClassDeclaration> classDeclarations,
      List<ExecutableDeclaration> executableDeclarations,
      List<FieldDeclaration> fieldDeclarations,
      List<TypeAliasDeclaration> typeAliasDeclarations,
      Set<PackageApiSemantics> semantics,
      AndroidPlatformConstraints? androidPlatformConstraints,
      IOSPlatformConstraints? iosPlatformConstraints});

  @override
  $AndroidPlatformConstraintsCopyWith<$Res>? get androidPlatformConstraints;
  @override
  $IOSPlatformConstraintsCopyWith<$Res>? get iosPlatformConstraints;
}

/// @nodoc
class __$$_PackageApiCopyWithImpl<$Res> extends _$PackageApiCopyWithImpl<$Res>
    implements _$$_PackageApiCopyWith<$Res> {
  __$$_PackageApiCopyWithImpl(
      _$_PackageApi _value, $Res Function(_$_PackageApi) _then)
      : super(_value, (v) => _then(v as _$_PackageApi));

  @override
  _$_PackageApi get _value => super._value as _$_PackageApi;

  @override
  $Res call({
    Object? packageName = freezed,
    Object? packageVersion = freezed,
    Object? packagePath = freezed,
    Object? classDeclarations = freezed,
    Object? executableDeclarations = freezed,
    Object? fieldDeclarations = freezed,
    Object? typeAliasDeclarations = freezed,
    Object? semantics = freezed,
    Object? androidPlatformConstraints = freezed,
    Object? iosPlatformConstraints = freezed,
  }) {
    return _then(_$_PackageApi(
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageVersion: packageVersion == freezed
          ? _value.packageVersion
          : packageVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      packagePath: packagePath == freezed
          ? _value.packagePath
          : packagePath // ignore: cast_nullable_to_non_nullable
              as String,
      classDeclarations: classDeclarations == freezed
          ? _value._classDeclarations
          : classDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ClassDeclaration>,
      executableDeclarations: executableDeclarations == freezed
          ? _value._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: fieldDeclarations == freezed
          ? _value._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
      typeAliasDeclarations: typeAliasDeclarations == freezed
          ? _value._typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclaration>,
      semantics: semantics == freezed
          ? _value._semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      androidPlatformConstraints: androidPlatformConstraints == freezed
          ? _value.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraints?,
      iosPlatformConstraints: iosPlatformConstraints == freezed
          ? _value.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraints?,
    ));
  }
}

/// @nodoc

class _$_PackageApi extends _PackageApi {
  const _$_PackageApi(
      {required this.packageName,
      required this.packageVersion,
      required this.packagePath,
      required final List<ClassDeclaration> classDeclarations,
      required final List<ExecutableDeclaration> executableDeclarations,
      required final List<FieldDeclaration> fieldDeclarations,
      required final List<TypeAliasDeclaration> typeAliasDeclarations,
      final Set<PackageApiSemantics> semantics = const <PackageApiSemantics>{},
      this.androidPlatformConstraints,
      this.iosPlatformConstraints})
      : _classDeclarations = classDeclarations,
        _executableDeclarations = executableDeclarations,
        _fieldDeclarations = fieldDeclarations,
        _typeAliasDeclarations = typeAliasDeclarations,
        _semantics = semantics,
        super._();

  /// name of the package
  @override
  final String packageName;

  /// version of the package
  @override
  final String? packageVersion;

  /// path to the package
  @override
  final String packagePath;

  /// class declarations this package has
  final List<ClassDeclaration> _classDeclarations;

  /// class declarations this package has
  @override
  List<ClassDeclaration> get classDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_classDeclarations);
  }

  /// root level executable declarations this package has
  final List<ExecutableDeclaration> _executableDeclarations;

  /// root level executable declarations this package has
  @override
  List<ExecutableDeclaration> get executableDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_executableDeclarations);
  }

  /// root level field declarations this package has
  final List<FieldDeclaration> _fieldDeclarations;

  /// root level field declarations this package has
  @override
  List<FieldDeclaration> get fieldDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fieldDeclarations);
  }

  /// type alias declarations this package has
  final List<TypeAliasDeclaration> _typeAliasDeclarations;

  /// type alias declarations this package has
  @override
  List<TypeAliasDeclaration> get typeAliasDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeAliasDeclarations);
  }

  /// the semantics of this model. This indicates if this model is compatible (e.g. for diffing) with another model
  final Set<PackageApiSemantics> _semantics;

  /// the semantics of this model. This indicates if this model is compatible (e.g. for diffing) with another model
  @override
  @JsonKey()
  Set<PackageApiSemantics> get semantics {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_semantics);
  }

  /// used Android platform constraints
  @override
  final AndroidPlatformConstraints? androidPlatformConstraints;

  /// used iOS platform constraints
  @override
  final IOSPlatformConstraints? iosPlatformConstraints;

  @override
  String toString() {
    return 'PackageApi(packageName: $packageName, packageVersion: $packageVersion, packagePath: $packagePath, classDeclarations: $classDeclarations, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, typeAliasDeclarations: $typeAliasDeclarations, semantics: $semantics, androidPlatformConstraints: $androidPlatformConstraints, iosPlatformConstraints: $iosPlatformConstraints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackageApi &&
            const DeepCollectionEquality()
                .equals(other.packageName, packageName) &&
            const DeepCollectionEquality()
                .equals(other.packageVersion, packageVersion) &&
            const DeepCollectionEquality()
                .equals(other.packagePath, packagePath) &&
            const DeepCollectionEquality()
                .equals(other._classDeclarations, _classDeclarations) &&
            const DeepCollectionEquality().equals(
                other._executableDeclarations, _executableDeclarations) &&
            const DeepCollectionEquality()
                .equals(other._fieldDeclarations, _fieldDeclarations) &&
            const DeepCollectionEquality()
                .equals(other._typeAliasDeclarations, _typeAliasDeclarations) &&
            const DeepCollectionEquality()
                .equals(other._semantics, _semantics) &&
            const DeepCollectionEquality().equals(
                other.androidPlatformConstraints, androidPlatformConstraints) &&
            const DeepCollectionEquality()
                .equals(other.iosPlatformConstraints, iosPlatformConstraints));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(packageName),
      const DeepCollectionEquality().hash(packageVersion),
      const DeepCollectionEquality().hash(packagePath),
      const DeepCollectionEquality().hash(_classDeclarations),
      const DeepCollectionEquality().hash(_executableDeclarations),
      const DeepCollectionEquality().hash(_fieldDeclarations),
      const DeepCollectionEquality().hash(_typeAliasDeclarations),
      const DeepCollectionEquality().hash(_semantics),
      const DeepCollectionEquality().hash(androidPlatformConstraints),
      const DeepCollectionEquality().hash(iosPlatformConstraints));

  @JsonKey(ignore: true)
  @override
  _$$_PackageApiCopyWith<_$_PackageApi> get copyWith =>
      __$$_PackageApiCopyWithImpl<_$_PackageApi>(this, _$identity);
}

abstract class _PackageApi extends PackageApi {
  const factory _PackageApi(
      {required final String packageName,
      required final String? packageVersion,
      required final String packagePath,
      required final List<ClassDeclaration> classDeclarations,
      required final List<ExecutableDeclaration> executableDeclarations,
      required final List<FieldDeclaration> fieldDeclarations,
      required final List<TypeAliasDeclaration> typeAliasDeclarations,
      final Set<PackageApiSemantics> semantics,
      final AndroidPlatformConstraints? androidPlatformConstraints,
      final IOSPlatformConstraints? iosPlatformConstraints}) = _$_PackageApi;
  const _PackageApi._() : super._();

  @override

  /// name of the package
  String get packageName;
  @override

  /// version of the package
  String? get packageVersion;
  @override

  /// path to the package
  String get packagePath;
  @override

  /// class declarations this package has
  List<ClassDeclaration> get classDeclarations;
  @override

  /// root level executable declarations this package has
  List<ExecutableDeclaration> get executableDeclarations;
  @override

  /// root level field declarations this package has
  List<FieldDeclaration> get fieldDeclarations;
  @override

  /// type alias declarations this package has
  List<TypeAliasDeclaration> get typeAliasDeclarations;
  @override

  /// the semantics of this model. This indicates if this model is compatible (e.g. for diffing) with another model
  Set<PackageApiSemantics> get semantics;
  @override

  /// used Android platform constraints
  AndroidPlatformConstraints? get androidPlatformConstraints;
  @override

  /// used iOS platform constraints
  IOSPlatformConstraints? get iosPlatformConstraints;
  @override
  @JsonKey(ignore: true)
  _$$_PackageApiCopyWith<_$_PackageApi> get copyWith =>
      throw _privateConstructorUsedError;
}
