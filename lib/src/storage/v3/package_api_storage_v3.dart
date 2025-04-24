import 'package:dart_apitool/api_tool.dart';
import 'package:dart_apitool/src/storage/v3/storage_v3.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart';
import '../utils/version_json_converter.dart';
import 'package_dependency_storage_v3.dart';

part 'package_api_storage_v3.freezed.dart';
part 'package_api_storage_v3.g.dart';

@freezed
sealed class PackageApiStorageV3 with _$PackageApiStorageV3 {
  const PackageApiStorageV3._();

  const factory PackageApiStorageV3({
    required String packageName,
    required String? packageVersion,
    required String packagePath,
    required List<InterfaceDeclarationStorageV3> interfaceDeclarations,
    required List<ExecutableDeclarationStorageV3> executableDeclarations,
    required List<FieldDeclarationStorageV3> fieldDeclarations,
    required List<TypeAliasDeclarationStorageV3> typeAliasDeclarations,
    required Set<PackageApiSemantics> semantics,
    IOSPlatformConstraintsStorageV3? iosPlatformConstraints,
    AndroidPlatformConstraintsStorageV3? androidPlatformConstraints,
    required SdkTypeStorageV3 sdkType,
    @VersionJsonConverter() required Version minSdkVersion,
    required List<PackageDependencyStorageV3> packageDependencies,
  }) = _PackageApiStorageV3;

  factory PackageApiStorageV3.fromJson(Map<String, Object?> json) =>
      _$PackageApiStorageV3FromJson(json);

  /// Returns a [PackageApiStorageV3] from a [PackageApi].
  static PackageApiStorageV3 fromPackageAPi(PackageApi packageApi) {
    return PackageApiStorageV3(
        packageName: packageApi.packageName,
        packageVersion: packageApi.packageVersion,
        packagePath: packageApi.packagePath,
        interfaceDeclarations: packageApi.interfaceDeclarations
            .map((c) =>
                InterfaceDeclarationStorageV3.fromInterfaceDeclaration(c))
            .toList(),
        executableDeclarations: packageApi.executableDeclarations
            .map((e) =>
                ExecutableDeclarationStorageV3.fromExecutableDeclaration(e))
            .toList(),
        fieldDeclarations: packageApi.fieldDeclarations
            .map((f) => FieldDeclarationStorageV3.fromFieldDeclaration(f))
            .toList(),
        typeAliasDeclarations: packageApi.typeAliasDeclarations
            .map((t) =>
                TypeAliasDeclarationStorageV3.fromTypeAliasDeclaration(t))
            .toList(),
        semantics: packageApi.semantics,
        iosPlatformConstraints:
            IOSPlatformConstraintsStorageV3.fromIOSPlatformConstraints(
                packageApi.iosPlatformConstraints),
        androidPlatformConstraints:
            AndroidPlatformConstraintsStorageV3.fromAndroidPlatformConstraints(
                packageApi.androidPlatformConstraints),
        sdkType: SdkTypeStorageV3.fromSdkType(packageApi.sdkType),
        minSdkVersion: packageApi.minSdkVersion,
        packageDependencies: packageApi.packageDependencies
            .map((d) => PackageDependencyStorageV3.fromPackageDependency(d))
            .toList());
  }
}
