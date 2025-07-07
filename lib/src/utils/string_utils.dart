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
  packageName = _getPackageNameFromPackageUri(library.uri) ??
      _getPackageNameFromFilePath(library.uri);
  return packageName;
}

String? _getPackageNameFromPackageUri(Uri packageUri) {
  if (!packageUri.isScheme('package')) {
    return null;
  }

  return packageUri.pathSegments.firstOrNull;
}

String? _getPackageNameFromFilePath(Uri uri) {
  String? filePath;
  if (!uri.hasAbsolutePath) {
    return null;
  }
  filePath = uri.toFilePath();
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
