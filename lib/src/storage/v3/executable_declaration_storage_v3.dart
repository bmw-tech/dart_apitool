import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'executable_declaration_storage_v3.freezed.dart';
part 'executable_declaration_storage_v3.g.dart';

/// Represents the type of executable found
enum ExecutableTypeStorageV3 {
  /// method declaration
  method,
  // constructor declaration
  constructor;

  ExecutableType toExecutableType() {
    switch (this) {
      case method:
        return ExecutableType.method;
      case constructor:
        return ExecutableType.constructor;
    }
  }

  static ExecutableTypeStorageV3 fromExecutableType(
      ExecutableType executableType) {
    switch (executableType) {
      case ExecutableType.method:
        return method;
      case ExecutableType.constructor:
        return constructor;
    }
  }
}

@freezed
class ExecutableParameterDeclarationStorageV3
    with _$ExecutableParameterDeclarationStorageV3 {
  const ExecutableParameterDeclarationStorageV3._();

  const factory ExecutableParameterDeclarationStorageV3({
    required bool isRequired,
    required bool isNamed,
    required String name,
    required bool isDeprecated,
    required String typeName,
  }) = _ExecutableParameterDeclarationStorageV3;

  factory ExecutableParameterDeclarationStorageV3.fromJson(
          Map<String, Object?> json) =>
      _$ExecutableParameterDeclarationStorageV3FromJson(json);

  ExecutableParameterDeclaration toExecutableParameterDeclaration() {
    return ExecutableParameterDeclaration(
      isRequired: isRequired,
      isNamed: isNamed,
      name: name,
      isDeprecated: isDeprecated,
      typeName: typeName,
    );
  }

  static ExecutableParameterDeclarationStorageV3
      fromExecutableParameterDeclaration(
          ExecutableParameterDeclaration executableParameterDeclaration) {
    return ExecutableParameterDeclarationStorageV3(
      isRequired: executableParameterDeclaration.isRequired,
      isNamed: executableParameterDeclaration.isNamed,
      name: executableParameterDeclaration.name,
      isDeprecated: executableParameterDeclaration.isDeprecated,
      typeName: executableParameterDeclaration.typeName,
    );
  }
}

/// Represents an executable declaration
@freezed
class ExecutableDeclarationStorageV3 with _$ExecutableDeclarationStorageV3 {
  const ExecutableDeclarationStorageV3._();

  const factory ExecutableDeclarationStorageV3({
    required String returnTypeName,
    required String name,
    required bool isDeprecated,
    required List<ExecutableParameterDeclarationStorageV3> parameters,
    required List<String> typeParameterNames,
    required ExecutableTypeStorageV3 type,
    required bool isStatic,
    required Set<String> entryPoints,
  }) = _ExecutableDeclarationStorageV3;

  factory ExecutableDeclarationStorageV3.fromJson(Map<String, Object?> json) =>
      _$ExecutableDeclarationStorageV3FromJson(json);

  ExecutableDeclaration toExecutableDeclaration() {
    return ExecutableDeclaration(
      returnTypeName: returnTypeName,
      name: name,
      isDeprecated: isDeprecated,
      parameters:
          parameters.map((p) => p.toExecutableParameterDeclaration()).toList(),
      typeParameterNames: typeParameterNames,
      type: type.toExecutableType(),
      isStatic: isStatic,
      entryPoints: entryPoints,
    );
  }

  static ExecutableDeclarationStorageV3 fromExecutableDeclaration(
      ExecutableDeclaration executableDeclaration) {
    return ExecutableDeclarationStorageV3(
      returnTypeName: executableDeclaration.returnTypeName,
      name: executableDeclaration.name,
      isDeprecated: executableDeclaration.isDeprecated,
      parameters: executableDeclaration.parameters
          .map((p) => ExecutableParameterDeclarationStorageV3
              .fromExecutableParameterDeclaration(p))
          .toList(),
      typeParameterNames: executableDeclaration.typeParameterNames,
      type: ExecutableTypeStorageV3.fromExecutableType(
          executableDeclaration.type),
      isStatic: executableDeclaration.isStatic,
      entryPoints: executableDeclaration.entryPoints!,
    );
  }
}
