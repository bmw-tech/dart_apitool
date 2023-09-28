// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'type_alias_declaration_storage_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TypeAliasDeclarationStorageV3Impl
    _$$TypeAliasDeclarationStorageV3ImplFromJson(Map<String, dynamic> json) =>
        _$TypeAliasDeclarationStorageV3Impl(
          name: json['name'] as String,
          aliasedTypeName: json['aliasedTypeName'] as String,
          isDeprecated: json['isDeprecated'] as bool,
          isExperimental: json['isExperimental'] as bool,
          entryPoints: (json['entryPoints'] as List<dynamic>)
              .map((e) => e as String)
              .toSet(),
          relativePath: json['relativePath'] as String,
        );

Map<String, dynamic> _$$TypeAliasDeclarationStorageV3ImplToJson(
        _$TypeAliasDeclarationStorageV3Impl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'aliasedTypeName': instance.aliasedTypeName,
      'isDeprecated': instance.isDeprecated,
      'isExperimental': instance.isExperimental,
      'entryPoints': instance.entryPoints.toList(),
      'relativePath': instance.relativePath,
    };
