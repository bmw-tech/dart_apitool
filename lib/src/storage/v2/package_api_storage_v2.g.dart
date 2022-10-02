// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'package_api_storage_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PackageApiStorageV2 _$$_PackageApiStorageV2FromJson(
        Map<String, dynamic> json) =>
    _$_PackageApiStorageV2(
      packageName: json['packageName'] as String,
      packageVersion: json['packageVersion'] as String?,
      packagePath: json['packagePath'] as String,
      classDeclarations: (json['classDeclarations'] as List<dynamic>)
          .map((e) =>
              ClassDeclarationStorageV2.fromJson(e as Map<String, dynamic>))
          .toList(),
      executableDeclarations: (json['executableDeclarations'] as List<dynamic>)
          .map((e) => ExecutableDeclarationStorageV2.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      fieldDeclarations: (json['fieldDeclarations'] as List<dynamic>)
          .map((e) =>
              FieldDeclarationStorageV2.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeAliasDeclarations: (json['typeAliasDeclarations'] as List<dynamic>)
          .map((e) =>
              TypeAliasDeclarationStorageV2.fromJson(e as Map<String, dynamic>))
          .toList(),
      semantics: (json['semantics'] as List<dynamic>)
          .map((e) => $enumDecode(_$PackageApiSemanticsEnumMap, e))
          .toSet(),
      iosPlatformConstraints: json['iosPlatformConstraints'] == null
          ? null
          : IOSPlatformConstraintsStorageV2.fromJson(
              json['iosPlatformConstraints'] as Map<String, dynamic>),
      androidPlatformConstraints: json['androidPlatformConstraints'] == null
          ? null
          : AndroidPlatformConstraintsStorageV2.fromJson(
              json['androidPlatformConstraints'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PackageApiStorageV2ToJson(
        _$_PackageApiStorageV2 instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'packagePath': instance.packagePath,
      'classDeclarations': instance.classDeclarations,
      'executableDeclarations': instance.executableDeclarations,
      'fieldDeclarations': instance.fieldDeclarations,
      'typeAliasDeclarations': instance.typeAliasDeclarations,
      'semantics': instance.semantics
          .map((e) => _$PackageApiSemanticsEnumMap[e]!)
          .toList(),
      'iosPlatformConstraints': instance.iosPlatformConstraints,
      'androidPlatformConstraints': instance.androidPlatformConstraints,
    };

const _$PackageApiSemanticsEnumMap = {
  PackageApiSemantics.mergeBaseClasses: 'mergeBaseClasses',
};
