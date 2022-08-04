import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

abstract class InternalDeclarationUtils {
  static int? getIdFromElement(Element? element) {
    if (element == null) {
      return null;
    }
    return element.id;
  }

  static List<String> computeTypeParameters(
      List<TypeParameterElement> typeParameters) {
    return typeParameters.map((e) => e.name).toList();
  }

  static List<String> computeSuperTypeNames(List<InterfaceType> allSupertypes) {
    return allSupertypes
        .map((st) => st.getDisplayString(withNullability: true))
        .toList();
  }
}
