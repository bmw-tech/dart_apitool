import 'package:freezed_annotation/freezed_annotation.dart';

import 'class_declaration.dart';
import 'executable_declaration.dart';
import 'field_declaration.dart';

part 'package_api.freezed.dart';
part 'package_api.g.dart';

@freezed
class PackageApi with _$PackageApi {
  const factory PackageApi({
    required String packageName,
    required String? packageVersion,
    required String projectPath,
    required List<ClassDeclaration> classDeclarations,
    required List<ExecutableDeclaration> executableDeclarations,
    required List<FieldDeclaration> fieldDeclarations,
  }) = _PackageApi;

  factory PackageApi.fromJson(Map<String, Object?> json) =>
      _$PackageApiFromJson(json);
}
