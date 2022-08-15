import 'dart:convert';

import 'package:dart_apitool/src/storage/v1/storage_v1.dart';

import '../model/model.dart';

abstract class PackageApiStorage {
  static PackageApi readFrom(String jsonString) {
    final jsonDom = jsonDecode(jsonString);
    final storageVersion = jsonDom['version'] as int;
    final packageApi = jsonDom['packageApi'] as Map<String, dynamic>;
    return _readFromVersion(storageVersion, packageApi);
  }

  static Map<String, dynamic> getStorageJson(PackageApi packageApi) {
    final packageApiStorage = _packageApiToStorage(packageApi);
    return packageApiStorage.toJson();
  }

  static PackageApi _readFromVersion(
      int storageVersion, Map<String, dynamic> packageApiDom) {
    switch (storageVersion) {
      case 1:
        final packageApiStorage = PackageApiStorageV1.fromJson(packageApiDom);
        return _packageApiStoreV1ToPackageApi(packageApiStorage);
      default:
        throw UnsupportedError(
            'Storage version $storageVersion not supported!');
    }
  }

  static PackageApi _packageApiStoreV1ToPackageApi(
      PackageApiStorageV1 packageApiStorage) {
    return packageApiStorage.toPackageApi();
  }

  static PackageApiStorageV1 _packageApiToStorage(PackageApi packageApi) {
    return PackageApiStorageV1.fromPackageAPi(packageApi);
  }
}
