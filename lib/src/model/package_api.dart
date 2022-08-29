import 'package:dart_apitool/src/model/type_alias_declaration.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'class_declaration.dart';
import 'executable_declaration.dart';
import 'field_declaration.dart';
import 'package_api_semantics.dart';

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

    /// class declarations this package has
    required List<ClassDeclaration> classDeclarations,

    /// root level executable declarations this package has
    required List<ExecutableDeclaration> executableDeclarations,

    /// root level field declarations this package has
    required List<FieldDeclaration> fieldDeclarations,

    /// type alias declarations this package has
    required List<TypeAliasDeclaration> typeAliasDeclarations,

    /// the semantics of this model. This indicates if this model is compatible (e.g. for diffing) with another model
    @Default(<PackageApiSemantics>{}) Set<PackageApiSemantics> semantics,
  }) = _PackageApi;
}
