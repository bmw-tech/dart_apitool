// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'project_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProjectApi _$ProjectApiFromJson(Map<String, dynamic> json) {
  return _ProjectApi.fromJson(json);
}

/// @nodoc
mixin _$ProjectApi {
  String get projectName => throw _privateConstructorUsedError;
  String get projectPath => throw _privateConstructorUsedError;
  List<ClassDeclaration> get classDeclarations =>
      throw _privateConstructorUsedError;
  List<ExecutableDeclaration> get executableDeclarations =>
      throw _privateConstructorUsedError;
  List<FieldDeclaration> get fieldDeclarations =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProjectApiCopyWith<ProjectApi> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectApiCopyWith<$Res> {
  factory $ProjectApiCopyWith(
          ProjectApi value, $Res Function(ProjectApi) then) =
      _$ProjectApiCopyWithImpl<$Res>;
  $Res call(
      {String projectName,
      String projectPath,
      List<ClassDeclaration> classDeclarations,
      List<ExecutableDeclaration> executableDeclarations,
      List<FieldDeclaration> fieldDeclarations});
}

/// @nodoc
class _$ProjectApiCopyWithImpl<$Res> implements $ProjectApiCopyWith<$Res> {
  _$ProjectApiCopyWithImpl(this._value, this._then);

  final ProjectApi _value;
  // ignore: unused_field
  final $Res Function(ProjectApi) _then;

  @override
  $Res call({
    Object? projectName = freezed,
    Object? projectPath = freezed,
    Object? classDeclarations = freezed,
    Object? executableDeclarations = freezed,
    Object? fieldDeclarations = freezed,
  }) {
    return _then(_value.copyWith(
      projectName: projectName == freezed
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      projectPath: projectPath == freezed
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
abstract class _$$_ProjectApiCopyWith<$Res>
    implements $ProjectApiCopyWith<$Res> {
  factory _$$_ProjectApiCopyWith(
          _$_ProjectApi value, $Res Function(_$_ProjectApi) then) =
      __$$_ProjectApiCopyWithImpl<$Res>;
  @override
  $Res call(
      {String projectName,
      String projectPath,
      List<ClassDeclaration> classDeclarations,
      List<ExecutableDeclaration> executableDeclarations,
      List<FieldDeclaration> fieldDeclarations});
}

/// @nodoc
class __$$_ProjectApiCopyWithImpl<$Res> extends _$ProjectApiCopyWithImpl<$Res>
    implements _$$_ProjectApiCopyWith<$Res> {
  __$$_ProjectApiCopyWithImpl(
      _$_ProjectApi _value, $Res Function(_$_ProjectApi) _then)
      : super(_value, (v) => _then(v as _$_ProjectApi));

  @override
  _$_ProjectApi get _value => super._value as _$_ProjectApi;

  @override
  $Res call({
    Object? projectName = freezed,
    Object? projectPath = freezed,
    Object? classDeclarations = freezed,
    Object? executableDeclarations = freezed,
    Object? fieldDeclarations = freezed,
  }) {
    return _then(_$_ProjectApi(
      projectName: projectName == freezed
          ? _value.projectName
          : projectName // ignore: cast_nullable_to_non_nullable
              as String,
      projectPath: projectPath == freezed
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProjectApi implements _ProjectApi {
  const _$_ProjectApi(
      {required this.projectName,
      required this.projectPath,
      required final List<ClassDeclaration> classDeclarations,
      required final List<ExecutableDeclaration> executableDeclarations,
      required final List<FieldDeclaration> fieldDeclarations})
      : _classDeclarations = classDeclarations,
        _executableDeclarations = executableDeclarations,
        _fieldDeclarations = fieldDeclarations;

  factory _$_ProjectApi.fromJson(Map<String, dynamic> json) =>
      _$$_ProjectApiFromJson(json);

  @override
  final String projectName;
  @override
  final String projectPath;
  final List<ClassDeclaration> _classDeclarations;
  @override
  List<ClassDeclaration> get classDeclarations {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_classDeclarations);
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
    return 'ProjectApi(projectName: $projectName, projectPath: $projectPath, classDeclarations: $classDeclarations, executableDeclarations: $executableDeclarations, fieldDeclarations: $fieldDeclarations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectApi &&
            const DeepCollectionEquality()
                .equals(other.projectName, projectName) &&
            const DeepCollectionEquality()
                .equals(other.projectPath, projectPath) &&
            const DeepCollectionEquality()
                .equals(other._classDeclarations, _classDeclarations) &&
            const DeepCollectionEquality().equals(
                other._executableDeclarations, _executableDeclarations) &&
            const DeepCollectionEquality()
                .equals(other._fieldDeclarations, _fieldDeclarations));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(projectName),
      const DeepCollectionEquality().hash(projectPath),
      const DeepCollectionEquality().hash(_classDeclarations),
      const DeepCollectionEquality().hash(_executableDeclarations),
      const DeepCollectionEquality().hash(_fieldDeclarations));

  @JsonKey(ignore: true)
  @override
  _$$_ProjectApiCopyWith<_$_ProjectApi> get copyWith =>
      __$$_ProjectApiCopyWithImpl<_$_ProjectApi>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProjectApiToJson(
      this,
    );
  }
}

abstract class _ProjectApi implements ProjectApi {
  const factory _ProjectApi(
      {required final String projectName,
      required final String projectPath,
      required final List<ClassDeclaration> classDeclarations,
      required final List<ExecutableDeclaration> executableDeclarations,
      required final List<FieldDeclaration> fieldDeclarations}) = _$_ProjectApi;

  factory _ProjectApi.fromJson(Map<String, dynamic> json) =
      _$_ProjectApi.fromJson;

  @override
  String get projectName;
  @override
  String get projectPath;
  @override
  List<ClassDeclaration> get classDeclarations;
  @override
  List<ExecutableDeclaration> get executableDeclarations;
  @override
  List<FieldDeclaration> get fieldDeclarations;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectApiCopyWith<_$_ProjectApi> get copyWith =>
      throw _privateConstructorUsedError;
}
