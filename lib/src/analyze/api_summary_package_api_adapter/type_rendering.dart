part of '../api_summary_package_api_adapter.dart';

String _renderType(api_summary.ApiType type) {
  return switch (type) {
    api_summary.ApiDynamicType() => 'dynamic',
    api_summary.ApiVoidType() => 'void',
    api_summary.ApiTypeParameterType(:final name, :final isNullable) =>
      isNullable ? '$name?' : name,
    api_summary.ApiInterfaceType(
      :final name,
      :final typeArguments,
      :final isNullable,
    ) =>
      '$name${typeArguments.isEmpty ? '' : '<${typeArguments.map(_renderType).join(', ')}>'}${isNullable ? '?' : ''}',
    api_summary.ApiRecordType(
      :final positionalFields,
      :final namedFields,
      :final isNullable,
    ) =>
      '(${[...positionalFields.map(_renderType), if (namedFields.isNotEmpty) '{${namedFields.map((field) => '${_renderType(field.type)} ${field.name}').join(', ')}}'].join(', ')})${isNullable ? '?' : ''}',
    api_summary.ApiFunctionType(
      :final returnType,
      :final typeParameters,
      :final parameters,
      :final isNullable,
    ) =>
      '${_renderType(returnType)} Function${typeParameters.isEmpty ? '' : '<${typeParameters.keys.join(', ')}>'}(${_renderParameters(parameters, includeNames: false)})${isNullable ? '?' : ''}',
  };
}

String _renderParameters(
  List<api_summary.ApiParameter> parameters, {
  bool includeNames = true,
}) {
  final requiredPositional = <String>[];
  final optionalPositional = <String>[];
  final named = <String>[];
  for (final parameter in parameters) {
    final rendered = includeNames
        ? '${_renderType(parameter.type)} ${parameter.name}'
        : _renderType(parameter.type);
    if (parameter.isNamed) {
      named.add(parameter.isRequired ? 'required $rendered' : rendered);
    } else if (parameter.isOptionalPositional) {
      optionalPositional.add(rendered);
    } else {
      requiredPositional.add(rendered);
    }
  }
  final parts = <String>[...requiredPositional];
  if (optionalPositional.isNotEmpty) {
    parts.add('[${optionalPositional.join(', ')}]');
  }
  if (named.isNotEmpty) {
    parts.add('{${named.join(', ')}}');
  }
  return parts.join(', ');
}

String? _libraryUriFromType(api_summary.ApiType type) {
  switch (type) {
    case api_summary.ApiInterfaceType(:final libraryUri):
      return _normalizeLibraryUri(libraryUri);
    default:
      return null;
  }
}

String _stripTypeSuffixes(String typeName) {
  var value = typeName.trim();
  if (value.endsWith('?')) {
    value = value.substring(0, value.length - 1);
  }
  final genericStart = value.indexOf('<');
  if (genericStart >= 0) {
    value = value.substring(0, genericStart);
  }
  return value;
}

String? _normalizeLibraryUri(String? libraryUri) {
  if (libraryUri == null || libraryUri.isEmpty) {
    return null;
  }
  final uri = Uri.tryParse(libraryUri);
  if (uri != null && uri.scheme == 'file') {
    return Uri.file(path.normalize(uri.toFilePath())).toString();
  }
  return libraryUri;
}
