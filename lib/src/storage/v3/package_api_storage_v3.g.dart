// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'package_api_storage_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PackageApiStorageV3 _$$_PackageApiStorageV3FromJson(
        Map<String, dynamic> json) =>
    _$_PackageApiStorageV3(
      packageName: json['packageName'] as String,
      packageVersion: json['packageVersion'] as String?,
      packagePath: json['packagePath'] as String,
      classDeclarations: (json['classDeclarations'] as List<dynamic>)
          .map((e) =>
              ClassDeclarationStorageV3.fromJson(e as Map<String, dynamic>))
          .toList(),
      executableDeclarations: (json['executableDeclarations'] as List<dynamic>)
          .map((e) => ExecutableDeclarationStorageV3.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      fieldDeclarations: (json['fieldDeclarations'] as List<dynamic>)
          .map((e) =>
              FieldDeclarationStorageV3.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeAliasDeclarations: (json['typeAliasDeclarations'] as List<dynamic>)
          .map((e) =>
              TypeAliasDeclarationStorageV3.fromJson(e as Map<String, dynamic>))
          .toList(),
      semantics: (json['semantics'] as List<dynamic>)
          .map((e) => $enumDecode(_$PackageApiSemanticsEnumMap, e))
          .toSet(),
      iosPlatformConstraints: json['iosPlatformConstraints'] == null
          ? null
          : IOSPlatformConstraintsStorageV3.fromJson(
              json['iosPlatformConstraints'] as Map<String, dynamic>),
      androidPlatformConstraints: json['androidPlatformConstraints'] == null
          ? null
          : AndroidPlatformConstraintsStorageV3.fromJson(
              json['androidPlatformConstraints'] as Map<String, dynamic>),
      sdkType: $enumDecode(_$SdkTypeStorageV3EnumMap, json['sdkType']),
      minSdkVersion: const VersionJsonConverter()
          .fromJson(json['minSdkVersion'] as String),
    );

Map<String, dynamic> _$$_PackageApiStorageV3ToJson(
        _$_PackageApiStorageV3 instance) =>
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
      'sdkType': _$SdkTypeStorageV3EnumMap[instance.sdkType]!,
      'minSdkVersion':
          const VersionJsonConverter().toJson(instance.minSdkVersion),
    };

const _$PackageApiSemanticsEnumMap = {
  PackageApiSemantics.mergeBaseClasses: 'mergeBaseClasses',
  PackageApiSemantics.containsPlatformConstraints:
      'containsPlatformConstraints',
};

const _$SdkTypeStorageV3EnumMap = {
  SdkTypeStorageV3.flutter: 'flutter',
  SdkTypeStorageV3.dart: 'dart',
  SdkTypeStorageV3.unknown: 'unknown',
};
