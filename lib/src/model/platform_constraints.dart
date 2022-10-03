import 'package:freezed_annotation/freezed_annotation.dart';

part 'platform_constraints.freezed.dart';

@freezed
class IOSPlatformConstraints with _$IOSPlatformConstraints {
  const factory IOSPlatformConstraints({
    required num? minimumOsVersion,
  }) = _IOSPlatformConstraints;
}

@freezed
class AndroidPlatformConstraints with _$AndroidPlatformConstraints {
  const factory AndroidPlatformConstraints({
    required int? minSdkVersion,
    required int? compileSdkVersion,
    required int? targetSdkVersion,
  }) = _AndroidPlatformConstraints;
}
