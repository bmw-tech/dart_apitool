// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProjectApi _$$_ProjectApiFromJson(Map<String, dynamic> json) =>
    _$_ProjectApi(
      projectName: json['projectName'] as String,
      projectPath: json['projectPath'] as String,
      classDeclarations: (json['classDeclarations'] as List<dynamic>)
          .map((e) => ClassDeclaration.fromJson(e as Map<String, dynamic>))
          .toList(),
      executableDeclarations: (json['executableDeclarations'] as List<dynamic>)
          .map((e) => ExecutableDeclaration.fromJson(e as Map<String, dynamic>))
          .toList(),
      fieldDeclarations: (json['fieldDeclarations'] as List<dynamic>)
          .map((e) => FieldDeclaration.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ProjectApiToJson(_$_ProjectApi instance) =>
    <String, dynamic>{
      'projectName': instance.projectName,
      'projectPath': instance.projectPath,
      'classDeclarations': instance.classDeclarations,
      'executableDeclarations': instance.executableDeclarations,
      'fieldDeclarations': instance.fieldDeclarations,
    };
