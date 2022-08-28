// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'executable_declaration_storage_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExecutableParameterDeclarationStorageV2
    _$$_ExecutableParameterDeclarationStorageV2FromJson(
            Map<String, dynamic> json) =>
        _$_ExecutableParameterDeclarationStorageV2(
          isRequired: json['isRequired'] as bool,
          isNamed: json['isNamed'] as bool,
          name: json['name'] as String,
          isDeprecated: json['isDeprecated'] as bool,
          typeName: json['typeName'] as String,
        );

Map<String, dynamic> _$$_ExecutableParameterDeclarationStorageV2ToJson(
        _$_ExecutableParameterDeclarationStorageV2 instance) =>
    <String, dynamic>{
      'isRequired': instance.isRequired,
      'isNamed': instance.isNamed,
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'typeName': instance.typeName,
    };

_$_ExecutableDeclarationStorageV2 _$$_ExecutableDeclarationStorageV2FromJson(
        Map<String, dynamic> json) =>
    _$_ExecutableDeclarationStorageV2(
      returnTypeName: json['returnTypeName'] as String,
      name: json['name'] as String,
      isDeprecated: json['isDeprecated'] as bool,
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => ExecutableParameterDeclarationStorageV2.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      typeParameterNames: (json['typeParameterNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      type: $enumDecode(_$ExecutableTypeStorageV2EnumMap, json['type']),
      isStatic: json['isStatic'] as bool,
      entryPoints: (json['entryPoints'] as List<dynamic>)
          .map((e) => e as String)
          .toSet(),
    );

Map<String, dynamic> _$$_ExecutableDeclarationStorageV2ToJson(
        _$_ExecutableDeclarationStorageV2 instance) =>
    <String, dynamic>{
      'returnTypeName': instance.returnTypeName,
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'parameters': instance.parameters,
      'typeParameterNames': instance.typeParameterNames,
      'type': _$ExecutableTypeStorageV2EnumMap[instance.type]!,
      'isStatic': instance.isStatic,
      'entryPoints': instance.entryPoints.toList(),
    };

const _$ExecutableTypeStorageV2EnumMap = {
  ExecutableTypeStorageV2.method: 'method',
  ExecutableTypeStorageV2.constructor: 'constructor',
};
