import 'package:dart_apitool/model/class_declaration.dart';
import 'package:dart_apitool/model/executable_declaration.dart';
import 'package:dart_apitool/model/field_declaration.dart';

class ProjectApi {
  final String projectName;
  final String projectPath;

  final List<ClassDeclatation> classDeclarations;
  final List<ExecutableDeclaration> executableDeclarations;
  final List<FieldDeclaration> fieldDeclarations;

  ProjectApi({
    required this.projectName,
    required this.projectPath,
    required this.classDeclarations,
    required this.executableDeclarations,
    required this.fieldDeclarations,
  });
}
