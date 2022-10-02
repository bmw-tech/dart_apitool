// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'package_api_storage_v2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PackageApiStorageV2 _$PackageApiStorageV2FromJson(Map<String, dynamic> json) {
  return _PackageApiStorageV2.fromJson(json);
}

/// @nodoc
mixin _$PackageApiStorageV2 {
  String get packageName => throw _privateConstructorUsedError;
  String? get packageVersion => throw _privateConstructorUsedError;
  String get packagePath => throw _privateConstructorUsedError;
  List<ClassDeclarationStorageV2> get classDeclarations =>
      throw _privateConstructorUsedError;
  List<ExecutableDeclarationStorageV2> get executableDeclarations =>
      throw _privateConstructorUsedError;
  List<FieldDeclarationStorageV2> get fieldDeclarations =>
      throw _privateConstructorUsedError;
  List<TypeAliasDeclarationStorageV2> get typeAliasDeclarations =>
      throw _privateConstructorUsedError;
  Set<PackageApiSemantics> get semantics => throw _privateConstructorUsedError;
  IOSPlatformConstraintsStorageV2? get iosPlatformConstraints =>
      throw _privateConstructorUsedError;
  AndroidPlatformConstraintsStorageV2? get androidPlatformConstraints =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackageApiStorageV2CopyWith<PackageApiStorageV2> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageApiStorageV2CopyWith<$Res> {
  factory $PackageApiStorageV2CopyWith(
          PackageApiStorageV2 value, $Res Function(PackageApiStorageV2) then) =
      _$PackageApiStorageV2CopyWithImpl<$Res>;
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
      List<ClassDeclarationStorageV2> classDeclarations,
      List<ExecutableDeclarationStorageV2> executableDeclarations,
      List<FieldDeclarationStorageV2> fieldDeclarations,
      List<TypeAliasDeclarationStorageV2> typeAliasDeclarations,
      Set<PackageApiSemantics> semantics,
      IOSPlatformConstraintsStorageV2? iosPlatformConstraints,
      AndroidPlatformConstraintsStorageV2? androidPlatformConstraints});

  $IOSPlatformConstraintsStorageV2CopyWith<$Res>? get iosPlatformConstraints;
  $AndroidPlatformConstraintsStorageV2CopyWith<$Res>?
      get androidPlatformConstraints;
}

/// @nodoc
class _$PackageApiStorageV2CopyWithImpl<$Res>
    implements $PackageApiStorageV2CopyWith<$Res> {
  _$PackageApiStorageV2CopyWithImpl(this._value, this._then);

  final PackageApiStorageV2 _value;
  // ignore: unused_field
  final $Res Function(PackageApiStorageV2) _then;

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
              as List<ClassDeclarationStorageV2>,
      executableDeclarations: executableDeclarations == freezed
          ? _value.executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclarationStorageV2>,
      fieldDeclarations: fieldDeclarations == freezed
          ? _value.fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclarationStorageV2>,
      typeAliasDeclarations: typeAliasDeclarations == freezed
          ? _value.typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclarationStorageV2>,
      semantics: semantics == freezed
          ? _value.semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      iosPlatformConstraints: iosPlatformConstraints == freezed
          ? _value.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraintsStorageV2?,
      androidPlatformConstraints: androidPlatformConstraints == freezed
          ? _value.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraintsStorageV2?,
    ));
  }

  @override
  $IOSPlatformConstraintsStorageV2CopyWith<$Res>? get iosPlatformConstraints {
    if (_value.iosPlatformConstraints == null) {
      return null;
    }

    return $IOSPlatformConstraintsStorageV2CopyWith<$Res>(
        _value.iosPlatformConstraints!, (value) {
      return _then(_value.copyWith(iosPlatformConstraints: value));
    });
  }

  @override
  $AndroidPlatformConstraintsStorageV2CopyWith<$Res>?
      get androidPlatformConstraints {
    if (_value.androidPlatformConstraints == null) {
      return null;
    }

    return $AndroidPlatformConstraintsStorageV2CopyWith<$Res>(
        _value.androidPlatformConstraints!, (value) {
      return _then(_value.copyWith(androidPlatformConstraints: value));
    });
  }
}

/// @nodoc
abstract class _$$_PackageApiStorageV2CopyWith<$Res>
    implements $PackageApiStorageV2CopyWith<$Res> {
  factory _$$_PackageApiStorageV2CopyWith(_$_PackageApiStorageV2 value,
          $Res Function(_$_PackageApiStorageV2) then) =
      __$$_PackageApiStorageV2CopyWithImpl<$Res>;
  @override
  $Res call(
      {String packageName,
      String? packageVersion,
      String packagePath,
      List<ClassDeclarationStorageV2> classDeclarations,
      List<ExecutableDeclarationStorageV2> executableDeclarations,
      List<FieldDeclarationStorageV2> fieldDeclarations,
      List<TypeAliasDeclarationStorageV2> typeAliasDeclarations,
      Set<PackageApiSemantics> semantics,
      IOSPlatformConstraintsStorageV2? iosPlatformConstraints,
      AndroidPlatformConstraintsStorageV2? androidPlatformConstraints});

  @override
  $IOSPlatformConstraintsStorageV2CopyWith<$Res>? get iosPlatformConstraints;
  @override
  $AndroidPlatformConstraintsStorageV2CopyWith<$Res>?
      get androidPlatformConstraints;
}

/// @nodoc
class __$$_PackageApiStorageV2CopyWithImpl<$Res>
    extends _$PackageApiStorageV2CopyWithImpl<$Res>
    implements _$$_PackageApiStorageV2CopyWith<$Res> {
  __$$_PackageApiStorageV2CopyWithImpl(_$_PackageApiStorageV2 _value,
      $Res Function(_$_PackageApiStorageV2) _then)
      : super(_value, (v) => _then(v as _$_PackageApiStorageV2));

  @override
  _$_PackageApiStorageV2 get _value => super._value as _$_PackageApiStorageV2;

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
  }) {
    return _then(_$_PackageApiStorageV2(
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
              as List<ClassDeclarationStorageV2>,
      executableDeclarations: executableDeclarations == freezed
          ? _value._executableDeclarations
          : executableDeclarations // ignore: cast_nullable_to_non_nullable
              as List<ExecutableDeclarationStorageV2>,
      fieldDeclarations: fieldDeclarations == freezed
          ? _value._fieldDeclarations
          : fieldDeclarations // ignore: cast_nullable_to_non_nullable
              as List<FieldDeclarationStorageV2>,
      typeAliasDeclarations: typeAliasDeclarations == freezed
          ? _value._typeAliasDeclarations
          : typeAliasDeclarations // ignore: cast_nullable_to_non_nullable
              as List<TypeAliasDeclarationStorageV2>,
      semantics: semantics == freezed
          ? _value._semantics
          : semantics // ignore: cast_nullable_to_non_nullable
              as Set<PackageApiSemantics>,
      iosPlatformConstraints: iosPlatformConstraints == freezed
          ? _value.iosPlatformConstraints
          : iosPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as IOSPlatformConstraintsStorageV2?,
      androidPlatformConstraints: androidPlatformConstraints == freezed
          ? _value.androidPlatformConstraints
          : androidPlatformConstraints // ignore: cast_nullable_to_non_nullable
              as AndroidPlatformConstraintsStorageV2?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PackageApiStorageV2 extends _PackageApiStorageV2 {
  const _$_PackageApiStorageV2(
      {required this.packageName,
      required this.packageVersion,
      required this.packagePath,
      required final List<ClassDeclarationStorageV2> classDeclarations,
      required final List<ExecutableDeclarationStorageV2>
          executableDeclarations,
      required final List<FieldDeclarationStorageV2> fieldDeclarations,
      required final List<TypeAliasDeclarationStorageV2> typeAliasDeclarations,
      required final Set<PackageApiSemantics> semantics,
      this.iosPlatformConstraints,
      this.androidPlatformConstraints})
      : _classDeclarations = classDeclarations,
        _executableDeclarations = executableDeclarations,
        _fieldDeclarations = fieldDeclarations,
        _typeAliasDeclarations = typeAliasDeclarations,
        _semantics = semantics,
        super._();

  factory _$_PackageApiStorageV2.fromJson(Map<String, dynamic> json) =>
      _$$_PackageApiStorageV2FromJson(json);

  @override
  final String packageName;
  @override
  final String? packageVersion;
  @override
  final String packagePath;
  final List<ClassDeclarationStorageV2> _classDeclarations;
  @override
  List<ClassDeclarationStorageV2> get classDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_classDeclarations);
  }

  final List<ExecutableDeclarationStorageV2> _executableDeclarations;
  @override
  List<ExecutableDeclarationStorageV2> get executableDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_executableDeclarations);
  }

  final List<FieldDeclarationStorageV2> _fieldDeclarations;
  @override
  List<FieldDeclarationStorageV2> get fieldDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fieldDeclarations);
  }

  final List<TypeAliasDeclarationStorageV2> _typeAliasDeclarations;
  @override
  List<TypeAliasDeclarationStorageV2> get typeAliasDeclarations {
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
  final IOSPlatformConstraintsStorageV2? iosPlatformConstraints;
  @override
  final AndroidPlatformConstraintsStorageV2? androidPlatformConstraints;

  @override
  String toString() {
    return 'PackageApiStorageV2(packageName: $packageName, packageVersion: $packageVersion, packagePath: $packagePath, classDeclarations: $classDeclarations, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations, typeAliasDeclarations: $typeAliasDeclarations, semantics: $semantics, iosPlatformConstraints: $iosPlatformConstraints, androidPlatformConstraints: $androidPlatformConstraints)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackageApiStorageV2 &&
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
                other.androidPlatformConstraints, androidPlatformConstraints));
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
      const DeepCollectionEquality().hash(androidPlatformConstraints));

  @JsonKey(ignore: true)
  @override
  _$$_PackageApiStorageV2CopyWith<_$_PackageApiStorageV2> get copyWith =>
      __$$_PackageApiStorageV2CopyWithImpl<_$_PackageApiStorageV2>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackageApiStorageV2ToJson(
      this,
    );
  }
}

abstract class _PackageApiStorageV2 extends PackageApiStorageV2 {
  const factory _PackageApiStorageV2(
      {required final String packageName,
      required final String? packageVersion,
      required final String packagePath,
      required final List<ClassDeclarationStorageV2> classDeclarations,
      required final List<ExecutableDeclarationStorageV2>
          executableDeclarations,
      required final List<FieldDeclarationStorageV2> fieldDeclarations,
      required final List<TypeAliasDeclarationStorageV2> typeAliasDeclarations,
      required final Set<PackageApiSemantics> semantics,
      final IOSPlatformConstraintsStorageV2? iosPlatformConstraints,
      final AndroidPlatformConstraintsStorageV2?
          androidPlatformConstraints}) = _$_PackageApiStorageV2;
  const _PackageApiStorageV2._() : super._();

  factory _PackageApiStorageV2.fromJson(Map<String, dynamic> json) =
      _$_PackageApiStorageV2.fromJson;

  @override
  String get packageName;
  @override
  String? get packageVersion;
  @override
  String get packagePath;
  @override
  List<ClassDeclarationStorageV2> get classDeclarations;
  @override
  List<ExecutableDeclarationStorageV2> get executableDeclarations;
  @override
  List<FieldDeclarationStorageV2> get fieldDeclarations;
  @override
  List<TypeAliasDeclarationStorageV2> get typeAliasDeclarations;
  @override
  Set<PackageApiSemantics> get semantics;
  @override
  IOSPlatformConstraintsStorageV2? get iosPlatformConstraints;
  @override
  AndroidPlatformConstraintsStorageV2? get androidPlatformConstraints;
  @override
  @JsonKey(ignore: true)
  _$$_PackageApiStorageV2CopyWith<_$_PackageApiStorageV2> get copyWith =>
      throw _privateConstructorUsedError;
}
