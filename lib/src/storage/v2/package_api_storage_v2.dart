import 'package:dart_apitool/src/model/package_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'class_declaration_storage_v2.dart';
import 'executable_declaration_storage_v2.dart';
import 'field_declaration_storage_v2.dart';
import 'type_alias_declaration_storage_v2.dart';

part 'package_api_storage_v2.freezed.dart';
part 'package_api_storage_v2.g.dart';

@freezed
class PackageApiStorageV2 with _$PackageApiStorageV2 {
  const PackageApiStorageV2._();

  const factory PackageApiStorageV2({
    required String packageName,
    required String? packageVersion,
    required String packagePath,
    required List<ClassDeclarationStorageV2> classDeclarations,
    required List<ExecutableDeclarationStorageV2> executableDeclarations,
    required List<FieldDeclarationStorageV2> fieldDeclarations,
    required List<TypeAliasDeclarationStorageV2> typeAliasDeclarations,
    Set<String>? semantics,
  }) = _PackageApiStorageV2;

  factory PackageApiStorageV2.fromJson(Map<String, Object?> json) =>
      _$PackageApiStorageV2FromJson(json);

  PackageApi toPackageApi() {
    return PackageApi(
      packageName: packageName,
      packageVersion: packageVersion,
      packagePath: packagePath,
      classDeclarations:
          classDeclarations.map((cd) => cd.toClassDeclaration()).toList(),
      executableDeclarations: executableDeclarations
          .map((e) => e.toExecutableDeclaration())
          .toList(),
      fieldDeclarations:
          fieldDeclarations.map((f) => f.toFieldDeclaration()).toList(),
      typeAliasDeclarations:
          typeAliasDeclarations.map((t) => t.toTypeAliasDeclaration()).toList(),
      semantics: semantics ?? {},
    );
  }

  static PackageApiStorageV2 fromPackageAPi(PackageApi packageApi) {
    return PackageApiStorageV2(
      packageName: packageApi.packageName,
      packageVersion: packageApi.packageVersion,
      packagePath: packageApi.packagePath,
      classDeclarations: packageApi.classDeclarations
          .map((c) => ClassDeclarationStorageV2.fromClassDeclaration(c))
          .toList(),
      executableDeclarations: packageApi.executableDeclarations
          .map((e) =>
              ExecutableDeclarationStorageV2.fromExecutableDeclaration(e))
          .toList(),
      fieldDeclarations: packageApi.fieldDeclarations
          .map((f) => FieldDeclarationStorageV2.fromFieldDeclaration(f))
          .toList(),
      typeAliasDeclarations: packageApi.typeAliasDeclarations
          .map((t) => TypeAliasDeclarationStorageV2.fromTypeAliasDeclaration(t))
          .toList(),
      semantics: packageApi.semantics,
    );
  }
}
