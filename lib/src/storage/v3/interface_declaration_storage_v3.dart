// ignore: unused_import
import 'package:analyzer/dart/element/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';
import 'executable_declaration_storage_v3.dart';
import 'field_declaration_storage_v3.dart';

part 'interface_declaration_storage_v3.freezed.dart';
part 'interface_declaration_storage_v3.g.dart';

/// Represents a found class declaration
@freezed
class InterfaceDeclarationStorageV3 with _$InterfaceDeclarationStorageV3 {
  const InterfaceDeclarationStorageV3._();

  const factory InterfaceDeclarationStorageV3({
    required String name,
    required bool isDeprecated,
    required bool isExperimental,
    required bool isSealed,
    required bool isRequired,
    required List<String> typeParameterNames,
    required List<String> superTypeNames,
    required List<ExecutableDeclarationStorageV3> executableDeclarations,
    required List<FieldDeclarationStorageV3> fieldDeclarations,
    required Set<String> entryPoints,
    required String relativePath,
  }) = _InterfaceDeclarationStorageV3;

  factory InterfaceDeclarationStorageV3.fromJson(Map<String, Object?> json) =>
      _$InterfaceDeclarationStorageV3FromJson(json);

  static InterfaceDeclarationStorageV3 fromInterfaceDeclaration(
      InterfaceDeclaration interfaceDeclaration) {
    return InterfaceDeclarationStorageV3(
      name: interfaceDeclaration.name,
      isDeprecated: interfaceDeclaration.isDeprecated,
      isExperimental: interfaceDeclaration.isExperimental,
      isSealed: interfaceDeclaration.isSealed,
      isRequired: interfaceDeclaration.isRequired,
      typeParameterNames: interfaceDeclaration.typeParameterNames,
      superTypeNames: interfaceDeclaration.superTypeNames,
      executableDeclarations: interfaceDeclaration.executableDeclarations
          .map((e) =>
              ExecutableDeclarationStorageV3.fromExecutableDeclaration(e))
          .toList(),
      fieldDeclarations: interfaceDeclaration.fieldDeclarations
          .map((f) => FieldDeclarationStorageV3.fromFieldDeclaration(f))
          .toList(),
      entryPoints: interfaceDeclaration.entryPoints!,
      relativePath: interfaceDeclaration.relativePath,
    );
  }
}
