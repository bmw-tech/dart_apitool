/// returns the type parameter suffix (like `<T>`)
String getTypeParameterSuffix(List<String> typeParameterNames) {
  String typeParameterSuffix = '';
  if (typeParameterNames.isNotEmpty) {
    typeParameterSuffix = '<${typeParameterNames.join(', ')}>';
  }
  return typeParameterSuffix;
}

String getPackageNameFromLibraryIdentifier(String libraryIdentifier) {
  if (!libraryIdentifier.startsWith('package:')) {
    return '';
  }
  int endIndex = libraryIdentifier.length;
  if (libraryIdentifier.contains('/')) {
    endIndex = libraryIdentifier.indexOf('/');
  }

  return libraryIdentifier.substring('package:'.length, endIndex);
}
