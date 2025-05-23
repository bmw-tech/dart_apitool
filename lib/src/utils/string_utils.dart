import 'dart:io';

import 'package:analyzer/dart/element/element2.dart';
import 'package:path/path.dart' as path;

/// returns the type parameter suffix (like `<T>`)
String getTypeParameterSuffix(List<String> typeParameterNames) {
  String typeParameterSuffix = '';
  if (typeParameterNames.isNotEmpty) {
    typeParameterSuffix = '<${typeParameterNames.join(', ')}>';
  }
  return typeParameterSuffix;
}

String? getPackageNameFromLibrary(LibraryElement2 library) {
  String? packageName;
  packageName = _getPackageNameFromPackageUri(library.identifier);
  packageName ??= _getPackageNameFromFilePath(library.identifier);
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

String? _getPackageNameFromFilePath(String filePathOrUri) {
  String? filePath;
  final parsedUri = Uri.tryParse(filePathOrUri);
  if (parsedUri != null) {
    if (!parsedUri.hasAbsolutePath) {
      return null;
    }
    filePath = parsedUri.toFilePath();
  } else {
    filePath = filePathOrUri;
  }
  final parts = path.split(filePath);
  // very simple assumption: the package path is the directory that contains lib
  for (int i = parts.length - 1; i > 0; i--) {
    if (parts[i] == 'lib' && _isPackageDirectory(path.joinAll(parts.take(i)))) {
      return parts[i - 1]; //we can do that as we stop as i>0}
    }
  }
  // here we either didn't find a lib folder or the lib folder is not next to a pubspec.yaml
  // so search for a pubspec.yaml regardless of the lib director
  for (int i = parts.length - 1; i > 0; i--) {
    if (_isPackageDirectory(path.joinAll(parts.take(i)))) {
      return parts[i - 1]; //we can do that as we stop as i>0}
    }
  }
  return null;
}

bool _isPackageDirectory(String directory) {
  return File(path.absolute(path.join(directory, 'pubspec.yaml'))).existsSync();
}
