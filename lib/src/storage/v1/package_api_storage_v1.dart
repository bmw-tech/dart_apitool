import 'package:dart_apitool/src/model/package_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'class_declaration_storage_v1.dart';
import 'executable_declaration_storage_v1.dart';
import 'field_declaration_storage_v1.dart';

part 'package_api_storage_v1.freezed.dart';
part 'package_api_storage_v1.g.dart';

@freezed
class PackageApiStorageV1 with _$PackageApiStorageV1 {
  const PackageApiStorageV1._();

  const factory PackageApiStorageV1({
    required String packageName,
    required String? packageVersion,
    required String packagePath,
    required List<ClassDeclarationStorageV1> classDeclarations,
    required List<ExecutableDeclarationStorageV1> executableDeclarations,
    required List<FieldDeclarationStorageV1> fieldDeclarations,
    Set<String>? semantics,
  }) = _PackageApiStorageV1;

  factory PackageApiStorageV1.fromJson(Map<String, Object?> json) =>
      _$PackageApiStorageV1FromJson(json);

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
      // not supported by this storage version
      typeAliasDeclarations: [],
      semantics: semantics ?? {},
    );
  }

  static PackageApiStorageV1 fromPackageAPi(PackageApi packageApi) {
    return PackageApiStorageV1(
      packageName: packageApi.packageName,
      packageVersion: packageApi.packageVersion,
      packagePath: packageApi.packagePath,
      classDeclarations: packageApi.classDeclarations
          .map((c) => ClassDeclarationStorageV1.fromClassDeclaration(c))
          .toList(),
      executableDeclarations: packageApi.executableDeclarations
          .map((e) =>
              ExecutableDeclarationStorageV1.fromExecutableDeclaration(e))
          .toList(),
      fieldDeclarations: packageApi.fieldDeclarations
          .map((f) => FieldDeclarationStorageV1.fromFieldDeclaration(f))
          .toList(),
      semantics: packageApi.semantics,
    );
  }
}
