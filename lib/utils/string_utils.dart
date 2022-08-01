/// returns the type parameter suffix (like `<T>`)
String getTypeParameterSuffix(List<String> typeParameterNames) {
  String typeParameterSuffix = '';
  if (typeParameterNames.isNotEmpty) {
    typeParameterSuffix = '<${typeParameterNames.join(', ')}>';
  }
  return typeParameterSuffix;
}
