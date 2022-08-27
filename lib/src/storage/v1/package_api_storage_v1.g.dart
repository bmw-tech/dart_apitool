// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_api_storage_v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PackageApiStorageV1 _$$_PackageApiStorageV1FromJson(
        Map<String, dynamic> json) =>
    _$_PackageApiStorageV1(
      packageName: json['packageName'] as String,
      packageVersion: json['packageVersion'] as String?,
      packagePath: json['packagePath'] as String,
      classDeclarations: (json['classDeclarations'] as List<dynamic>)
          .map((e) =>
              ClassDeclarationStorageV1.fromJson(e as Map<String, dynamic>))
          .toList(),
      executableDeclarations: (json['executableDeclarations'] as List<dynamic>)
          .map((e) => ExecutableDeclarationStorageV1.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      fieldDeclarations: (json['fieldDeclarations'] as List<dynamic>)
          .map((e) =>
              FieldDeclarationStorageV1.fromJson(e as Map<String, dynamic>))
          .toList(),
      semantics: (json['semantics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$$_PackageApiStorageV1ToJson(
        _$_PackageApiStorageV1 instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'packagePath': instance.packagePath,
      'classDeclarations': instance.classDeclarations,
      'executableDeclarations': instance.executableDeclarations,
      'fieldDeclarations': instance.fieldDeclarations,
      'semantics': instance.semantics?.toList(),
    };
