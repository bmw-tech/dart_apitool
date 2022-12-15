// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'field_declaration_storage_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FieldDeclarationStorageV3 _$$_FieldDeclarationStorageV3FromJson(
        Map<String, dynamic> json) =>
    _$_FieldDeclarationStorageV3(
      typeName: json['typeName'] as String,
      name: json['name'] as String,
      isDeprecated: json['isDeprecated'] as bool,
      isExperimental: json['isExperimental'] as bool,
      isStatic: json['isStatic'] as bool,
      entryPoints: (json['entryPoints'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
      relativePath: json['relativePath'] as String,
    );

Map<String, dynamic> _$$_FieldDeclarationStorageV3ToJson(
        _$_FieldDeclarationStorageV3 instance) =>
    <String, dynamic>{
      'typeName': instance.typeName,
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'isExperimental': instance.isExperimental,
      'isStatic': instance.isStatic,
      'entryPoints': instance.entryPoints.toList(),
      'relativePath': instance.relativePath,
    };
