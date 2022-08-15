// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'executable_declaration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExecutableParameterDeclaration _$$_ExecutableParameterDeclarationFromJson(
        Map<String, dynamic> json) =>
    _$_ExecutableParameterDeclaration(
      isRequired: json['isRequired'] as bool,
      isNamed: json['isNamed'] as bool,
      name: json['name'] as String,
      isDeprecated: json['isDeprecated'] as bool,
      typeName: json['typeName'] as String,
    );

Map<String, dynamic> _$$_ExecutableParameterDeclarationToJson(
        _$_ExecutableParameterDeclaration instance) =>
    <String, dynamic>{
      'isRequired': instance.isRequired,
      'isNamed': instance.isNamed,
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'typeName': instance.typeName,
    };

_$_ExecutableDeclaration _$$_ExecutableDeclarationFromJson(
        Map<String, dynamic> json) =>
    _$_ExecutableDeclaration(
      returnTypeName: json['returnTypeName'] as String,
      name: json['name'] as String,
      isDeprecated: json['isDeprecated'] as bool,
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) => ExecutableParameterDeclaration.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      typeParameterNames: (json['typeParameterNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      type: $enumDecode(_$ExecutableTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$_ExecutableDeclarationToJson(
        _$_ExecutableDeclaration instance) =>
    <String, dynamic>{
      'returnTypeName': instance.returnTypeName,
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'parameters': instance.parameters,
      'typeParameterNames': instance.typeParameterNames,
      'type': _$ExecutableTypeEnumMap[instance.type]!,
    };

const _$ExecutableTypeEnumMap = {
  ExecutableType.method: 'method',
  ExecutableType.constructor: 'constructor',
};
