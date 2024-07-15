// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'platform_constraints_storage_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IOSPlatformConstraintsStorageV3Impl
    _$$IOSPlatformConstraintsStorageV3ImplFromJson(Map<String, dynamic> json) =>
        _$IOSPlatformConstraintsStorageV3Impl(
          minimumOsVersion: json['minimumOsVersion'] as num?,
        );

Map<String, dynamic> _$$IOSPlatformConstraintsStorageV3ImplToJson(
        _$IOSPlatformConstraintsStorageV3Impl instance) =>
    <String, dynamic>{
      'minimumOsVersion': instance.minimumOsVersion,
    };

_$AndroidPlatformConstraintsStorageV3Impl
    _$$AndroidPlatformConstraintsStorageV3ImplFromJson(
            Map<String, dynamic> json) =>
        _$AndroidPlatformConstraintsStorageV3Impl(
          minSdkVersion: (json['minSdkVersion'] as num?)?.toInt(),
          compileSdkVersion: (json['compileSdkVersion'] as num?)?.toInt(),
          targetSdkVersion: (json['targetSdkVersion'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$AndroidPlatformConstraintsStorageV3ImplToJson(
        _$AndroidPlatformConstraintsStorageV3Impl instance) =>
    <String, dynamic>{
      'minSdkVersion': instance.minSdkVersion,
      'compileSdkVersion': instance.compileSdkVersion,
      'targetSdkVersion': instance.targetSdkVersion,
    };
