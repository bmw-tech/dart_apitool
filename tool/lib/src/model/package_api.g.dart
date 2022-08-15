// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PackageApi _$$_PackageApiFromJson(Map<String, dynamic> json) =>
    _$_PackageApi(
      packageName: json['packageName'] as String,
      packageVersion: json['packageVersion'] as String?,
      packagePath: json['packagePath'] as String,
      classDeclarations: (json['classDeclarations'] as List<dynamic>)
          .map((e) => ClassDeclaration.fromJson(e as Map<String, dynamic>))
          .toList(),
      executableDeclarations: (json['executableDeclarations'] as List<dynamic>)
          .map((e) => ExecutableDeclaration.fromJson(e as Map<String, dynamic>))
          .toList(),
      fieldDeclarations: (json['fieldDeclarations'] as List<dynamic>)
          .map((e) => FieldDeclaration.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PackageApiToJson(_$_PackageApi instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'packagePath': instance.packagePath,
      'classDeclarations': instance.classDeclarations,
      'executableDeclarations': instance.executableDeclarations,
      'fieldDeclarations': instance.fieldDeclarations,
    };
