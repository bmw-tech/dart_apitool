// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'executable_declaration_storage_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExecutableParameterDeclarationStorageV3Impl
    _$$ExecutableParameterDeclarationStorageV3ImplFromJson(
            Map<String, dynamic> json) =>
        _$ExecutableParameterDeclarationStorageV3Impl(
          isRequired: json['isRequired'] as bool,
          isNamed: json['isNamed'] as bool,
          name: json['name'] as String,
          isDeprecated: json['isDeprecated'] as bool,
          isExperimental: json['isExperimental'] as bool,
          typeName: json['typeName'] as String,
          relativePath: json['relativePath'] as String,
        );

Map<String, dynamic> _$$ExecutableParameterDeclarationStorageV3ImplToJson(
        _$ExecutableParameterDeclarationStorageV3Impl instance) =>
    <String, dynamic>{
      'isRequired': instance.isRequired,
      'isNamed': instance.isNamed,
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'isExperimental': instance.isExperimental,
      'typeName': instance.typeName,
      'relativePath': instance.relativePath,
    };

_$ExecutableDeclarationStorageV3Impl
    _$$ExecutableDeclarationStorageV3ImplFromJson(Map<String, dynamic> json) =>
        _$ExecutableDeclarationStorageV3Impl(
          returnTypeName: json['returnTypeName'] as String,
          name: json['name'] as String,
          isDeprecated: json['isDeprecated'] as bool,
          isExperimental: json['isExperimental'] as bool,
          parameters: (json['parameters'] as List<dynamic>)
              .map((e) => ExecutableParameterDeclarationStorageV3.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          typeParameterNames: (json['typeParameterNames'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
          type: $enumDecode(_$ExecutableTypeStorageV3EnumMap, json['type']),
          isStatic: json['isStatic'] as bool,
          entryPoints: (json['entryPoints'] as List<dynamic>)
              .map((e) => e as String)
              .toSet(),
          relativePath: json['relativePath'] as String,
        );

Map<String, dynamic> _$$ExecutableDeclarationStorageV3ImplToJson(
        _$ExecutableDeclarationStorageV3Impl instance) =>
    <String, dynamic>{
      'returnTypeName': instance.returnTypeName,
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'isExperimental': instance.isExperimental,
      'parameters': instance.parameters,
      'typeParameterNames': instance.typeParameterNames,
      'type': _$ExecutableTypeStorageV3EnumMap[instance.type]!,
      'isStatic': instance.isStatic,
      'entryPoints': instance.entryPoints.toList(),
      'relativePath': instance.relativePath,
    };

const _$ExecutableTypeStorageV3EnumMap = {
  ExecutableTypeStorageV3.method: 'method',
  ExecutableTypeStorageV3.constructor: 'constructor',
};
