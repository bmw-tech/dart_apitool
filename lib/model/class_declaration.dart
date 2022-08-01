import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:dart_apitool/utils/string_utils.dart';
import 'package:equatable/equatable.dart';

/// Represents a found class declaration
class ClassDeclatation extends Equatable {
  /// the signature of this class condensed to one String
  /// contains Type arguments as well as base classes or implemented interfaces
  String get signature => _computeSignature();

  /// class name of the parent class or [null] if there is no parent class
  final String? parentClassName;

  final String name;
  final List<String> typeParameterNames;
  final List<DartType> superTypes;

  const ClassDeclatation._(this.name, this.typeParameterNames, this.superTypes,
      this.parentClassName);

  /// creates a new ClassDeclaration from an given ClassElement
  ///
  /// [parentClassName] gets passed on to the ClassDeclaration
  ClassDeclatation.fromClassElement(
      String? parentClassName, ClassElement classElement)
      : this._(
            classElement.name,
            _computeTypeParameters(classElement.typeParameters),
            classElement.allSupertypes,
            parentClassName);

  String _computeSignature() {
    String superTypeSuffix = '';
    if (superTypes.isNotEmpty) {
      superTypeSuffix =
          ' : ${superTypes.map((e) => e.getDisplayString(withNullability: true)).join(', ')}';
    }
    final typeParameterSuffix = getTypeParameterSuffix(typeParameterNames);
    return '$name$typeParameterSuffix$superTypeSuffix';
  }

  @override
  List<Object?> get props => [
        parentClassName,
        name,
        typeParameterNames,
        superTypes,
      ];

  static List<String> _computeTypeParameters(
      List<TypeParameterElement> typeParameters) {
    return typeParameters.map((e) => e.name).toList();
  }
}
