// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/element/element.dart';

/// Utilities for naming things
abstract class NamingUtils {
  /// calculates the full library path
  static String getFullLibraryPathFromElement({
    required Element? element,
  }) {
    return element?.librarySource?.fullName ?? '';
  }
}
