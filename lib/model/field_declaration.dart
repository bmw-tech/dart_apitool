import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:equatable/equatable.dart';

/// represents a found FieldDeclaration
class FieldDeclaration extends Equatable {
  /// the signature of this field declaration.
  ///
  /// Contains the type (including type parameters and nullability) as well as the name of this field
  String get signature => _computeSignature();

  final DartType type;
  final String name;

  /// class name of the parent class or [null] if there is no parent class
  final String? parentClassName;

  const FieldDeclaration._(this.type, this.name, this.parentClassName);

  /// creates a [FieldDeclaration] from an [PropertyInducingElement].
  ///
  /// Typically [PropertyInducingElement] are properties, fields and top level variables
  FieldDeclaration.fromPropertyInducingElement(
      String? parentClassName, PropertyInducingElement fieldElement)
      : this._(
          fieldElement.type,
          fieldElement.name,
          parentClassName,
        );

  /// helper to compute the signature of a field
  String _computeSignature() {
    final fieldTypeName = type.getDisplayString(withNullability: true);
    return '$fieldTypeName $name';
  }

  @override
  List<Object?> get props => [
        parentClassName,
        type,
        name,
      ];
}
