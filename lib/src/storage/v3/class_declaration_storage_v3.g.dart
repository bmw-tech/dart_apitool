// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'class_declaration_storage_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClassDeclarationStorageV3 _$$_ClassDeclarationStorageV3FromJson(
        Map<String, dynamic> json) =>
    _$_ClassDeclarationStorageV3(
      name: json['name'] as String,
      isDeprecated: json['isDeprecated'] as bool,
      typeParameterNames: (json['typeParameterNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      superTypeNames: (json['superTypeNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      executableDeclarations: (json['executableDeclarations'] as List<dynamic>)
          .map((e) => ExecutableDeclarationStorageV3.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      fieldDeclarations: (json['fieldDeclarations'] as List<dynamic>)
          .map((e) =>
              FieldDeclarationStorageV3.fromJson(e as Map<String, dynamic>))
          .toList(),
      entryPoints: (json['entryPoints'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$$_ClassDeclarationStorageV3ToJson(
        _$_ClassDeclarationStorageV3 instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'typeParameterNames': instance.typeParameterNames,
      'superTypeNames': instance.superTypeNames,
      'executableDeclarations': instance.executableDeclarations,
      'fieldDeclarations': instance.fieldDeclarations,
      'entryPoints': instance.entryPoints.toList(),
    };
