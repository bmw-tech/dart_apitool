import 'package:analyzer/dart/element/element2.dart';

/// Utilities for naming things
abstract class NamingUtils {
  /// calculates the full library path
  static String getFullLibraryPathFromElement({
    required Element2? element,
  }) {
    return element?.library2?.uri.toString() ?? '';
  }
}
