// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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

  /// path to the package cluster
  String get clusterPath => throw _privateConstructorUsedError;

  /// interface declarations this package has
  List<InterfaceDeclaration> get interfaceDeclarations =>
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

  /// type of sdk needed
  SdkType get sdkType => throw _privateConstructorUsedError;

  /// package dependencies
  List<PackageDependency> get packageDependencies =>
      throw _privateConstructorUsedError;

  /// minimum sdk version
  Version get minSdkVersion => throw _privateConstructorUsedError;

  /// the type hierarchy of the public API
  TypeHierarchy get typeHierarchy => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PackageApiCopyWith<PackageApi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageApiCopyWith<$Res> {
  factory $PackageApiCopyWith(
          PackageApi value, $Res Function(PackageApi) then) =
      _$PackageApiCopyWithImpl<$Res, PackageApi>;
  @useResult
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
      String clusterPath,
      List<InterfaceDeclaration> interfaceDeclarations,
      List<ExecutableDeclaration> executableDeclarations,
      List<FieldDeclaration> fieldDeclarations,
      List<TypeAliasDeclaration> typeAliasDeclarations,
      Set<PackageApiSemantics> semantics,
      AndroidPlatformConstraints? androidPlatformConstraints,
      IOSPlatformConstraints? iosPlatformConstraints,
      SdkType sdkType,
      List<PackageDependency> packageDependencies,
      Version minSdkVersion,
      TypeHierarchy typeHierarchy});

  $AndroidPlatformConstraintsCopyWith<$Res>? get androidPlatformConstraints;
  $IOSPlatformConstraintsCopyWith<$Res>? get iosPlatformConstraints;
  $TypeHierarchyCopyWith<$Res> get typeHierarchy;
}

/// @nodoc
class _$PackageApiCopyWithImpl<$Res, $Val extends PackageApi>
    implements $PackageApiCopyWith<$Res> {
  _$PackageApiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
    Object? packagePath = null,
    Object? clusterPath = null,
    Object? interfaceDeclarations = null,
    Object? executableDeclarations = null,
    Object? fieldDeclarations = null,
    Object? typeAliasDeclarations = null,
    Object? semantics = null,
    Object? androidPlatformConstraints = freezed,
    Object? iosPlatformConstraints = freezed,
    Object? sdkType = null,
    Object? packageDependencies = null,
    Object? minSdkVersion = null,
    Object? typeHierarchy = null,
  }) {
    return _then(_value.copyWith(
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageVersion: freezed == packageVersion
          ? _value.packageVersion
          : packageVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      packagePath: null == packagePath
          ? _value.packagePath
          : packagePath // ignore: cast_nullable_to_non_nullable
              as String,
      clusterPath: null == clusterPath
          ? _value.clusterPath
          : clusterPath // ignore: cast_nullable_to_non_nullable
              as String,
      interfaceDeclarations: null == interfaceDeclarations
          ? _value.interfaceDeclarations
          : interfaceDeclarations // ignore: cast_nullable_to_non_nullable
              as List<InterfaceDeclaration>,
      executableDeclarations: null == executableDeclarations
          ? _value.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: null == fieldDeclarations
          ? _value.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
      typeAliasDeclarations: null == typeAliasDeclarations
          ? _value.typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclaration>,
      semantics: null == semantics
          ? _value.semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      androidPlatformConstraints: freezed == androidPlatformConstraints
          ? _value.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraints?,
      iosPlatformConstraints: freezed == iosPlatformConstraints
          ? _value.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraints?,
      sdkType: null == sdkType
          ? _value.sdkType
          : sdkType // ignore: cast_nullable_to_non_nullable
              as SdkType,
      packageDependencies: null == packageDependencies
          ? _value.packageDependencies
          : packageDependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageDependency>,
      minSdkVersion: null == minSdkVersion
          ? _value.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as Version,
      typeHierarchy: null == typeHierarchy
          ? _value.typeHierarchy
          : typeHierarchy // ignore: cast_nullable_to_non_nullable
              as TypeHierarchy,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AndroidPlatformConstraintsCopyWith<$Res>? get androidPlatformConstraints {
    if (_value.androidPlatformConstraints == null) {
      return null;
    }

    return $AndroidPlatformConstraintsCopyWith<$Res>(
        _value.androidPlatformConstraints!, (value) {
      return _then(_value.copyWith(androidPlatformConstraints: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IOSPlatformConstraintsCopyWith<$Res>? get iosPlatformConstraints {
    if (_value.iosPlatformConstraints == null) {
      return null;
    }

    return $IOSPlatformConstraintsCopyWith<$Res>(_value.iosPlatformConstraints!,
        (value) {
      return _then(_value.copyWith(iosPlatformConstraints: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TypeHierarchyCopyWith<$Res> get typeHierarchy {
    return $TypeHierarchyCopyWith<$Res>(_value.typeHierarchy, (value) {
      return _then(_value.copyWith(typeHierarchy: value) as $Val);
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
  @useResult
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
      String clusterPath,
      List<InterfaceDeclaration> interfaceDeclarations,
      List<ExecutableDeclaration> executableDeclarations,
      List<FieldDeclaration> fieldDeclarations,
      List<TypeAliasDeclaration> typeAliasDeclarations,
      Set<PackageApiSemantics> semantics,
      AndroidPlatformConstraints? androidPlatformConstraints,
      IOSPlatformConstraints? iosPlatformConstraints,
      SdkType sdkType,
      List<PackageDependency> packageDependencies,
      Version minSdkVersion,
      TypeHierarchy typeHierarchy});

  @override
  $AndroidPlatformConstraintsCopyWith<$Res>? get androidPlatformConstraints;
  @override
  $IOSPlatformConstraintsCopyWith<$Res>? get iosPlatformConstraints;
  @override
  $TypeHierarchyCopyWith<$Res> get typeHierarchy;
}

/// @nodoc
class __$$_PackageApiCopyWithImpl<$Res>
    extends _$PackageApiCopyWithImpl<$Res, _$_PackageApi>
    implements _$$_PackageApiCopyWith<$Res> {
  __$$_PackageApiCopyWithImpl(
      _$_PackageApi _value, $Res Function(_$_PackageApi) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
    Object? packagePath = null,
    Object? clusterPath = null,
    Object? interfaceDeclarations = null,
    Object? executableDeclarations = null,
    Object? fieldDeclarations = null,
    Object? typeAliasDeclarations = null,
    Object? semantics = null,
    Object? androidPlatformConstraints = freezed,
    Object? iosPlatformConstraints = freezed,
    Object? sdkType = null,
    Object? packageDependencies = null,
    Object? minSdkVersion = null,
    Object? typeHierarchy = null,
  }) {
    return _then(_$_PackageApi(
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageVersion: freezed == packageVersion
          ? _value.packageVersion
          : packageVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      packagePath: null == packagePath
          ? _value.packagePath
          : packagePath // ignore: cast_nullable_to_non_nullable
              as String,
      clusterPath: null == clusterPath
          ? _value.clusterPath
          : clusterPath // ignore: cast_nullable_to_non_nullable
              as String,
      interfaceDeclarations: null == interfaceDeclarations
          ? _value._interfaceDeclarations
          : interfaceDeclarations // ignore: cast_nullable_to_non_nullable
              as List<InterfaceDeclaration>,
      executableDeclarations: null == executableDeclarations
          ? _value._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: null == fieldDeclarations
          ? _value._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
      typeAliasDeclarations: null == typeAliasDeclarations
          ? _value._typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclaration>,
      semantics: null == semantics
          ? _value._semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      androidPlatformConstraints: freezed == androidPlatformConstraints
          ? _value.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraints?,
      iosPlatformConstraints: freezed == iosPlatformConstraints
          ? _value.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraints?,
      sdkType: null == sdkType
          ? _value.sdkType
          : sdkType // ignore: cast_nullable_to_non_nullable
              as SdkType,
      packageDependencies: null == packageDependencies
          ? _value._packageDependencies
          : packageDependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageDependency>,
      minSdkVersion: null == minSdkVersion
          ? _value.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as Version,
      typeHierarchy: null == typeHierarchy
          ? _value.typeHierarchy
          : typeHierarchy // ignore: cast_nullable_to_non_nullable
              as TypeHierarchy,
    ));
  }
}

/// @nodoc

class _$_PackageApi extends _PackageApi {
  const _$_PackageApi(
      {required this.packageName,
      required this.packageVersion,
      required this.packagePath,
      required this.clusterPath,
      required final List<InterfaceDeclaration> interfaceDeclarations,
      required final List<ExecutableDeclaration> executableDeclarations,
      required final List<FieldDeclaration> fieldDeclarations,
      required final List<TypeAliasDeclaration> typeAliasDeclarations,
      final Set<PackageApiSemantics> semantics = const <PackageApiSemantics>{},
      this.androidPlatformConstraints,
      this.iosPlatformConstraints,
      required this.sdkType,
      required final List<PackageDependency> packageDependencies,
      required this.minSdkVersion,
      required this.typeHierarchy})
      : _interfaceDeclarations = interfaceDeclarations,
        _executableDeclarations = executableDeclarations,
        _fieldDeclarations = fieldDeclarations,
        _typeAliasDeclarations = typeAliasDeclarations,
        _semantics = semantics,
        _packageDependencies = packageDependencies,
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

  /// path to the package cluster
  @override
  final String clusterPath;

  /// interface declarations this package has
  final List<InterfaceDeclaration> _interfaceDeclarations;

  /// interface declarations this package has
  @override
  List<InterfaceDeclaration> get interfaceDeclarations {
    if (_interfaceDeclarations is EqualUnmodifiableListView)
      return _interfaceDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interfaceDeclarations);
  }

  /// root level executable declarations this package has
  final List<ExecutableDeclaration> _executableDeclarations;

  /// root level executable declarations this package has
  @override
  List<ExecutableDeclaration> get executableDeclarations {
    if (_executableDeclarations is EqualUnmodifiableListView)
      return _executableDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_executableDeclarations);
  }

  /// root level field declarations this package has
  final List<FieldDeclaration> _fieldDeclarations;

  /// root level field declarations this package has
  @override
  List<FieldDeclaration> get fieldDeclarations {
    if (_fieldDeclarations is EqualUnmodifiableListView)
      return _fieldDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fieldDeclarations);
  }

  /// type alias declarations this package has
  final List<TypeAliasDeclaration> _typeAliasDeclarations;

  /// type alias declarations this package has
  @override
  List<TypeAliasDeclaration> get typeAliasDeclarations {
    if (_typeAliasDeclarations is EqualUnmodifiableListView)
      return _typeAliasDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeAliasDeclarations);
  }

  /// the semantics of this model. This indicates if this model is compatible (e.g. for diffing) with another model
  final Set<PackageApiSemantics> _semantics;

  /// the semantics of this model. This indicates if this model is compatible (e.g. for diffing) with another model
  @override
  @JsonKey()
  Set<PackageApiSemantics> get semantics {
    if (_semantics is EqualUnmodifiableSetView) return _semantics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_semantics);
  }

  /// used Android platform constraints
  @override
  final AndroidPlatformConstraints? androidPlatformConstraints;

  /// used iOS platform constraints
  @override
  final IOSPlatformConstraints? iosPlatformConstraints;

  /// type of sdk needed
  @override
  final SdkType sdkType;

  /// package dependencies
  final List<PackageDependency> _packageDependencies;

  /// package dependencies
  @override
  List<PackageDependency> get packageDependencies {
    if (_packageDependencies is EqualUnmodifiableListView)
      return _packageDependencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packageDependencies);
  }

  /// minimum sdk version
  @override
  final Version minSdkVersion;

  /// the type hierarchy of the public API
  @override
  final TypeHierarchy typeHierarchy;

  @override
  String toString() {
    return 'PackageApi(packageName: $packageName, packageVersion: $packageVersion, packagePath: $packagePath, clusterPath: $clusterPath, interfaceDeclarations: $interfaceDeclarations, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, typeAliasDeclarations: $typeAliasDeclarations, semantics: $semantics, androidPlatformConstraints: $androidPlatformConstraints, iosPlatformConstraints: $iosPlatformConstraints, sdkType: $sdkType, packageDependencies: $packageDependencies, minSdkVersion: $minSdkVersion, typeHierarchy: $typeHierarchy)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackageApi &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageVersion, packageVersion) ||
                other.packageVersion == packageVersion) &&
            (identical(other.packagePath, packagePath) ||
                other.packagePath == packagePath) &&
            (identical(other.clusterPath, clusterPath) ||
                other.clusterPath == clusterPath) &&
            const DeepCollectionEquality()
                .equals(other._interfaceDeclarations, _interfaceDeclarations) &&
            const DeepCollectionEquality().equals(
                other._executableDeclarations, _executableDeclarations) &&
            const DeepCollectionEquality()
                .equals(other._fieldDeclarations, _fieldDeclarations) &&
            const DeepCollectionEquality()
                .equals(other._typeAliasDeclarations, _typeAliasDeclarations) &&
            const DeepCollectionEquality()
                .equals(other._semantics, _semantics) &&
            (identical(other.androidPlatformConstraints,
                    androidPlatformConstraints) ||
                other.androidPlatformConstraints ==
                    androidPlatformConstraints) &&
            (identical(other.iosPlatformConstraints, iosPlatformConstraints) ||
                other.iosPlatformConstraints == iosPlatformConstraints) &&
            (identical(other.sdkType, sdkType) || other.sdkType == sdkType) &&
            const DeepCollectionEquality()
                .equals(other._packageDependencies, _packageDependencies) &&
            (identical(other.minSdkVersion, minSdkVersion) ||
                other.minSdkVersion == minSdkVersion) &&
            (identical(other.typeHierarchy, typeHierarchy) ||
                other.typeHierarchy == typeHierarchy));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      packageName,
      packageVersion,
      packagePath,
      clusterPath,
      const DeepCollectionEquality().hash(_interfaceDeclarations),
      const DeepCollectionEquality().hash(_executableDeclarations),
      const DeepCollectionEquality().hash(_fieldDeclarations),
      const DeepCollectionEquality().hash(_typeAliasDeclarations),
      const DeepCollectionEquality().hash(_semantics),
      androidPlatformConstraints,
      iosPlatformConstraints,
      sdkType,
      const DeepCollectionEquality().hash(_packageDependencies),
      minSdkVersion,
      typeHierarchy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackageApiCopyWith<_$_PackageApi> get copyWith =>
      __$$_PackageApiCopyWithImpl<_$_PackageApi>(this, _$identity);
}

abstract class _PackageApi extends PackageApi {
  const factory _PackageApi(
      {required final String packageName,
      required final String? packageVersion,
      required final String packagePath,
      required final String clusterPath,
      required final List<InterfaceDeclaration> interfaceDeclarations,
      required final List<ExecutableDeclaration> executableDeclarations,
      required final List<FieldDeclaration> fieldDeclarations,
      required final List<TypeAliasDeclaration> typeAliasDeclarations,
      final Set<PackageApiSemantics> semantics,
      final AndroidPlatformConstraints? androidPlatformConstraints,
      final IOSPlatformConstraints? iosPlatformConstraints,
      required final SdkType sdkType,
      required final List<PackageDependency> packageDependencies,
      required final Version minSdkVersion,
      required final TypeHierarchy typeHierarchy}) = _$_PackageApi;
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

  /// path to the package cluster
  String get clusterPath;
  @override

  /// interface declarations this package has
  List<InterfaceDeclaration> get interfaceDeclarations;
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

  /// type of sdk needed
  SdkType get sdkType;
  @override

  /// package dependencies
  List<PackageDependency> get packageDependencies;
  @override

  /// minimum sdk version
  Version get minSdkVersion;
  @override

  /// the type hierarchy of the public API
  TypeHierarchy get typeHierarchy;
  @override
  @JsonKey(ignore: true)
  _$$_PackageApiCopyWith<_$_PackageApi> get copyWith =>
      throw _privateConstructorUsedError;
}
