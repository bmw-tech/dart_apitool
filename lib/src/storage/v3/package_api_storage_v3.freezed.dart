// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_api_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PackageApiStorageV3 {
  String get packageName;
  String? get packageVersion;
  String get packagePath;
  List<InterfaceDeclarationStorageV3> get interfaceDeclarations;
  List<ExecutableDeclarationStorageV3> get executableDeclarations;
  List<FieldDeclarationStorageV3> get fieldDeclarations;
  List<TypeAliasDeclarationStorageV3> get typeAliasDeclarations;
  Set<PackageApiSemantics> get semantics;
  IOSPlatformConstraintsStorageV3? get iosPlatformConstraints;
  AndroidPlatformConstraintsStorageV3? get androidPlatformConstraints;
  SdkTypeStorageV3 get sdkType;
  @VersionJsonConverter()
  Version get minSdkVersion;
  List<PackageDependencyStorageV3> get packageDependencies;

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PackageApiStorageV3CopyWith<PackageApiStorageV3> get copyWith =>
      _$PackageApiStorageV3CopyWithImpl<PackageApiStorageV3>(
          this as PackageApiStorageV3, _$identity);

  /// Serializes this PackageApiStorageV3 to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PackageApiStorageV3 &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageVersion, packageVersion) ||
                other.packageVersion == packageVersion) &&
            (identical(other.packagePath, packagePath) ||
                other.packagePath == packagePath) &&
            const DeepCollectionEquality()
                .equals(other.interfaceDeclarations, interfaceDeclarations) &&
            const DeepCollectionEquality()
                .equals(other.executableDeclarations, executableDeclarations) &&
            const DeepCollectionEquality()
                .equals(other.fieldDeclarations, fieldDeclarations) &&
            const DeepCollectionEquality()
                .equals(other.typeAliasDeclarations, typeAliasDeclarations) &&
            const DeepCollectionEquality().equals(other.semantics, semantics) &&
            (identical(other.iosPlatformConstraints, iosPlatformConstraints) ||
                other.iosPlatformConstraints == iosPlatformConstraints) &&
            (identical(other.androidPlatformConstraints,
                    androidPlatformConstraints) ||
                other.androidPlatformConstraints ==
                    androidPlatformConstraints) &&
            (identical(other.sdkType, sdkType) || other.sdkType == sdkType) &&
            (identical(other.minSdkVersion, minSdkVersion) ||
                other.minSdkVersion == minSdkVersion) &&
            const DeepCollectionEquality()
                .equals(other.packageDependencies, packageDependencies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      packageName,
      packageVersion,
      packagePath,
      const DeepCollectionEquality().hash(interfaceDeclarations),
      const DeepCollectionEquality().hash(executableDeclarations),
      const DeepCollectionEquality().hash(fieldDeclarations),
      const DeepCollectionEquality().hash(typeAliasDeclarations),
      const DeepCollectionEquality().hash(semantics),
      iosPlatformConstraints,
      androidPlatformConstraints,
      sdkType,
      minSdkVersion,
      const DeepCollectionEquality().hash(packageDependencies));

  @override
  String toString() {
    return 'PackageApiStorageV3(packageName: $packageName, packageVersion: $packageVersion, packagePath: $packagePath, interfaceDeclarations: $interfaceDeclarations, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, typeAliasDeclarations: $typeAliasDeclarations, semantics: $semantics, iosPlatformConstraints: $iosPlatformConstraints, androidPlatformConstraints: $androidPlatformConstraints, sdkType: $sdkType, minSdkVersion: $minSdkVersion, packageDependencies: $packageDependencies)';
  }
}

/// @nodoc
abstract mixin class $PackageApiStorageV3CopyWith<$Res> {
  factory $PackageApiStorageV3CopyWith(
          PackageApiStorageV3 value, $Res Function(PackageApiStorageV3) _then) =
      _$PackageApiStorageV3CopyWithImpl;
  @useResult
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
      List<InterfaceDeclarationStorageV3> interfaceDeclarations,
      List<ExecutableDeclarationStorageV3> executableDeclarations,
      List<FieldDeclarationStorageV3> fieldDeclarations,
      List<TypeAliasDeclarationStorageV3> typeAliasDeclarations,
      Set<PackageApiSemantics> semantics,
      IOSPlatformConstraintsStorageV3? iosPlatformConstraints,
      AndroidPlatformConstraintsStorageV3? androidPlatformConstraints,
      SdkTypeStorageV3 sdkType,
      @VersionJsonConverter() Version minSdkVersion,
      List<PackageDependencyStorageV3> packageDependencies});

  $IOSPlatformConstraintsStorageV3CopyWith<$Res>? get iosPlatformConstraints;
  $AndroidPlatformConstraintsStorageV3CopyWith<$Res>?
      get androidPlatformConstraints;
}

/// @nodoc
class _$PackageApiStorageV3CopyWithImpl<$Res>
    implements $PackageApiStorageV3CopyWith<$Res> {
  _$PackageApiStorageV3CopyWithImpl(this._self, this._then);

  final PackageApiStorageV3 _self;
  final $Res Function(PackageApiStorageV3) _then;

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
    Object? packagePath = null,
    Object? interfaceDeclarations = null,
    Object? executableDeclarations = null,
    Object? fieldDeclarations = null,
    Object? typeAliasDeclarations = null,
    Object? semantics = null,
    Object? iosPlatformConstraints = freezed,
    Object? androidPlatformConstraints = freezed,
    Object? sdkType = null,
    Object? minSdkVersion = null,
    Object? packageDependencies = null,
  }) {
    return _then(_self.copyWith(
      packageName: null == packageName
          ? _self.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageVersion: freezed == packageVersion
          ? _self.packageVersion
          : packageVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      packagePath: null == packagePath
          ? _self.packagePath
          : packagePath // ignore: cast_nullable_to_non_nullable
              as String,
      interfaceDeclarations: null == interfaceDeclarations
          ? _self.interfaceDeclarations
          : interfaceDeclarations // ignore: cast_nullable_to_non_nullable
              as List<InterfaceDeclarationStorageV3>,
      executableDeclarations: null == executableDeclarations
          ? _self.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclarationStorageV3>,
      fieldDeclarations: null == fieldDeclarations
          ? _self.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclarationStorageV3>,
      typeAliasDeclarations: null == typeAliasDeclarations
          ? _self.typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclarationStorageV3>,
      semantics: null == semantics
          ? _self.semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      iosPlatformConstraints: freezed == iosPlatformConstraints
          ? _self.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraintsStorageV3?,
      androidPlatformConstraints: freezed == androidPlatformConstraints
          ? _self.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraintsStorageV3?,
      sdkType: null == sdkType
          ? _self.sdkType
          : sdkType // ignore: cast_nullable_to_non_nullable
              as SdkTypeStorageV3,
      minSdkVersion: null == minSdkVersion
          ? _self.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as Version,
      packageDependencies: null == packageDependencies
          ? _self.packageDependencies
          : packageDependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageDependencyStorageV3>,
    ));
  }

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IOSPlatformConstraintsStorageV3CopyWith<$Res>? get iosPlatformConstraints {
    if (_self.iosPlatformConstraints == null) {
      return null;
    }

    return $IOSPlatformConstraintsStorageV3CopyWith<$Res>(
        _self.iosPlatformConstraints!, (value) {
      return _then(_self.copyWith(iosPlatformConstraints: value));
    });
  }

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AndroidPlatformConstraintsStorageV3CopyWith<$Res>?
      get androidPlatformConstraints {
    if (_self.androidPlatformConstraints == null) {
      return null;
    }

    return $AndroidPlatformConstraintsStorageV3CopyWith<$Res>(
        _self.androidPlatformConstraints!, (value) {
      return _then(_self.copyWith(androidPlatformConstraints: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _PackageApiStorageV3 extends PackageApiStorageV3 {
  const _PackageApiStorageV3(
      {required this.packageName,
      required this.packageVersion,
      required this.packagePath,
      required final List<InterfaceDeclarationStorageV3> interfaceDeclarations,
      required final List<ExecutableDeclarationStorageV3>
          executableDeclarations,
      required final List<FieldDeclarationStorageV3> fieldDeclarations,
      required final List<TypeAliasDeclarationStorageV3> typeAliasDeclarations,
      required final Set<PackageApiSemantics> semantics,
      this.iosPlatformConstraints,
      this.androidPlatformConstraints,
      required this.sdkType,
      @VersionJsonConverter() required this.minSdkVersion,
      required final List<PackageDependencyStorageV3> packageDependencies})
      : _interfaceDeclarations = interfaceDeclarations,
        _executableDeclarations = executableDeclarations,
        _fieldDeclarations = fieldDeclarations,
        _typeAliasDeclarations = typeAliasDeclarations,
        _semantics = semantics,
        _packageDependencies = packageDependencies,
        super._();
  factory _PackageApiStorageV3.fromJson(Map<String, dynamic> json) =>
      _$PackageApiStorageV3FromJson(json);

  @override
  final String packageName;
  @override
  final String? packageVersion;
  @override
  final String packagePath;
  final List<InterfaceDeclarationStorageV3> _interfaceDeclarations;
  @override
  List<InterfaceDeclarationStorageV3> get interfaceDeclarations {
    if (_interfaceDeclarations is EqualUnmodifiableListView)
      return _interfaceDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_interfaceDeclarations);
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

  final List<TypeAliasDeclarationStorageV3> _typeAliasDeclarations;
  @override
  List<TypeAliasDeclarationStorageV3> get typeAliasDeclarations {
    if (_typeAliasDeclarations is EqualUnmodifiableListView)
      return _typeAliasDeclarations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_typeAliasDeclarations);
  }

  final Set<PackageApiSemantics> _semantics;
  @override
  Set<PackageApiSemantics> get semantics {
    if (_semantics is EqualUnmodifiableSetView) return _semantics;
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
  final List<PackageDependencyStorageV3> _packageDependencies;
  @override
  List<PackageDependencyStorageV3> get packageDependencies {
    if (_packageDependencies is EqualUnmodifiableListView)
      return _packageDependencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packageDependencies);
  }

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PackageApiStorageV3CopyWith<_PackageApiStorageV3> get copyWith =>
      __$PackageApiStorageV3CopyWithImpl<_PackageApiStorageV3>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PackageApiStorageV3ToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PackageApiStorageV3 &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.packageVersion, packageVersion) ||
                other.packageVersion == packageVersion) &&
            (identical(other.packagePath, packagePath) ||
                other.packagePath == packagePath) &&
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
            (identical(other.iosPlatformConstraints, iosPlatformConstraints) ||
                other.iosPlatformConstraints == iosPlatformConstraints) &&
            (identical(other.androidPlatformConstraints,
                    androidPlatformConstraints) ||
                other.androidPlatformConstraints ==
                    androidPlatformConstraints) &&
            (identical(other.sdkType, sdkType) || other.sdkType == sdkType) &&
            (identical(other.minSdkVersion, minSdkVersion) ||
                other.minSdkVersion == minSdkVersion) &&
            const DeepCollectionEquality()
                .equals(other._packageDependencies, _packageDependencies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      packageName,
      packageVersion,
      packagePath,
      const DeepCollectionEquality().hash(_interfaceDeclarations),
      const DeepCollectionEquality().hash(_executableDeclarations),
      const DeepCollectionEquality().hash(_fieldDeclarations),
      const DeepCollectionEquality().hash(_typeAliasDeclarations),
      const DeepCollectionEquality().hash(_semantics),
      iosPlatformConstraints,
      androidPlatformConstraints,
      sdkType,
      minSdkVersion,
      const DeepCollectionEquality().hash(_packageDependencies));

  @override
  String toString() {
    return 'PackageApiStorageV3(packageName: $packageName, packageVersion: $packageVersion, packagePath: $packagePath, interfaceDeclarations: $interfaceDeclarations, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, typeAliasDeclarations: $typeAliasDeclarations, semantics: $semantics, iosPlatformConstraints: $iosPlatformConstraints, androidPlatformConstraints: $androidPlatformConstraints, sdkType: $sdkType, minSdkVersion: $minSdkVersion, packageDependencies: $packageDependencies)';
  }
}

/// @nodoc
abstract mixin class _$PackageApiStorageV3CopyWith<$Res>
    implements $PackageApiStorageV3CopyWith<$Res> {
  factory _$PackageApiStorageV3CopyWith(_PackageApiStorageV3 value,
          $Res Function(_PackageApiStorageV3) _then) =
      __$PackageApiStorageV3CopyWithImpl;
  @override
  @useResult
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
      List<InterfaceDeclarationStorageV3> interfaceDeclarations,
      List<ExecutableDeclarationStorageV3> executableDeclarations,
      List<FieldDeclarationStorageV3> fieldDeclarations,
      List<TypeAliasDeclarationStorageV3> typeAliasDeclarations,
      Set<PackageApiSemantics> semantics,
      IOSPlatformConstraintsStorageV3? iosPlatformConstraints,
      AndroidPlatformConstraintsStorageV3? androidPlatformConstraints,
      SdkTypeStorageV3 sdkType,
      @VersionJsonConverter() Version minSdkVersion,
      List<PackageDependencyStorageV3> packageDependencies});

  @override
  $IOSPlatformConstraintsStorageV3CopyWith<$Res>? get iosPlatformConstraints;
  @override
  $AndroidPlatformConstraintsStorageV3CopyWith<$Res>?
      get androidPlatformConstraints;
}

/// @nodoc
class __$PackageApiStorageV3CopyWithImpl<$Res>
    implements _$PackageApiStorageV3CopyWith<$Res> {
  __$PackageApiStorageV3CopyWithImpl(this._self, this._then);

  final _PackageApiStorageV3 _self;
  final $Res Function(_PackageApiStorageV3) _then;

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? packageName = null,
    Object? packageVersion = freezed,
    Object? packagePath = null,
    Object? interfaceDeclarations = null,
    Object? executableDeclarations = null,
    Object? fieldDeclarations = null,
    Object? typeAliasDeclarations = null,
    Object? semantics = null,
    Object? iosPlatformConstraints = freezed,
    Object? androidPlatformConstraints = freezed,
    Object? sdkType = null,
    Object? minSdkVersion = null,
    Object? packageDependencies = null,
  }) {
    return _then(_PackageApiStorageV3(
      packageName: null == packageName
          ? _self.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      packageVersion: freezed == packageVersion
          ? _self.packageVersion
          : packageVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      packagePath: null == packagePath
          ? _self.packagePath
          : packagePath // ignore: cast_nullable_to_non_nullable
              as String,
      interfaceDeclarations: null == interfaceDeclarations
          ? _self._interfaceDeclarations
          : interfaceDeclarations // ignore: cast_nullable_to_non_nullable
              as List<InterfaceDeclarationStorageV3>,
      executableDeclarations: null == executableDeclarations
          ? _self._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclarationStorageV3>,
      fieldDeclarations: null == fieldDeclarations
          ? _self._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclarationStorageV3>,
      typeAliasDeclarations: null == typeAliasDeclarations
          ? _self._typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclarationStorageV3>,
      semantics: null == semantics
          ? _self._semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      iosPlatformConstraints: freezed == iosPlatformConstraints
          ? _self.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraintsStorageV3?,
      androidPlatformConstraints: freezed == androidPlatformConstraints
          ? _self.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraintsStorageV3?,
      sdkType: null == sdkType
          ? _self.sdkType
          : sdkType // ignore: cast_nullable_to_non_nullable
              as SdkTypeStorageV3,
      minSdkVersion: null == minSdkVersion
          ? _self.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as Version,
      packageDependencies: null == packageDependencies
          ? _self._packageDependencies
          : packageDependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageDependencyStorageV3>,
    ));
  }

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IOSPlatformConstraintsStorageV3CopyWith<$Res>? get iosPlatformConstraints {
    if (_self.iosPlatformConstraints == null) {
      return null;
    }

    return $IOSPlatformConstraintsStorageV3CopyWith<$Res>(
        _self.iosPlatformConstraints!, (value) {
      return _then(_self.copyWith(iosPlatformConstraints: value));
    });
  }

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AndroidPlatformConstraintsStorageV3CopyWith<$Res>?
      get androidPlatformConstraints {
    if (_self.androidPlatformConstraints == null) {
      return null;
    }

    return $AndroidPlatformConstraintsStorageV3CopyWith<$Res>(
        _self.androidPlatformConstraints!, (value) {
      return _then(_self.copyWith(androidPlatformConstraints: value));
    });
  }
}

// dart format on
