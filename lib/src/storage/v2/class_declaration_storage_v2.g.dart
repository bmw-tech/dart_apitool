// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_declaration_storage_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClassDeclarationStorageV2 _$$_ClassDeclarationStorageV2FromJson(
        Map<String, dynamic> json) =>
    _$_ClassDeclarationStorageV2(
      name: json['name'] as String,
      isDeprecated: json['isDeprecated'] as bool,
      typeParameterNames: (json['typeParameterNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      superTypeNames: (json['superTypeNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      executableDeclarations: (json['executableDeclarations'] as List<dynamic>)
          .map((e) => ExecutableDeclarationStorageV2.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      fieldDeclarations: (json['fieldDeclarations'] as List<dynamic>)
          .map((e) =>
              FieldDeclarationStorageV2.fromJson(e as Map<String, dynamic>))
          .toList(),
      entryPoints: (json['entryPoints'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$$_ClassDeclarationStorageV2ToJson(
        _$_ClassDeclarationStorageV2 instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'typeParameterNames': instance.typeParameterNames,
      'superTypeNames': instance.superTypeNames,
      'executableDeclarations': instance.executableDeclarations,
      'fieldDeclarations': instance.fieldDeclarations,
      'entryPoints': instance.entryPoints?.toList(),
    };
