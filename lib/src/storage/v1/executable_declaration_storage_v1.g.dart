// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'executable_declaration_storage_v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExecutableParameterDeclarationStorageV1
    _$$_ExecutableParameterDeclarationStorageV1FromJson(
            Map<String, dynamic> json) =>
        _$_ExecutableParameterDeclarationStorageV1(
          isRequired: json['isRequired'] as bool,
          isNamed: json['isNamed'] as bool,
          name: json['name'] as String,
          isDeprecated: json['isDeprecated'] as bool,
          typeName: json['typeName'] as String,
        );

Map<String, dynamic> _$$_ExecutableParameterDeclarationStorageV1ToJson(
        _$_ExecutableParameterDeclarationStorageV1 instance) =>
    <String, dynamic>{
      'isRequired': instance.isRequired,
      'isNamed': instance.isNamed,
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'typeName': instance.typeName,
    };

_$_ExecutableDeclarationStorageV1 _$$_ExecutableDeclarationStorageV1FromJson(
        Map<String, dynamic> json) =>
    _$_ExecutableDeclarationStorageV1(
      returnTypeName: json['returnTypeName'] as String,
      name: json['name'] as String,
      isDeprecated: json['isDeprecated'] as bool,
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => ExecutableParameterDeclarationStorageV1.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      typeParameterNames: (json['typeParameterNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      type: $enumDecode(_$ExecutableTypeStorageV1EnumMap, json['type']),
      isStatic: json['isStatic'] as bool,
    );

Map<String, dynamic> _$$_ExecutableDeclarationStorageV1ToJson(
        _$_ExecutableDeclarationStorageV1 instance) =>
    <String, dynamic>{
      'returnTypeName': instance.returnTypeName,
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'parameters': instance.parameters,
      'typeParameterNames': instance.typeParameterNames,
      'type': _$ExecutableTypeStorageV1EnumMap[instance.type]!,
      'isStatic': instance.isStatic,
    };

const _$ExecutableTypeStorageV1EnumMap = {
  ExecutableTypeStorageV1.method: 'method',
  ExecutableTypeStorageV1.constructor: 'constructor',
};
