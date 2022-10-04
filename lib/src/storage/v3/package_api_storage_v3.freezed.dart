// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'package_api_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PackageApiStorageV3 _$PackageApiStorageV3FromJson(Map<String, dynamic> json) {
  return _PackageApiStorageV3.fromJson(json);
}

/// @nodoc
mixin _$PackageApiStorageV3 {
  String get packageName => throw _privateConstructorUsedError;
  String? get packageVersion => throw _privateConstructorUsedError;
  String get packagePath => throw _privateConstructorUsedError;
  List<ClassDeclarationStorageV3> get classDeclarations =>
      throw _privateConstructorUsedError;
  List<ExecutableDeclarationStorageV3> get executableDeclarations =>
      throw _privateConstructorUsedError;
  List<FieldDeclarationStorageV3> get fieldDeclarations =>
      throw _privateConstructorUsedError;
  List<TypeAliasDeclarationStorageV3> get typeAliasDeclarations =>
      throw _privateConstructorUsedError;
  Set<PackageApiSemantics> get semantics => throw _privateConstructorUsedError;
  IOSPlatformConstraintsStorageV3? get iosPlatformConstraints =>
      throw _privateConstructorUsedError;
  AndroidPlatformConstraintsStorageV3? get androidPlatformConstraints =>
      throw _privateConstructorUsedError;
  SdkTypeStorageV3 get sdkType => throw _privateConstructorUsedError;
  @VersionJsonConverter()
  Version get minSdkVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackageApiStorageV3CopyWith<PackageApiStorageV3> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageApiStorageV3CopyWith<$Res> {
  factory $PackageApiStorageV3CopyWith(
          PackageApiStorageV3 value, $Res Function(PackageApiStorageV3) then) =
      _$PackageApiStorageV3CopyWithImpl<$Res>;
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
      List<ClassDeclarationStorageV3> classDeclarations,
      List<ExecutableDeclarationStorageV3> executableDeclarations,
      List<FieldDeclarationStorageV3> fieldDeclarations,
      List<TypeAliasDeclarationStorageV3> typeAliasDeclarations,
      Set<PackageApiSemantics> semantics,
      IOSPlatformConstraintsStorageV3? iosPlatformConstraints,
      AndroidPlatformConstraintsStorageV3? androidPlatformConstraints,
      SdkTypeStorageV3 sdkType,
      @VersionJsonConverter() Version minSdkVersion});

  $IOSPlatformConstraintsStorageV3CopyWith<$Res>? get iosPlatformConstraints;
  $AndroidPlatformConstraintsStorageV3CopyWith<$Res>?
      get androidPlatformConstraints;
}

/// @nodoc
class _$PackageApiStorageV3CopyWithImpl<$Res>
    implements $PackageApiStorageV3CopyWith<$Res> {
  _$PackageApiStorageV3CopyWithImpl(this._value, this._then);

  final PackageApiStorageV3 _value;
  // ignore: unused_field
  final $Res Function(PackageApiStorageV3) _then;

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
    Object? iosPlatformConstraints = freezed,
    Object? androidPlatformConstraints = freezed,
    Object? sdkType = freezed,
    Object? minSdkVersion = freezed,
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
              as List<ClassDeclarationStorageV3>,
      executableDeclarations: executableDeclarations == freezed
          ? _value.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclarationStorageV3>,
      fieldDeclarations: fieldDeclarations == freezed
          ? _value.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclarationStorageV3>,
      typeAliasDeclarations: typeAliasDeclarations == freezed
          ? _value.typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclarationStorageV3>,
      semantics: semantics == freezed
          ? _value.semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      iosPlatformConstraints: iosPlatformConstraints == freezed
          ? _value.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraintsStorageV3?,
      androidPlatformConstraints: androidPlatformConstraints == freezed
          ? _value.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraintsStorageV3?,
      sdkType: sdkType == freezed
          ? _value.sdkType
          : sdkType // ignore: cast_nullable_to_non_nullable
              as SdkTypeStorageV3,
      minSdkVersion: minSdkVersion == freezed
          ? _value.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as Version,
    ));
  }

  @override
  $IOSPlatformConstraintsStorageV3CopyWith<$Res>? get iosPlatformConstraints {
    if (_value.iosPlatformConstraints == null) {
      return null;
    }

    return $IOSPlatformConstraintsStorageV3CopyWith<$Res>(
        _value.iosPlatformConstraints!, (value) {
      return _then(_value.copyWith(iosPlatformConstraints: value));
    });
  }

  @override
  $AndroidPlatformConstraintsStorageV3CopyWith<$Res>?
      get androidPlatformConstraints {
    if (_value.androidPlatformConstraints == null) {
      return null;
    }

    return $AndroidPlatformConstraintsStorageV3CopyWith<$Res>(
        _value.androidPlatformConstraints!, (value) {
      return _then(_value.copyWith(androidPlatformConstraints: value));
    });
  }
}

/// @nodoc
abstract class _$$_PackageApiStorageV3CopyWith<$Res>
    implements $PackageApiStorageV3CopyWith<$Res> {
  factory _$$_PackageApiStorageV3CopyWith(_$_PackageApiStorageV3 value,
          $Res Function(_$_PackageApiStorageV3) then) =
      __$$_PackageApiStorageV3CopyWithImpl<$Res>;
  @override
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
      List<ClassDeclarationStorageV3> classDeclarations,
      List<ExecutableDeclarationStorageV3> executableDeclarations,
      List<FieldDeclarationStorageV3> fieldDeclarations,
      List<TypeAliasDeclarationStorageV3> typeAliasDeclarations,
      Set<PackageApiSemantics> semantics,
      IOSPlatformConstraintsStorageV3? iosPlatformConstraints,
      AndroidPlatformConstraintsStorageV3? androidPlatformConstraints,
      SdkTypeStorageV3 sdkType,
      @VersionJsonConverter() Version minSdkVersion});

  @override
  $IOSPlatformConstraintsStorageV3CopyWith<$Res>? get iosPlatformConstraints;
  @override
  $AndroidPlatformConstraintsStorageV3CopyWith<$Res>?
      get androidPlatformConstraints;
}

/// @nodoc
class __$$_PackageApiStorageV3CopyWithImpl<$Res>
    extends _$PackageApiStorageV3CopyWithImpl<$Res>
    implements _$$_PackageApiStorageV3CopyWith<$Res> {
  __$$_PackageApiStorageV3CopyWithImpl(_$_PackageApiStorageV3 _value,
      $Res Function(_$_PackageApiStorageV3) _then)
      : super(_value, (v) => _then(v as _$_PackageApiStorageV3));

  @override
  _$_PackageApiStorageV3 get _value => super._value as _$_PackageApiStorageV3;

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
    Object? iosPlatformConstraints = freezed,
    Object? androidPlatformConstraints = freezed,
    Object? sdkType = freezed,
    Object? minSdkVersion = freezed,
  }) {
    return _then(_$_PackageApiStorageV3(
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
              as List<ClassDeclarationStorageV3>,
      executableDeclarations: executableDeclarations == freezed
          ? _value._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclarationStorageV3>,
      fieldDeclarations: fieldDeclarations == freezed
          ? _value._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclarationStorageV3>,
      typeAliasDeclarations: typeAliasDeclarations == freezed
          ? _value._typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclarationStorageV3>,
      semantics: semantics == freezed
          ? _value._semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      iosPlatformConstraints: iosPlatformConstraints == freezed
          ? _value.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraintsStorageV3?,
      androidPlatformConstraints: androidPlatformConstraints == freezed
          ? _value.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraintsStorageV3?,
      sdkType: sdkType == freezed
          ? _value.sdkType
          : sdkType // ignore: cast_nullable_to_non_nullable
              as SdkTypeStorageV3,
      minSdkVersion: minSdkVersion == freezed
          ? _value.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as Version,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PackageApiStorageV3 extends _PackageApiStorageV3 {
  const _$_PackageApiStorageV3(
      {required this.packageName,
      required this.packageVersion,
      required this.packagePath,
      required final List<ClassDeclarationStorageV3> classDeclarations,
      required final List<ExecutableDeclarationStorageV3>
          executableDeclarations,
      required final List<FieldDeclarationStorageV3> fieldDeclarations,
      required final List<TypeAliasDeclarationStorageV3> typeAliasDeclarations,
      required final Set<PackageApiSemantics> semantics,
      this.iosPlatformConstraints,
      this.androidPlatformConstraints,
      required this.sdkType,
      @VersionJsonConverter() required this.minSdkVersion})
      : _classDeclarations = classDeclarations,
        _executableDeclarations = executableDeclarations,
        _fieldDeclarations = fieldDeclarations,
        _typeAliasDeclarations = typeAliasDeclarations,
        _semantics = semantics,
        super._();

  factory _$_PackageApiStorageV3.fromJson(Map<String, dynamic> json) =>
      _$$_PackageApiStorageV3FromJson(json);

  @override
  final String packageName;
  @override
  final String? packageVersion;
  @override
  final String packagePath;
  final List<ClassDeclarationStorageV3> _classDeclarations;
  @override
  List<ClassDeclarationStorageV3> get classDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_classDeclarations);
  }

  final List<ExecutableDeclarationStorageV3> _executableDeclarations;
  @override
  List<ExecutableDeclarationStorageV3> get executableDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_executableDeclarations);
  }

  final List<FieldDeclarationStorageV3> _fieldDeclarations;
  @override
  List<FieldDeclarationStorageV3> get fieldDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fieldDeclarations);
  }

  final List<TypeAliasDeclarationStorageV3> _typeAliasDeclarations;
  @override
  List<TypeAliasDeclarationStorageV3> get typeAliasDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeAliasDeclarations);
  }

  final Set<PackageApiSemantics> _semantics;
  @override
  Set<PackageApiSemantics> get semantics {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_semantics);
  }

  @override
  final IOSPlatformConstraintsStorageV3? iosPlatformConstraints;
  @override
  final AndroidPlatformConstraintsStorageV3? androidPlatformConstraints;
  @override
  final SdkTypeStorageV3 sdkType;
  @override
  @VersionJsonConverter()
  final Version minSdkVersion;

  @override
  String toString() {
    return 'PackageApiStorageV3(packageName: $packageName, packageVersion: $packageVersion, packagePath: $packagePath, classDeclarations: $classDeclarations, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, typeAliasDeclarations: $typeAliasDeclarations, semantics: $semantics, iosPlatformConstraints: $iosPlatformConstraints, androidPlatformConstraints: $androidPlatformConstraints, sdkType: $sdkType, minSdkVersion: $minSdkVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackageApiStorageV3 &&
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
            const DeepCollectionEquality()
                .equals(other.iosPlatformConstraints, iosPlatformConstraints) &&
            const DeepCollectionEquality().equals(
                other.androidPlatformConstraints, androidPlatformConstraints) &&
            const DeepCollectionEquality().equals(other.sdkType, sdkType) &&
            const DeepCollectionEquality()
                .equals(other.minSdkVersion, minSdkVersion));
  }

  @JsonKey(ignore: true)
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
      const DeepCollectionEquality().hash(iosPlatformConstraints),
      const DeepCollectionEquality().hash(androidPlatformConstraints),
      const DeepCollectionEquality().hash(sdkType),
      const DeepCollectionEquality().hash(minSdkVersion));

  @JsonKey(ignore: true)
  @override
  _$$_PackageApiStorageV3CopyWith<_$_PackageApiStorageV3> get copyWith =>
      __$$_PackageApiStorageV3CopyWithImpl<_$_PackageApiStorageV3>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackageApiStorageV3ToJson(
      this,
    );
  }
}

abstract class _PackageApiStorageV3 extends PackageApiStorageV3 {
  const factory _PackageApiStorageV3(
      {required final String packageName,
      required final String? packageVersion,
      required final String packagePath,
      required final List<ClassDeclarationStorageV3> classDeclarations,
      required final List<ExecutableDeclarationStorageV3>
          executableDeclarations,
      required final List<FieldDeclarationStorageV3> fieldDeclarations,
      required final List<TypeAliasDeclarationStorageV3> typeAliasDeclarations,
      required final Set<PackageApiSemantics> semantics,
      final IOSPlatformConstraintsStorageV3? iosPlatformConstraints,
      final AndroidPlatformConstraintsStorageV3? androidPlatformConstraints,
      required final SdkTypeStorageV3 sdkType,
      @VersionJsonConverter()
          required final Version minSdkVersion}) = _$_PackageApiStorageV3;
  const _PackageApiStorageV3._() : super._();

  factory _PackageApiStorageV3.fromJson(Map<String, dynamic> json) =
      _$_PackageApiStorageV3.fromJson;

  @override
  String get packageName;
  @override
  String? get packageVersion;
  @override
  String get packagePath;
  @override
  List<ClassDeclarationStorageV3> get classDeclarations;
  @override
  List<ExecutableDeclarationStorageV3> get executableDeclarations;
  @override
  List<FieldDeclarationStorageV3> get fieldDeclarations;
  @override
  List<TypeAliasDeclarationStorageV3> get typeAliasDeclarations;
  @override
  Set<PackageApiSemantics> get semantics;
  @override
  IOSPlatformConstraintsStorageV3? get iosPlatformConstraints;
  @override
  AndroidPlatformConstraintsStorageV3? get androidPlatformConstraints;
  @override
  SdkTypeStorageV3 get sdkType;
  @override
  @VersionJsonConverter()
  Version get minSdkVersion;
  @override
  @JsonKey(ignore: true)
  _$$_PackageApiStorageV3CopyWith<_$_PackageApiStorageV3> get copyWith =>
      throw _privateConstructorUsedError;
}