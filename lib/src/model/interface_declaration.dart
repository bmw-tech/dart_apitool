// ignore: unused_import
import 'package:analyzer/dart/element/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/string_utils.dart';
import 'declaration.dart';
import 'executable_declaration.dart';
import 'field_declaration.dart';
import 'type_usage.dart';

part 'interface_declaration.freezed.dart';

/// Represents a found interface declaration
@freezed
class InterfaceDeclaration with _$InterfaceDeclaration implements Declaration {
  /// the signature of this interface condensed to one String
  /// contains Type arguments as well as base types or implemented interfaces
  String get signature => _computeSignature();

  const InterfaceDeclaration._();

  @Implements<Declaration>()
  const factory InterfaceDeclaration({
    /// name of this interface
    required String name,

    /// whether this interface is deprecated
    required bool isDeprecated,

    /// whether this interface is experimental
    required bool isExperimental,

    /// determines if this declaration is sealed
    required bool isSealed,

    /// determines if this declaration is abstract
    required bool isAbstract,

    /// usages of this interface
    required Set<TypeUsage> typeUsages,

    /// list of type parameter names
    required List<String> typeParameterNames,

    /// list of super type names
    required List<String> superTypeNames,

    /// executables that belong to this interface
    required List<ExecutableDeclaration> executableDeclarations,

    /// fields that belong to this interface
    required List<FieldDeclaration> fieldDeclarations,

    /// entry points this interface is reachable through
    Set<String>? entryPoints,

    /// the relative path of the library
    required String relativePath,
  }) = _InterfaceDeclaration;

  String _computeSignature() {
    String superTypeSuffix = '';
    if (superTypeNames.isNotEmpty) {
      superTypeSuffix = ' : ${superTypeNames.join(', ')}';
    }
    final typeParameterSuffix = getTypeParameterSuffix(typeParameterNames);
    return '$name$typeParameterSuffix$superTypeSuffix';
  }

  /// determines if this interface is required (meaning: can be used in a type hierarchy by the consumer)
  bool get isRequired =>
      isAbstract && !isSealed && typeUsages.contains(TypeUsage.input);
}
