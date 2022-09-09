// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'type_alias_declaration_storage_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TypeAliasDeclarationStorageV2 _$$_TypeAliasDeclarationStorageV2FromJson(
        Map<String, dynamic> json) =>
    _$_TypeAliasDeclarationStorageV2(
      name: json['name'] as String,
      aliasedTypeName: json['aliasedTypeName'] as String,
      isDeprecated: json['isDeprecated'] as bool,
      entryPoints: (json['entryPoints'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$$_TypeAliasDeclarationStorageV2ToJson(
        _$_TypeAliasDeclarationStorageV2 instance) =>
    <String, dynamic>{
      'name': instance.name,
      'aliasedTypeName': instance.aliasedTypeName,
      'isDeprecated': instance.isDeprecated,
      'entryPoints': instance.entryPoints.toList(),
    };
