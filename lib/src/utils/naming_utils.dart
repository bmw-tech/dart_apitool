/// Utilities for naming things
abstract class NamingUtils {
  /// calculates the type identifier for a given namespace and type name
  static String computeTypeIdentifier(String? typeNamespace, String typeName) {
    return '${typeNamespace ?? ''}.$typeName';
  }
}
