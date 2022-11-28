import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

abstract class InternalDeclarationUtils {
  static int? getIdFromElement(Element? element) {
    if (element == null) {
      return null;
    }
    return element.id;
  }

  static int? getIdFromParentElement(Element? element) {
    if (element is InterfaceElement || element is ExtensionElement) {
      return getIdFromElement(element);
    }
    return null;
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

  static hasExperimental(Element element) {
    bool result = element.metadata.any((annotation) =>
        annotation.element?.name == 'experimental' ||
        annotation.element?.name == 'Experimental');
    return result;
  }
}
