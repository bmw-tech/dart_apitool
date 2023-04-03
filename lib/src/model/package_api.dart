import 'package:dart_apitool/api_tool.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

part 'package_api.freezed.dart';

/// represents the model of a public package API.
@freezed
class PackageApi with _$PackageApi {
  const PackageApi._();

  const factory PackageApi({
    /// name of the package
    required String packageName,

    /// version of the package
    required String? packageVersion,

    /// path to the package
    required String packagePath,

    /// interface declarations this package has
    required List<InterfaceDeclaration> interfaceDeclarations,

    /// root level executable declarations this package has
    required List<ExecutableDeclaration> executableDeclarations,

    /// root level field declarations this package has
    required List<FieldDeclaration> fieldDeclarations,

    /// type alias declarations this package has
    required List<TypeAliasDeclaration> typeAliasDeclarations,

    /// the semantics of this model. This indicates if this model is compatible (e.g. for diffing) with another model
    @Default(<PackageApiSemantics>{}) Set<PackageApiSemantics> semantics,

    /// used Android platform constraints
    AndroidPlatformConstraints? androidPlatformConstraints,

    /// used iOS platform constraints
    IOSPlatformConstraints? iosPlatformConstraints,

    /// type of sdk needed
    required SdkType sdkType,

    /// package dependencies
    required List<PackageDependency> packageDependencies,

    /// minimum sdk version
    required Version minSdkVersion,

    /// the type hierarchy of the public API
    required TypeHierarchy typeHierarchy,
  }) = _PackageApi;

  /// returns all root level declarations of this package that don't have any entry points
  Iterable<Declaration> getRootDeclarationsWithoutEntryPoints() {
    return [
      ...interfaceDeclarations.where((id) => id.entryPoints?.isEmpty ?? false),
      ...executableDeclarations.where((ed) => ed.entryPoints?.isEmpty ?? false),
      ...typeAliasDeclarations
          .where((tad) => tad.entryPoints?.isEmpty ?? false),
      ...fieldDeclarations.where((fd) => fd.entryPoints?.isEmpty ?? false),
    ];
  }
}
