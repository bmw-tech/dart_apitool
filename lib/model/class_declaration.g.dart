// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_declaration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClassDeclaration _$$_ClassDeclarationFromJson(Map<String, dynamic> json) =>
    _$_ClassDeclaration(
      name: json['name'] as String,
      typeParameterNames: (json['typeParameterNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      superTypeNames: (json['superTypeNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      executableDeclarations: (json['executableDeclarations'] as List<dynamic>)
          .map((e) => ExecutableDeclaration.fromJson(e as Map<String, dynamic>))
          .toList(),
      fieldDeclarations: (json['fieldDeclarations'] as List<dynamic>)
          .map((e) => FieldDeclaration.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ClassDeclarationToJson(_$_ClassDeclaration instance) =>
    <String, dynamic>{
      'name': instance.name,
      'typeParameterNames': instance.typeParameterNames,
      'superTypeNames': instance.superTypeNames,
      'executableDeclarations': instance.executableDeclarations,
      'fieldDeclarations': instance.fieldDeclarations,
    };
