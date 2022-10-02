import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'platform_constraints_storage_v2.freezed.dart';
part 'platform_constraints_storage_v2.g.dart';

@freezed
class IOSPlatformConstraintsStorageV2 with _$IOSPlatformConstraintsStorageV2 {
  const IOSPlatformConstraintsStorageV2._();

  const factory IOSPlatformConstraintsStorageV2({
    required num? minimumOsVersion,
  }) = _IOSPlatformConstraintsStorageV2;

  factory IOSPlatformConstraintsStorageV2.fromJson(Map<String, Object?> json) =>
      _$IOSPlatformConstraintsStorageV2FromJson(json);

  IOSPlatformConstraints toIOSPlatformConstraints() {
    return IOSPlatformConstraints(
      minimumOsVersion: minimumOsVersion,
    );
  }

  static IOSPlatformConstraintsStorageV2? fromIOSPlatformConstraints(
      IOSPlatformConstraints? iosPlatformConstraints) {
    if (iosPlatformConstraints == null) {
      return null;
    }
    return IOSPlatformConstraintsStorageV2(
      minimumOsVersion: iosPlatformConstraints.minimumOsVersion,
    );
  }
}

@freezed
class AndroidPlatformConstraintsStorageV2
    with _$AndroidPlatformConstraintsStorageV2 {
  const AndroidPlatformConstraintsStorageV2._();

  const factory AndroidPlatformConstraintsStorageV2({
    required int? minSdkVersion,
    required int? compileSdkVersion,
    required int? targetSdkVersion,
  }) = _AndroidPlatformConstraintsStorageV2;

  factory AndroidPlatformConstraintsStorageV2.fromJson(
          Map<String, Object?> json) =>
      _$AndroidPlatformConstraintsStorageV2FromJson(json);

  AndroidPlatformConstraints toAndroidPlatformConstraints() {
    return AndroidPlatformConstraints(
      minSdkVersion: minSdkVersion,
      compileSdkVersion: compileSdkVersion,
      targetSdkVersion: targetSdkVersion,
    );
  }

  static AndroidPlatformConstraintsStorageV2? fromAndroidPlatformConstraints(
      AndroidPlatformConstraints? constraints) {
    if (constraints == null) {
      return null;
    }
    return AndroidPlatformConstraintsStorageV2(
      minSdkVersion: constraints.minSdkVersion,
      compileSdkVersion: constraints.compileSdkVersion,
      targetSdkVersion: constraints.targetSdkVersion,
    );
  }
}
