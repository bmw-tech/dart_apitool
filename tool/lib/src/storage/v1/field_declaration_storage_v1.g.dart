// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_declaration_storage_v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FieldDeclarationStorageV1 _$$_FieldDeclarationStorageV1FromJson(
        Map<String, dynamic> json) =>
    _$_FieldDeclarationStorageV1(
      typeName: json['typeName'] as String,
      name: json['name'] as String,
      isDeprecated: json['isDeprecated'] as bool,
      isStatic: json['isStatic'] as bool,
    );

Map<String, dynamic> _$$_FieldDeclarationStorageV1ToJson(
        _$_FieldDeclarationStorageV1 instance) =>
    <String, dynamic>{
      'typeName': instance.typeName,
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'isStatic': instance.isStatic,
    };
