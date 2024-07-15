// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_api_storage_v3.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PackageApiStorageV3 _$PackageApiStorageV3FromJson(Map<String, dynamic> json) {
  return _PackageApiStorageV3.fromJson(json);
}

/// @nodoc
mixin _$PackageApiStorageV3 {
  String get packageName => throw _privateConstructorUsedError;
  String? get packageVersion => throw _privateConstructorUsedError;
  String get packagePath => throw _privateConstructorUsedError;
  List<InterfaceDeclarationStorageV3> get interfaceDeclarations =>
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
  List<PackageDependencyStorageV3> get packageDependencies =>
      throw _privateConstructorUsedError;

  /// Serializes this PackageApiStorageV3 to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PackageApiStorageV3CopyWith<PackageApiStorageV3> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageApiStorageV3CopyWith<$Res> {
  factory $PackageApiStorageV3CopyWith(
          PackageApiStorageV3 value, $Res Function(PackageApiStorageV3) then) =
      _$PackageApiStorageV3CopyWithImpl<$Res, PackageApiStorageV3>;
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
class _$PackageApiStorageV3CopyWithImpl<$Res, $Val extends PackageApiStorageV3>
    implements $PackageApiStorageV3CopyWith<$Res> {
  _$PackageApiStorageV3CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
      interfaceDeclarations: null == interfaceDeclarations
          ? _value.interfaceDeclarations
          : interfaceDeclarations // ignore: cast_nullable_to_non_nullable
              as List<InterfaceDeclarationStorageV3>,
      executableDeclarations: null == executableDeclarations
          ? _value.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclarationStorageV3>,
      fieldDeclarations: null == fieldDeclarations
          ? _value.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclarationStorageV3>,
      typeAliasDeclarations: null == typeAliasDeclarations
          ? _value.typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclarationStorageV3>,
      semantics: null == semantics
          ? _value.semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      iosPlatformConstraints: freezed == iosPlatformConstraints
          ? _value.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraintsStorageV3?,
      androidPlatformConstraints: freezed == androidPlatformConstraints
          ? _value.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraintsStorageV3?,
      sdkType: null == sdkType
          ? _value.sdkType
          : sdkType // ignore: cast_nullable_to_non_nullable
              as SdkTypeStorageV3,
      minSdkVersion: null == minSdkVersion
          ? _value.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as Version,
      packageDependencies: null == packageDependencies
          ? _value.packageDependencies
          : packageDependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageDependencyStorageV3>,
    ) as $Val);
  }

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IOSPlatformConstraintsStorageV3CopyWith<$Res>? get iosPlatformConstraints {
    if (_value.iosPlatformConstraints == null) {
      return null;
    }

    return $IOSPlatformConstraintsStorageV3CopyWith<$Res>(
        _value.iosPlatformConstraints!, (value) {
      return _then(_value.copyWith(iosPlatformConstraints: value) as $Val);
    });
  }

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AndroidPlatformConstraintsStorageV3CopyWith<$Res>?
      get androidPlatformConstraints {
    if (_value.androidPlatformConstraints == null) {
      return null;
    }

    return $AndroidPlatformConstraintsStorageV3CopyWith<$Res>(
        _value.androidPlatformConstraints!, (value) {
      return _then(_value.copyWith(androidPlatformConstraints: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PackageApiStorageV3ImplCopyWith<$Res>
    implements $PackageApiStorageV3CopyWith<$Res> {
  factory _$$PackageApiStorageV3ImplCopyWith(_$PackageApiStorageV3Impl value,
          $Res Function(_$PackageApiStorageV3Impl) then) =
      __$$PackageApiStorageV3ImplCopyWithImpl<$Res>;
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
class __$$PackageApiStorageV3ImplCopyWithImpl<$Res>
    extends _$PackageApiStorageV3CopyWithImpl<$Res, _$PackageApiStorageV3Impl>
    implements _$$PackageApiStorageV3ImplCopyWith<$Res> {
  __$$PackageApiStorageV3ImplCopyWithImpl(_$PackageApiStorageV3Impl _value,
      $Res Function(_$PackageApiStorageV3Impl) _then)
      : super(_value, _then);

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
    return _then(_$PackageApiStorageV3Impl(
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
      interfaceDeclarations: null == interfaceDeclarations
          ? _value._interfaceDeclarations
          : interfaceDeclarations // ignore: cast_nullable_to_non_nullable
              as List<InterfaceDeclarationStorageV3>,
      executableDeclarations: null == executableDeclarations
          ? _value._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclarationStorageV3>,
      fieldDeclarations: null == fieldDeclarations
          ? _value._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclarationStorageV3>,
      typeAliasDeclarations: null == typeAliasDeclarations
          ? _value._typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclarationStorageV3>,
      semantics: null == semantics
          ? _value._semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      iosPlatformConstraints: freezed == iosPlatformConstraints
          ? _value.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraintsStorageV3?,
      androidPlatformConstraints: freezed == androidPlatformConstraints
          ? _value.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraintsStorageV3?,
      sdkType: null == sdkType
          ? _value.sdkType
          : sdkType // ignore: cast_nullable_to_non_nullable
              as SdkTypeStorageV3,
      minSdkVersion: null == minSdkVersion
          ? _value.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as Version,
      packageDependencies: null == packageDependencies
          ? _value._packageDependencies
          : packageDependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageDependencyStorageV3>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PackageApiStorageV3Impl extends _PackageApiStorageV3 {
  const _$PackageApiStorageV3Impl(
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

  factory _$PackageApiStorageV3Impl.fromJson(Map<String, dynamic> json) =>
      _$$PackageApiStorageV3ImplFromJson(json);

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

  @override
  String toString() {
    return 'PackageApiStorageV3(packageName: $packageName, packageVersion: $packageVersion, packagePath: $packagePath, interfaceDeclarations: $interfaceDeclarations, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, typeAliasDeclarations: $typeAliasDeclarations, semantics: $semantics, iosPlatformConstraints: $iosPlatformConstraints, androidPlatformConstraints: $androidPlatformConstraints, sdkType: $sdkType, minSdkVersion: $minSdkVersion, packageDependencies: $packageDependencies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackageApiStorageV3Impl &&
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

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PackageApiStorageV3ImplCopyWith<_$PackageApiStorageV3Impl> get copyWith =>
      __$$PackageApiStorageV3ImplCopyWithImpl<_$PackageApiStorageV3Impl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackageApiStorageV3ImplToJson(
      this,
    );
  }
}

abstract class _PackageApiStorageV3 extends PackageApiStorageV3 {
  const factory _PackageApiStorageV3(
      {required final String packageName,
      required final String? packageVersion,
      required final String packagePath,
      required final List<InterfaceDeclarationStorageV3> interfaceDeclarations,
      required final List<ExecutableDeclarationStorageV3>
          executableDeclarations,
      required final List<FieldDeclarationStorageV3> fieldDeclarations,
      required final List<TypeAliasDeclarationStorageV3> typeAliasDeclarations,
      required final Set<PackageApiSemantics> semantics,
      final IOSPlatformConstraintsStorageV3? iosPlatformConstraints,
      final AndroidPlatformConstraintsStorageV3? androidPlatformConstraints,
      required final SdkTypeStorageV3 sdkType,
      @VersionJsonConverter() required final Version minSdkVersion,
      required final List<PackageDependencyStorageV3>
          packageDependencies}) = _$PackageApiStorageV3Impl;
  const _PackageApiStorageV3._() : super._();

  factory _PackageApiStorageV3.fromJson(Map<String, dynamic> json) =
      _$PackageApiStorageV3Impl.fromJson;

  @override
  String get packageName;
  @override
  String? get packageVersion;
  @override
  String get packagePath;
  @override
  List<InterfaceDeclarationStorageV3> get interfaceDeclarations;
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
  List<PackageDependencyStorageV3> get packageDependencies;

  /// Create a copy of PackageApiStorageV3
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PackageApiStorageV3ImplCopyWith<_$PackageApiStorageV3Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
