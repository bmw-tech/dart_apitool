// ignore: unused_import
import 'package:analyzer/dart/element/element.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/string_utils.dart';
import 'declaration.dart';
import 'executable_declaration.dart';
import 'field_declaration.dart';

part 'interface_declaration.freezed.dart';

/// Represents a found class declaration
@freezed
class InterfaceDeclaration with _$InterfaceDeclaration implements Declaration {
  /// the signature of this class condensed to one String
  /// contains Type arguments as well as base classes or implemented interfaces
  String get signature => _computeSignature();

  const InterfaceDeclaration._();

  @Implements<Declaration>()
  const factory InterfaceDeclaration({
    required String name,
    required bool isDeprecated,
    required bool isRequired,
    required List<String> typeParameterNames,
    required List<String> superTypeNames,
    required List<ExecutableDeclaration> executableDeclarations,
    required List<FieldDeclaration> fieldDeclarations,
    Set<String>? entryPoints,
  }) = _InterfaceDeclaration;

  String _computeSignature() {
    String superTypeSuffix = '';
    if (superTypeNames.isNotEmpty) {
      superTypeSuffix = ' : ${superTypeNames.join(', ')}';
    }
    final typeParameterSuffix = getTypeParameterSuffix(typeParameterNames);
    return '$name$typeParameterSuffix$superTypeSuffix';
  }
}