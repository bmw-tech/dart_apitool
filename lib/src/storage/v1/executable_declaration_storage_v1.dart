import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'executable_declaration_storage_v1.freezed.dart';
part 'executable_declaration_storage_v1.g.dart';

/// Represents the type of executable found
enum ExecutableTypeStorageV1 {
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

  static ExecutableTypeStorageV1 fromExecutableType(
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
class ExecutableParameterDeclarationStorageV1
    with _$ExecutableParameterDeclarationStorageV1 {
  const ExecutableParameterDeclarationStorageV1._();

  const factory ExecutableParameterDeclarationStorageV1({
    required bool isRequired,
    required bool isNamed,
    required String name,
    required bool isDeprecated,
    required String typeName,
  }) = _ExecutableParameterDeclarationStorageV1;

  factory ExecutableParameterDeclarationStorageV1.fromJson(
          Map<String, Object?> json) =>
      _$ExecutableParameterDeclarationStorageV1FromJson(json);

  ExecutableParameterDeclaration toExecutableParameterDeclaration() {
    return ExecutableParameterDeclaration(
      isRequired: isRequired,
      isNamed: isNamed,
      name: name,
      isDeprecated: isDeprecated,
      typeName: typeName,
    );
  }

  static ExecutableParameterDeclarationStorageV1
      fromExecutableParameterDeclaration(
          ExecutableParameterDeclaration executableParameterDeclaration) {
    return ExecutableParameterDeclarationStorageV1(
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
class ExecutableDeclarationStorageV1 with _$ExecutableDeclarationStorageV1 {
  const ExecutableDeclarationStorageV1._();

  const factory ExecutableDeclarationStorageV1({
    required String returnTypeName,
    required String name,
    required bool isDeprecated,
    required List<ExecutableParameterDeclarationStorageV1> parameters,
    required List<String> typeParameterNames,
    required ExecutableTypeStorageV1 type,
    required bool isStatic,
    Set<String>? entryPoints,
  }) = _ExecutableDeclarationStorageV1;

  factory ExecutableDeclarationStorageV1.fromJson(Map<String, Object?> json) =>
      _$ExecutableDeclarationStorageV1FromJson(json);

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

  static ExecutableDeclarationStorageV1 fromExecutableDeclaration(
      ExecutableDeclaration executableDeclaration) {
    return ExecutableDeclarationStorageV1(
      returnTypeName: executableDeclaration.returnTypeName,
      name: executableDeclaration.name,
      isDeprecated: executableDeclaration.isDeprecated,
      parameters: executableDeclaration.parameters
          .map((p) => ExecutableParameterDeclarationStorageV1
              .fromExecutableParameterDeclaration(p))
          .toList(),
      typeParameterNames: executableDeclaration.typeParameterNames,
      type: ExecutableTypeStorageV1.fromExecutableType(
          executableDeclaration.type),
      isStatic: executableDeclaration.isStatic,
      entryPoints: executableDeclaration.entryPoints,
    );
  }
}
