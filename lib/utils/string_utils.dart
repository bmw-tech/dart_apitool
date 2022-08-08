import 'package:path/path.dart' as path;

/// returns the type parameter suffix (like `<T>`)
String getTypeParameterSuffix(List<String> typeParameterNames) {
  String typeParameterSuffix = '';
  if (typeParameterNames.isNotEmpty) {
    typeParameterSuffix = '<${typeParameterNames.join(', ')}>';
  }
  return typeParameterSuffix;
}

String? getPackageNameFromLibraryIdentifier(String libraryIdentifier) {
  String? packageName;
  packageName = _getPackageNameFromPackageUri(libraryIdentifier);
  packageName ??= _getPackageNameFromFilePath(libraryIdentifier);
  return packageName;
}

String? _getPackageNameFromPackageUri(String packageUri) {
  if (!packageUri.startsWith('package:')) {
    return null;
  }
  int endIndex = packageUri.length;
  if (packageUri.contains('/')) {
    endIndex = packageUri.indexOf('/');
  }

  return packageUri.substring('package:'.length, endIndex);
}

String? _getPackageNameFromFilePath(String filePath) {
  final parts = path.split(filePath);
  // very simple assumption: the package path is the directory that contains the lib directory
  for (int i = parts.length - 1; i > 0; i--) {
    if (parts[i] == 'lib') {
      return parts[i - 1]; //we can do that as we stop as i>0
    }
  }
  return null;
}
