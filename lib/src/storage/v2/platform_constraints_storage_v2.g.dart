// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'platform_constraints_storage_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IOSPlatformConstraintsStorageV2 _$$_IOSPlatformConstraintsStorageV2FromJson(
        Map<String, dynamic> json) =>
    _$_IOSPlatformConstraintsStorageV2(
      minimumOsVersion: json['minimumOsVersion'] as num?,
    );

Map<String, dynamic> _$$_IOSPlatformConstraintsStorageV2ToJson(
        _$_IOSPlatformConstraintsStorageV2 instance) =>
    <String, dynamic>{
      'minimumOsVersion': instance.minimumOsVersion,
    };

_$_AndroidPlatformConstraintsStorageV2
    _$$_AndroidPlatformConstraintsStorageV2FromJson(
            Map<String, dynamic> json) =>
        _$_AndroidPlatformConstraintsStorageV2(
          minSdkVersion: json['minSdkVersion'] as int?,
          compileSdkVersion: json['compileSdkVersion'] as int?,
          targetSdkVersion: json['targetSdkVersion'] as int?,
        );

Map<String, dynamic> _$$_AndroidPlatformConstraintsStorageV2ToJson(
        _$_AndroidPlatformConstraintsStorageV2 instance) =>
    <String, dynamic>{
      'minSdkVersion': instance.minSdkVersion,
      'compileSdkVersion': instance.compileSdkVersion,
      'targetSdkVersion': instance.targetSdkVersion,
    };
