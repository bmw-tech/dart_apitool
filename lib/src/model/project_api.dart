import 'package:freezed_annotation/freezed_annotation.dart';

import 'class_declaration.dart';
import 'executable_declaration.dart';
import 'field_declaration.dart';

part 'project_api.freezed.dart';
part 'project_api.g.dart';

@freezed
class ProjectApi with _$ProjectApi {
  const factory ProjectApi({
    required String packageName,
    required String projectPath,
    required List<ClassDeclaration> classDeclarations,
    required List<ExecutableDeclaration> executableDeclarations,
    required List<FieldDeclaration> fieldDeclarations,
  }) = _ProjectApi;

  factory ProjectApi.fromJson(Map<String, Object?> json) =>
      _$ProjectApiFromJson(json);
}
