// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'package_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PackageApi {
  /// name of the package
  String get packageName;

  /// version of the package
  String? get packageVersion;

  /// path to the package
  String get packagePath;

  /// interface declarations this package has
  List<InterfaceDeclaration> get interfaceDeclarations;

  /// root level executable declarations this package has
  List<ExecutableDeclaration> get executableDeclarations;

  /// root level field declarations this package has
  List<FieldDeclaration> get fieldDeclarations;

  /// type alias declarations this package has
  List<TypeAliasDeclaration> get typeAliasDeclarations;

  /// the semantics of this model. This indicates if this model is compatible (e.g. for diffing) with another model
  Set<PackageApiSemantics> get semantics;

  /// used Android platform constraints
  AndroidPlatformConstraints? get androidPlatformConstraints;

  /// used iOS platform constraints
  IOSPlatformConstraints? get iosPlatformConstraints;

  /// type of sdk needed
  SdkType get sdkType;

  /// package dependencies
  List<PackageDependency> get packageDependencies;

  /// minimum sdk version
  Version get minSdkVersion;

  /// the type hierarchy of the public API
  TypeHierarchy get typeHierarchy;

  /// Create a copy of PackageApi
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PackageApiCopyWith<PackageApi> get copyWith =>
      _$PackageApiCopyWithImpl<PackageApi>(this as PackageApi, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PackageApi &&
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
            (identical(other.androidPlatformConstraints,
                    androidPlatformConstraints) ||
                other.androidPlatformConstraints ==
                    androidPlatformConstraints) &&
            (identical(other.iosPlatformConstraints, iosPlatformConstraints) ||
                other.iosPlatformConstraints == iosPlatformConstraints) &&
            (identical(other.sdkType, sdkType) || other.sdkType == sdkType) &&
            const DeepCollectionEquality()
                .equals(other.packageDependencies, packageDependencies) &&
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
      const DeepCollectionEquality().hash(interfaceDeclarations),
      const DeepCollectionEquality().hash(executableDeclarations),
      const DeepCollectionEquality().hash(fieldDeclarations),
      const DeepCollectionEquality().hash(typeAliasDeclarations),
      const DeepCollectionEquality().hash(semantics),
      androidPlatformConstraints,
      iosPlatformConstraints,
      sdkType,
      const DeepCollectionEquality().hash(packageDependencies),
      minSdkVersion,
      typeHierarchy);

  @override
  String toString() {
    return 'PackageApi(packageName: $packageName, packageVersion: $packageVersion, packagePath: $packagePath, interfaceDeclarations: $interfaceDeclarations, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, typeAliasDeclarations: $typeAliasDeclarations, semantics: $semantics, androidPlatformConstraints: $androidPlatformConstraints, iosPlatformConstraints: $iosPlatformConstraints, sdkType: $sdkType, packageDependencies: $packageDependencies, minSdkVersion: $minSdkVersion, typeHierarchy: $typeHierarchy)';
  }
}

/// @nodoc
abstract mixin class $PackageApiCopyWith<$Res> {
  factory $PackageApiCopyWith(
          PackageApi value, $Res Function(PackageApi) _then) =
      _$PackageApiCopyWithImpl;
  @useResult
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
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
}

/// @nodoc
class _$PackageApiCopyWithImpl<$Res> implements $PackageApiCopyWith<$Res> {
  _$PackageApiCopyWithImpl(this._self, this._then);

  final PackageApi _self;
  final $Res Function(PackageApi) _then;

  /// Create a copy of PackageApi
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
    Object? androidPlatformConstraints = freezed,
    Object? iosPlatformConstraints = freezed,
    Object? sdkType = null,
    Object? packageDependencies = null,
    Object? minSdkVersion = null,
    Object? typeHierarchy = null,
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
              as List<InterfaceDeclaration>,
      executableDeclarations: null == executableDeclarations
          ? _self.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: null == fieldDeclarations
          ? _self.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
      typeAliasDeclarations: null == typeAliasDeclarations
          ? _self.typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclaration>,
      semantics: null == semantics
          ? _self.semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      androidPlatformConstraints: freezed == androidPlatformConstraints
          ? _self.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraints?,
      iosPlatformConstraints: freezed == iosPlatformConstraints
          ? _self.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraints?,
      sdkType: null == sdkType
          ? _self.sdkType
          : sdkType // ignore: cast_nullable_to_non_nullable
              as SdkType,
      packageDependencies: null == packageDependencies
          ? _self.packageDependencies
          : packageDependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageDependency>,
      minSdkVersion: null == minSdkVersion
          ? _self.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as Version,
      typeHierarchy: null == typeHierarchy
          ? _self.typeHierarchy
          : typeHierarchy // ignore: cast_nullable_to_non_nullable
              as TypeHierarchy,
    ));
  }

  /// Create a copy of PackageApi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AndroidPlatformConstraintsCopyWith<$Res>? get androidPlatformConstraints {
    if (_self.androidPlatformConstraints == null) {
      return null;
    }

    return $AndroidPlatformConstraintsCopyWith<$Res>(
        _self.androidPlatformConstraints!, (value) {
      return _then(_self.copyWith(androidPlatformConstraints: value));
    });
  }

  /// Create a copy of PackageApi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IOSPlatformConstraintsCopyWith<$Res>? get iosPlatformConstraints {
    if (_self.iosPlatformConstraints == null) {
      return null;
    }

    return $IOSPlatformConstraintsCopyWith<$Res>(_self.iosPlatformConstraints!,
        (value) {
      return _then(_self.copyWith(iosPlatformConstraints: value));
    });
  }
}

/// Adds pattern-matching-related methods to [PackageApi].
extension PackageApiPatterns on PackageApi {
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
    TResult Function(_PackageApi value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PackageApi() when $default != null:
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
    TResult Function(_PackageApi value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackageApi():
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
    TResult? Function(_PackageApi value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackageApi() when $default != null:
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
            String packageName,
            String? packageVersion,
            String packagePath,
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
            TypeHierarchy typeHierarchy)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PackageApi() when $default != null:
        return $default(
            _that.packageName,
            _that.packageVersion,
            _that.packagePath,
            _that.interfaceDeclarations,
            _that.executableDeclarations,
            _that.fieldDeclarations,
            _that.typeAliasDeclarations,
            _that.semantics,
            _that.androidPlatformConstraints,
            _that.iosPlatformConstraints,
            _that.sdkType,
            _that.packageDependencies,
            _that.minSdkVersion,
            _that.typeHierarchy);
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
            String packageName,
            String? packageVersion,
            String packagePath,
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
            TypeHierarchy typeHierarchy)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackageApi():
        return $default(
            _that.packageName,
            _that.packageVersion,
            _that.packagePath,
            _that.interfaceDeclarations,
            _that.executableDeclarations,
            _that.fieldDeclarations,
            _that.typeAliasDeclarations,
            _that.semantics,
            _that.androidPlatformConstraints,
            _that.iosPlatformConstraints,
            _that.sdkType,
            _that.packageDependencies,
            _that.minSdkVersion,
            _that.typeHierarchy);
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
            String packageName,
            String? packageVersion,
            String packagePath,
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
            TypeHierarchy typeHierarchy)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PackageApi() when $default != null:
        return $default(
            _that.packageName,
            _that.packageVersion,
            _that.packagePath,
            _that.interfaceDeclarations,
            _that.executableDeclarations,
            _that.fieldDeclarations,
            _that.typeAliasDeclarations,
            _that.semantics,
            _that.androidPlatformConstraints,
            _that.iosPlatformConstraints,
            _that.sdkType,
            _that.packageDependencies,
            _that.minSdkVersion,
            _that.typeHierarchy);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PackageApi extends PackageApi {
  const _PackageApi(
      {required this.packageName,
      required this.packageVersion,
      required this.packagePath,
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

  /// Create a copy of PackageApi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PackageApiCopyWith<_PackageApi> get copyWith =>
      __$PackageApiCopyWithImpl<_PackageApi>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PackageApi &&
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

  @override
  String toString() {
    return 'PackageApi(packageName: $packageName, packageVersion: $packageVersion, packagePath: $packagePath, interfaceDeclarations: $interfaceDeclarations, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, typeAliasDeclarations: $typeAliasDeclarations, semantics: $semantics, androidPlatformConstraints: $androidPlatformConstraints, iosPlatformConstraints: $iosPlatformConstraints, sdkType: $sdkType, packageDependencies: $packageDependencies, minSdkVersion: $minSdkVersion, typeHierarchy: $typeHierarchy)';
  }
}

/// @nodoc
abstract mixin class _$PackageApiCopyWith<$Res>
    implements $PackageApiCopyWith<$Res> {
  factory _$PackageApiCopyWith(
          _PackageApi value, $Res Function(_PackageApi) _then) =
      __$PackageApiCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
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
}

/// @nodoc
class __$PackageApiCopyWithImpl<$Res> implements _$PackageApiCopyWith<$Res> {
  __$PackageApiCopyWithImpl(this._self, this._then);

  final _PackageApi _self;
  final $Res Function(_PackageApi) _then;

  /// Create a copy of PackageApi
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
    Object? androidPlatformConstraints = freezed,
    Object? iosPlatformConstraints = freezed,
    Object? sdkType = null,
    Object? packageDependencies = null,
    Object? minSdkVersion = null,
    Object? typeHierarchy = null,
  }) {
    return _then(_PackageApi(
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
              as List<InterfaceDeclaration>,
      executableDeclarations: null == executableDeclarations
          ? _self._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclaration>,
      fieldDeclarations: null == fieldDeclarations
          ? _self._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclaration>,
      typeAliasDeclarations: null == typeAliasDeclarations
          ? _self._typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclaration>,
      semantics: null == semantics
          ? _self._semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      androidPlatformConstraints: freezed == androidPlatformConstraints
          ? _self.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraints?,
      iosPlatformConstraints: freezed == iosPlatformConstraints
          ? _self.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraints?,
      sdkType: null == sdkType
          ? _self.sdkType
          : sdkType // ignore: cast_nullable_to_non_nullable
              as SdkType,
      packageDependencies: null == packageDependencies
          ? _self._packageDependencies
          : packageDependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageDependency>,
      minSdkVersion: null == minSdkVersion
          ? _self.minSdkVersion
          : minSdkVersion // ignore: cast_nullable_to_non_nullable
              as Version,
      typeHierarchy: null == typeHierarchy
          ? _self.typeHierarchy
          : typeHierarchy // ignore: cast_nullable_to_non_nullable
              as TypeHierarchy,
    ));
  }

  /// Create a copy of PackageApi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AndroidPlatformConstraintsCopyWith<$Res>? get androidPlatformConstraints {
    if (_self.androidPlatformConstraints == null) {
      return null;
    }

    return $AndroidPlatformConstraintsCopyWith<$Res>(
        _self.androidPlatformConstraints!, (value) {
      return _then(_self.copyWith(androidPlatformConstraints: value));
    });
  }

  /// Create a copy of PackageApi
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IOSPlatformConstraintsCopyWith<$Res>? get iosPlatformConstraints {
    if (_self.iosPlatformConstraints == null) {
      return null;
    }

    return $IOSPlatformConstraintsCopyWith<$Res>(_self.iosPlatformConstraints!,
        (value) {
      return _then(_self.copyWith(iosPlatformConstraints: value));
    });
  }
}

// dart format on
