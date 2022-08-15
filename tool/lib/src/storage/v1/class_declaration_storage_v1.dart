// ignore: unused_import
import 'package:analyzer/dart/element/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';
import 'executable_declaration_storage_v1.dart';
import 'field_declaration_storage_v1.dart';

part 'class_declaration_storage_v1.freezed.dart';
part 'class_declaration_storage_v1.g.dart';

/// Represents a found class declaration
@freezed
class ClassDeclarationStorageV1 with _$ClassDeclarationStorageV1 {
  const ClassDeclarationStorageV1._();

  const factory ClassDeclarationStorageV1({
    required String name,
    required bool isDeprecated,
    required List<String> typeParameterNames,
    required List<String> superTypeNames,
    required List<ExecutableDeclarationStorageV1> executableDeclarations,
    required List<FieldDeclarationStorageV1> fieldDeclarations,
  }) = _ClassDeclarationStorageV1;

  factory ClassDeclarationStorageV1.fromJson(Map<String, Object?> json) =>
      _$ClassDeclarationStorageV1FromJson(json);

  ClassDeclaration toClassDeclaration() {
    return ClassDeclaration(
      name: name,
      isDeprecated: isDeprecated,
      typeParameterNames: typeParameterNames,
      superTypeNames: superTypeNames,
      executableDeclarations: executableDeclarations
          .map((e) => e.toExecutableDeclaration())
          .toList(),
      fieldDeclarations:
          fieldDeclarations.map((f) => f.toFieldDeclaration()).toList(),
    );
  }

  static ClassDeclarationStorageV1 fromClassDeclaration(
      ClassDeclaration classDeclaration) {
    return ClassDeclarationStorageV1(
      name: classDeclaration.name,
      isDeprecated: classDeclaration.isDeprecated,
      typeParameterNames: classDeclaration.typeParameterNames,
      superTypeNames: classDeclaration.superTypeNames,
      executableDeclarations: classDeclaration.executableDeclarations
          .map((e) =>
              ExecutableDeclarationStorageV1.fromExecutableDeclaration(e))
          .toList(),
      fieldDeclarations: classDeclaration.fieldDeclarations
          .map((f) => FieldDeclarationStorageV1.fromFieldDeclaration(f))
          .toList(),
    );
  }
}
