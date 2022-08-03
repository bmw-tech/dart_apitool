import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_apitool/model/executable_declaration.dart';
import 'package:dart_apitool/model/field_declaration.dart';
import 'package:dart_apitool/utils/string_utils.dart';
import 'package:equatable/equatable.dart';

/// Represents a found class declaration
class ClassDeclatation extends Equatable {
  /// the signature of this class condensed to one String
  /// contains Type arguments as well as base classes or implemented interfaces
  String get signature => _computeSignature();

  /// class name of the parent class or [null] if there is no parent class
  final int? parentClassId;
  final int id;

  final String name;
  final List<String> typeParameterNames;
  final List<DartType> superTypes;

  final List<ExecutableDeclaration> executableDeclarations;
  final List<FieldDeclaration> fieldDeclarations;

  const ClassDeclatation._({
    required this.id,
    required this.name,
    required this.typeParameterNames,
    required this.superTypes,
    required this.parentClassId,
    this.executableDeclarations = const [],
    this.fieldDeclarations = const [],
  });

  /// creates a new ClassDeclaration from an given ClassElement
  ///
  /// [parentClassName] gets passed on to the ClassDeclaration
  ClassDeclatation.fromClassElement(ClassElement classElement)
      : this._(
          id: _getIdFromElement(classElement)!,
          name: classElement.name,
          typeParameterNames:
              _computeTypeParameters(classElement.typeParameters),
          superTypes: classElement.allSupertypes,
          parentClassId: _getIdFromElement(classElement.enclosingElement2),
        );

  String _computeSignature() {
    String superTypeSuffix = '';
    if (superTypes.isNotEmpty) {
      superTypeSuffix =
          ' : ${superTypes.map((e) => e.getDisplayString(withNullability: true)).join(', ')}';
    }
    final typeParameterSuffix = getTypeParameterSuffix(typeParameterNames);
    return '$name$typeParameterSuffix$superTypeSuffix';
  }

  static int? _getIdFromElement(Element? element) {
    if (element == null) {
      return null;
    }
    return element.id;
  }

  ClassDeclatation copyWith(
      {List<ExecutableDeclaration>? executableDeclarations,
      List<FieldDeclaration>? fieldDeclarations}) {
    return ClassDeclatation._(
      id: id,
      name: name,
      typeParameterNames: typeParameterNames,
      superTypes: superTypes,
      parentClassId: parentClassId,
      executableDeclarations:
          executableDeclarations ?? this.executableDeclarations,
      fieldDeclarations: fieldDeclarations ?? this.fieldDeclarations,
    );
  }

  @override
  List<Object?> get props => [
        id,
        parentClassId,
        name,
        typeParameterNames,
        superTypes,
      ];

  static List<String> _computeTypeParameters(
      List<TypeParameterElement> typeParameters) {
    return typeParameters.map((e) => e.name).toList();
  }
}
