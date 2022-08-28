import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/model.dart';

part 'executable_declaration_storage_v2.freezed.dart';
part 'executable_declaration_storage_v2.g.dart';

/// Represents the type of executable found
enum ExecutableTypeStorageV2 {
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

  static ExecutableTypeStorageV2 fromExecutableType(
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
class ExecutableParameterDeclarationStorageV2
    with _$ExecutableParameterDeclarationStorageV2 {
  const ExecutableParameterDeclarationStorageV2._();

  const factory ExecutableParameterDeclarationStorageV2({
    required bool isRequired,
    required bool isNamed,
    required String name,
    required bool isDeprecated,
    required String typeName,
  }) = _ExecutableParameterDeclarationStorageV2;

  factory ExecutableParameterDeclarationStorageV2.fromJson(
          Map<String, Object?> json) =>
      _$ExecutableParameterDeclarationStorageV2FromJson(json);

  ExecutableParameterDeclaration toExecutableParameterDeclaration() {
    return ExecutableParameterDeclaration(
      isRequired: isRequired,
      isNamed: isNamed,
      name: name,
      isDeprecated: isDeprecated,
      typeName: typeName,
    );
  }

  static ExecutableParameterDeclarationStorageV2
      fromExecutableParameterDeclaration(
          ExecutableParameterDeclaration executableParameterDeclaration) {
    return ExecutableParameterDeclarationStorageV2(
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
class ExecutableDeclarationStorageV2 with _$ExecutableDeclarationStorageV2 {
  const ExecutableDeclarationStorageV2._();

  const factory ExecutableDeclarationStorageV2({
    required String returnTypeName,
    required String name,
    required bool isDeprecated,
    required List<ExecutableParameterDeclarationStorageV2> parameters,
    required List<String> typeParameterNames,
    required ExecutableTypeStorageV2 type,
    required bool isStatic,
    Set<String>? entryPoints,
  }) = _ExecutableDeclarationStorageV2;

  factory ExecutableDeclarationStorageV2.fromJson(Map<String, Object?> json) =>
      _$ExecutableDeclarationStorageV2FromJson(json);

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

  static ExecutableDeclarationStorageV2 fromExecutableDeclaration(
      ExecutableDeclaration executableDeclaration) {
    return ExecutableDeclarationStorageV2(
      returnTypeName: executableDeclaration.returnTypeName,
      name: executableDeclaration.name,
      isDeprecated: executableDeclaration.isDeprecated,
      parameters: executableDeclaration.parameters
          .map((p) => ExecutableParameterDeclarationStorageV2
              .fromExecutableParameterDeclaration(p))
          .toList(),
      typeParameterNames: executableDeclaration.typeParameterNames,
      type: ExecutableTypeStorageV2.fromExecutableType(
          executableDeclaration.type),
      isStatic: executableDeclaration.isStatic,
      entryPoints: executableDeclaration.entryPoints,
    );
  }
}
