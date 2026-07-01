import 'dart:convert';

import '../model/model.dart';
import 'v3/storage_v3.dart';

/// provides access to the storage functionality for [PackageApi]s
/// makes sure to use the right version of the storage model when reading from storage
/// and uses the latest storage version when writing to storage
abstract class PackageApiStorage {
  /// writes the [packageApi] to storage (JSON string)
  static String packageApitoStorageJson(
    PackageApi packageApi, {
    bool pretty = false,
  }) {
    final packageApiStorage = _packageApiToStorage(packageApi);
    final encoder = pretty ? JsonEncoder.withIndent('    ') : JsonEncoder();
    return encoder.convert({
      'version': 3,
      'packageApi': packageApiStorage.toJson(),
      'missingEntryPoints':
          packageApi.rootDeclarationsWithoutEntryPointsAndVisibleOutsideTests
              .map((e) => {
                    'type': switch (e) {
                      InterfaceDeclaration() => 'interface',
                      ExecutableDeclaration() => 'executable',
                      FieldDeclaration() => 'field',
                      TypeAliasDeclaration() => 'typeAlias',
                      Declaration() => throw UnimplementedError(),
                    },
                    if (e is InterfaceDeclaration)
                      'usages': e.typeUsages
                          .where((tu) => !tu.isVisibleForTesting)
                          .map((tu) => tu.referringElementName)
                          .toList(),
                    'name': e.name
                  })
              .toList(),
    });
  }

  static PackageApiStorageV3 _packageApiToStorage(PackageApi packageApi) {
    return PackageApiStorageV3.fromPackageAPi(packageApi);
  }
}
