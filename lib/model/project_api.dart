import 'package:dart_apitool/model/class_declaration.dart';
import 'package:dart_apitool/model/executable_declaration.dart';
import 'package:dart_apitool/model/field_declaration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_api.freezed.dart';
part 'project_api.g.dart';

@freezed
class ProjectApi with _$ProjectApi {
  const factory ProjectApi({
    required String projectName,
    required String projectPath,
    required List<ClassDeclaration> classDeclarations,
    required List<ExecutableDeclaration> executableDeclarations,
    required List<FieldDeclaration> fieldDeclarations,
  }) = _ProjectApi;

  factory ProjectApi.fromJson(Map<String, Object?> json) =>
      _$ProjectApiFromJson(json);
}
