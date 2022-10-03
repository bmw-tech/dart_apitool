// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'platform_constraints_storage_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IOSPlatformConstraintsStorageV3 _$$_IOSPlatformConstraintsStorageV3FromJson(
        Map<String, dynamic> json) =>
    _$_IOSPlatformConstraintsStorageV3(
      minimumOsVersion: json['minimumOsVersion'] as num?,
    );

Map<String, dynamic> _$$_IOSPlatformConstraintsStorageV3ToJson(
        _$_IOSPlatformConstraintsStorageV3 instance) =>
    <String, dynamic>{
      'minimumOsVersion': instance.minimumOsVersion,
    };

_$_AndroidPlatformConstraintsStorageV3
    _$$_AndroidPlatformConstraintsStorageV3FromJson(
            Map<String, dynamic> json) =>
        _$_AndroidPlatformConstraintsStorageV3(
          minSdkVersion: json['minSdkVersion'] as int?,
          compileSdkVersion: json['compileSdkVersion'] as int?,
          targetSdkVersion: json['targetSdkVersion'] as int?,
        );

Map<String, dynamic> _$$_AndroidPlatformConstraintsStorageV3ToJson(
        _$_AndroidPlatformConstraintsStorageV3 instance) =>
    <String, dynamic>{
      'minSdkVersion': instance.minSdkVersion,
      'compileSdkVersion': instance.compileSdkVersion,
      'targetSdkVersion': instance.targetSdkVersion,
    };
