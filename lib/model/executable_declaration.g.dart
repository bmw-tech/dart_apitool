// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'executable_declaration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExecutablParameterDeclaration _$$_ExecutablParameterDeclarationFromJson(
        Map<String, dynamic> json) =>
    _$_ExecutablParameterDeclaration(
      isRequired: json['isRequired'] as bool,
      isNamed: json['isNamed'] as bool,
      name: json['name'] as String,
      typeName: json['typeName'] as String,
    );

Map<String, dynamic> _$$_ExecutablParameterDeclarationToJson(
        _$_ExecutablParameterDeclaration instance) =>
    <String, dynamic>{
      'isRequired': instance.isRequired,
      'isNamed': instance.isNamed,
      'name': instance.name,
      'typeName': instance.typeName,
    };

_$_ExecutableDeclaration _$$_ExecutableDeclarationFromJson(
        Map<String, dynamic> json) =>
    _$_ExecutableDeclaration(
      returnTypeName: json['returnTypeName'] as String,
      name: json['name'] as String,
      parameters: (json['parameters'] as List<dynamic>)
          .map((e) =>
              ExecutablParameterDeclaration.fromJson(e as Map<String, dynamic>))
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
      'parameters': instance.parameters,
      'typeParameterNames': instance.typeParameterNames,
      'type': _$ExecutableTypeEnumMap[instance.type]!,
    };

const _$ExecutableTypeEnumMap = {
  ExecutableType.method: 'method',
  ExecutableType.constructor: 'constructor',
};
