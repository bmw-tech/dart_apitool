import 'package:freezed_annotation/freezed_annotation.dart';

part 'platform_constraints.freezed.dart';

@freezed

/// represents iOS platform constraints
class IOSPlatformConstraints with _$IOSPlatformConstraints {
  const factory IOSPlatformConstraints({
    /// minimum iOS version
    required num? minimumOsVersion,
  }) = _IOSPlatformConstraints;
}

@freezed

/// represents Android platform constraints
class AndroidPlatformConstraints with _$AndroidPlatformConstraints {
  const factory AndroidPlatformConstraints({
    /// minimum SDK version
    required int? minSdkVersion,

    /// compile SDK version
    required int? compileSdkVersion,

    /// target SDK version
    required int? targetSdkVersion,
  }) = _AndroidPlatformConstraints;
}
