import '../../api_tool.dart';

String getDeclarationNodeHeadline(Declaration declaration) {
  var prefix = '';
  if (declaration is ExecutableDeclaration) {
    prefix = declaration.type.toString().split('.').last;
    prefix = '${prefix[0].toUpperCase()}${prefix.substring(1)} ';
  } else if (declaration is FieldDeclaration) {
    prefix = 'Field ';
  } else if (declaration is InterfaceDeclaration) {
    prefix = 'Class ';
  }
  return prefix + declaration.name;
}
