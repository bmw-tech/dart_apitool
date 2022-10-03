import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'platform_constraints_storage_v3.freezed.dart';
part 'platform_constraints_storage_v3.g.dart';

@freezed
class IOSPlatformConstraintsStorageV3 with _$IOSPlatformConstraintsStorageV3 {
  const IOSPlatformConstraintsStorageV3._();

  const factory IOSPlatformConstraintsStorageV3({
    required num? minimumOsVersion,
  }) = _IOSPlatformConstraintsStorageV3;

  factory IOSPlatformConstraintsStorageV3.fromJson(Map<String, Object?> json) =>
      _$IOSPlatformConstraintsStorageV3FromJson(json);

  IOSPlatformConstraints toIOSPlatformConstraints() {
    return IOSPlatformConstraints(
      minimumOsVersion: minimumOsVersion,
    );
  }

  static IOSPlatformConstraintsStorageV3? fromIOSPlatformConstraints(
      IOSPlatformConstraints? iosPlatformConstraints) {
    if (iosPlatformConstraints == null) {
      return null;
    }
    return IOSPlatformConstraintsStorageV3(
      minimumOsVersion: iosPlatformConstraints.minimumOsVersion,
    );
  }
}

@freezed
class AndroidPlatformConstraintsStorageV3
    with _$AndroidPlatformConstraintsStorageV3 {
  const AndroidPlatformConstraintsStorageV3._();

  const factory AndroidPlatformConstraintsStorageV3({
    required int? minSdkVersion,
    required int? compileSdkVersion,
    required int? targetSdkVersion,
  }) = _AndroidPlatformConstraintsStorageV3;

  factory AndroidPlatformConstraintsStorageV3.fromJson(
          Map<String, Object?> json) =>
      _$AndroidPlatformConstraintsStorageV3FromJson(json);

  AndroidPlatformConstraints toAndroidPlatformConstraints() {
    return AndroidPlatformConstraints(
      minSdkVersion: minSdkVersion,
      compileSdkVersion: compileSdkVersion,
      targetSdkVersion: targetSdkVersion,
    );
  }

  static AndroidPlatformConstraintsStorageV3? fromAndroidPlatformConstraints(
      AndroidPlatformConstraints? constraints) {
    if (constraints == null) {
      return null;
    }
    return AndroidPlatformConstraintsStorageV3(
      minSdkVersion: constraints.minSdkVersion,
      compileSdkVersion: constraints.compileSdkVersion,
      targetSdkVersion: constraints.targetSdkVersion,
    );
  }
}
