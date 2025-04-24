// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'platform_constraints_storage_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IOSPlatformConstraintsStorageV3 _$IOSPlatformConstraintsStorageV3FromJson(
        Map<String, dynamic> json) =>
    _IOSPlatformConstraintsStorageV3(
      minimumOsVersion: json['minimumOsVersion'] as num?,
    );

Map<String, dynamic> _$IOSPlatformConstraintsStorageV3ToJson(
        _IOSPlatformConstraintsStorageV3 instance) =>
    <String, dynamic>{
      'minimumOsVersion': instance.minimumOsVersion,
    };

_AndroidPlatformConstraintsStorageV3
    _$AndroidPlatformConstraintsStorageV3FromJson(Map<String, dynamic> json) =>
        _AndroidPlatformConstraintsStorageV3(
          minSdkVersion: (json['minSdkVersion'] as num?)?.toInt(),
          compileSdkVersion: (json['compileSdkVersion'] as num?)?.toInt(),
          targetSdkVersion: (json['targetSdkVersion'] as num?)?.toInt(),
        );

Map<String, dynamic> _$AndroidPlatformConstraintsStorageV3ToJson(
        _AndroidPlatformConstraintsStorageV3 instance) =>
    <String, dynamic>{
      'minSdkVersion': instance.minSdkVersion,
      'compileSdkVersion': instance.compileSdkVersion,
      'targetSdkVersion': instance.targetSdkVersion,
    };
