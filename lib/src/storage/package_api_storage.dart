import 'dart:convert';

import 'package:dart_apitool/src/storage/v1/storage_v1.dart';
import 'package:dart_apitool/src/storage/v2/storage_v2.dart';

import '../model/model.dart';
import 'v3/storage_v3.dart';

/// provides access to the storage functionality for [PackageApi]s
/// makes sure to use the right version of the storage model when reading from storage
/// and uses the latest storage version when writing to storage
abstract class PackageApiStorage {
  /// reads the [PackageApi] from storage (JSON string)
  static PackageApi packageApiFromStorageJson(String jsonString) {
    final jsonDom = jsonDecode(jsonString);
    final storageVersion = jsonDom['version'] as int;
    final packageApi = jsonDom['packageApi'] as Map<String, dynamic>;
    return _readFromVersion(storageVersion, packageApi);
  }

  /// writes the [packageApi] to storage (JSON string)
  static String packageApitoStorageJson(PackageApi packageApi,
      {bool pretty = false}) {
    final packageApiStorage = _packageApiToStorage(packageApi);
    final encoder = pretty ? JsonEncoder.withIndent('    ') : JsonEncoder();
    return encoder.convert({
      'version': 3,
      'packageApi': packageApiStorage.toJson(),
    });
  }

  static PackageApi _readFromVersion(
      int storageVersion, Map<String, dynamic> packageApiDom) {
    switch (storageVersion) {
      case 1:
        final packageApiStorage = PackageApiStorageV1.fromJson(packageApiDom);
        return _packageApiStoreV1ToPackageApi(packageApiStorage);
      case 2:
        final packageApiStorage = PackageApiStorageV2.fromJson(packageApiDom);
        return _packageApiStoreV2ToPackageApi(packageApiStorage);
      case 3:
        final packageApiStorage = PackageApiStorageV3.fromJson(packageApiDom);
        return _packageApiStoreV3ToPackageApi(packageApiStorage);
      default:
        throw UnsupportedError(
            'Storage version $storageVersion not supported!');
    }
  }

  static PackageApi _packageApiStoreV1ToPackageApi(
      PackageApiStorageV1 packageApiStorage) {
    return packageApiStorage.toPackageApi();
  }

  static PackageApi _packageApiStoreV2ToPackageApi(
      PackageApiStorageV2 packageApiStorage) {
    return packageApiStorage.toPackageApi();
  }

  static PackageApi _packageApiStoreV3ToPackageApi(
      PackageApiStorageV3 packageApiStorage) {
    return packageApiStorage.toPackageApi();
  }

  static PackageApiStorageV3 _packageApiToStorage(PackageApi packageApi) {
    return PackageApiStorageV3.fromPackageAPi(packageApi);
  }
}
