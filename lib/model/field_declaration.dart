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

  final int? parentClassId;

  const FieldDeclaration._({
    required this.type,
    required this.name,
    required this.parentClassId,
  });

  /// creates a [FieldDeclaration] from an [PropertyInducingElement].
  ///
  /// Typically [PropertyInducingElement] are properties, fields and top level variables
  FieldDeclaration.fromPropertyInducingElement(
      PropertyInducingElement fieldElement)
      : this._(
          type: fieldElement.type,
          name: fieldElement.name,
          parentClassId: _getParentClassIdFromEnclosingElement(
              fieldElement.enclosingElement2),
        );

  /// helper to compute the signature of a field
  String _computeSignature() {
    final fieldTypeName = type.getDisplayString(withNullability: true);
    return '$fieldTypeName $name';
  }

  static int? _getParentClassIdFromEnclosingElement(Element? enclosingElement) {
    if (enclosingElement == null) {
      return null;
    }
    return enclosingElement.id;
  }

  @override
  List<Object?> get props => [
        parentClassId,
        type,
        name,
      ];
}
