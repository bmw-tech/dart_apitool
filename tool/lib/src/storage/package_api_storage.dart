import 'dart:convert';

import 'package:dart_apitool/src/storage/v1/storage_v1.dart';

import '../model/model.dart';

abstract class PackageApiStorage {
  static PackageApi packageApiFromStorageJson(String jsonString) {
    final jsonDom = jsonDecode(jsonString);
    final storageVersion = jsonDom['version'] as int;
    final packageApi = jsonDom['packageApi'] as Map<String, dynamic>;
    return _readFromVersion(storageVersion, packageApi);
  }

  static String packageApitoStorageJson(PackageApi packageApi) {
    final packageApiStorage = _packageApiToStorage(packageApi);
    return jsonEncode({
      'version': 1,
      'packageApi': packageApiStorage.toJson(),
    });
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
