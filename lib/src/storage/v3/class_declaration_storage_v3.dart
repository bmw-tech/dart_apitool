// ignore: unused_import
import 'package:analyzer/dart/element/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';
import 'executable_declaration_storage_v3.dart';
import 'field_declaration_storage_v3.dart';

part 'class_declaration_storage_v3.freezed.dart';
part 'class_declaration_storage_v3.g.dart';

/// Represents a found class declaration
@freezed
class ClassDeclarationStorageV3 with _$ClassDeclarationStorageV3 {
  const ClassDeclarationStorageV3._();

  const factory ClassDeclarationStorageV3({
    required String name,
    required bool isDeprecated,
    required List<String> typeParameterNames,
    required List<String> superTypeNames,
    required List<ExecutableDeclarationStorageV3> executableDeclarations,
    required List<FieldDeclarationStorageV3> fieldDeclarations,
    required Set<String> entryPoints,
  }) = _ClassDeclarationStorageV3;

  factory ClassDeclarationStorageV3.fromJson(Map<String, Object?> json) =>
      _$ClassDeclarationStorageV3FromJson(json);

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
      entryPoints: entryPoints,
    );
  }

  static ClassDeclarationStorageV3 fromClassDeclaration(
      ClassDeclaration classDeclaration) {
    return ClassDeclarationStorageV3(
      name: classDeclaration.name,
      isDeprecated: classDeclaration.isDeprecated,
      typeParameterNames: classDeclaration.typeParameterNames,
      superTypeNames: classDeclaration.superTypeNames,
      executableDeclarations: classDeclaration.executableDeclarations
          .map((e) =>
              ExecutableDeclarationStorageV3.fromExecutableDeclaration(e))
          .toList(),
      fieldDeclarations: classDeclaration.fieldDeclarations
          .map((f) => FieldDeclarationStorageV3.fromFieldDeclaration(f))
          .toList(),
      entryPoints: classDeclaration.entryPoints!,
    );
  }
}
