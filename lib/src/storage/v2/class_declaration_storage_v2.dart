// ignore: unused_import
import 'package:analyzer/dart/element/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';
import 'executable_declaration_storage_v2.dart';
import 'field_declaration_storage_v2.dart';

part 'class_declaration_storage_v2.freezed.dart';
part 'class_declaration_storage_v2.g.dart';

/// Represents a found class declaration
@freezed
class ClassDeclarationStorageV2 with _$ClassDeclarationStorageV2 {
  const ClassDeclarationStorageV2._();

  const factory ClassDeclarationStorageV2({
    required String name,
    required bool isDeprecated,
    required List<String> typeParameterNames,
    required List<String> superTypeNames,
    required List<ExecutableDeclarationStorageV2> executableDeclarations,
    required List<FieldDeclarationStorageV2> fieldDeclarations,
    Set<String>? entryPoints,
  }) = _ClassDeclarationStorageV2;

  factory ClassDeclarationStorageV2.fromJson(Map<String, Object?> json) =>
      _$ClassDeclarationStorageV2FromJson(json);

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

  static ClassDeclarationStorageV2 fromClassDeclaration(
      ClassDeclaration classDeclaration) {
    return ClassDeclarationStorageV2(
      name: classDeclaration.name,
      isDeprecated: classDeclaration.isDeprecated,
      typeParameterNames: classDeclaration.typeParameterNames,
      superTypeNames: classDeclaration.superTypeNames,
      executableDeclarations: classDeclaration.executableDeclarations
          .map((e) =>
              ExecutableDeclarationStorageV2.fromExecutableDeclaration(e))
          .toList(),
      fieldDeclarations: classDeclaration.fieldDeclarations
          .map((f) => FieldDeclarationStorageV2.fromFieldDeclaration(f))
          .toList(),
      entryPoints: classDeclaration.entryPoints,
    );
  }
}
