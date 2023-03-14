import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'package_dependency_storage_v3.freezed.dart';
part 'package_dependency_storage_v3.g.dart';

/// represents a package dependency
@freezed
class PackageDependencyStorageV3 with _$PackageDependencyStorageV3 {
  const PackageDependencyStorageV3._();

  const factory PackageDependencyStorageV3({
    required String packageName,
    required String? packageVersion,
  }) = _PackageDependencyStorageV3;

  factory PackageDependencyStorageV3.fromJson(Map<String, Object?> json) =>
      _$PackageDependencyStorageV3FromJson(json);

  static PackageDependencyStorageV3 fromPackageDependency(
      PackageDependency packageDependency) {
    return PackageDependencyStorageV3(
      packageName: packageDependency.packageName,
      packageVersion: packageDependency.packageVersion,
    );
  }
}
