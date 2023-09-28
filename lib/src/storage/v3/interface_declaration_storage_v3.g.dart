// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'interface_declaration_storage_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InterfaceDeclarationStorageV3Impl
    _$$InterfaceDeclarationStorageV3ImplFromJson(Map<String, dynamic> json) =>
        _$InterfaceDeclarationStorageV3Impl(
          name: json['name'] as String,
          isDeprecated: json['isDeprecated'] as bool,
          isExperimental: json['isExperimental'] as bool,
          isSealed: json['isSealed'] as bool,
          isRequired: json['isRequired'] as bool,
          typeParameterNames: (json['typeParameterNames'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
          superTypeNames: (json['superTypeNames'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
          executableDeclarations:
              (json['executableDeclarations'] as List<dynamic>)
                  .map((e) => ExecutableDeclarationStorageV3.fromJson(
                      e as Map<String, dynamic>))
                  .toList(),
          fieldDeclarations: (json['fieldDeclarations'] as List<dynamic>)
              .map((e) =>
                  FieldDeclarationStorageV3.fromJson(e as Map<String, dynamic>))
              .toList(),
          entryPoints: (json['entryPoints'] as List<dynamic>)
              .map((e) => e as String)
              .toSet(),
          relativePath: json['relativePath'] as String,
        );

Map<String, dynamic> _$$InterfaceDeclarationStorageV3ImplToJson(
        _$InterfaceDeclarationStorageV3Impl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isDeprecated': instance.isDeprecated,
      'isExperimental': instance.isExperimental,
      'isSealed': instance.isSealed,
      'isRequired': instance.isRequired,
      'typeParameterNames': instance.typeParameterNames,
      'superTypeNames': instance.superTypeNames,
      'executableDeclarations': instance.executableDeclarations,
      'fieldDeclarations': instance.fieldDeclarations,
      'entryPoints': instance.entryPoints.toList(),
      'relativePath': instance.relativePath,
    };
