// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'package_dependency_storage_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PackageDependencyStorageV3 _$PackageDependencyStorageV3FromJson(
        Map<String, dynamic> json) =>
    _PackageDependencyStorageV3(
      packageName: json['packageName'] as String,
      packageVersion: json['packageVersion'] as String?,
    );

Map<String, dynamic> _$PackageDependencyStorageV3ToJson(
        _PackageDependencyStorageV3 instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
    };
