import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as path;

/// Utilities for naming things
abstract class NamingUtils {
  /// calculates the full library path
  /// This takes into account that local types are handled relatively so that different project paths yield the same path
  static String getFullLibraryPathFromElement({
    required String clusterRootPath,
    required Element? element,
  }) {
    return getFullLibraryPath(
      clusterRootPath: clusterRootPath,
      fullLibraryName: element?.librarySource?.fullName,
    );
  }

  /// calculates the full library path
  /// This takes into account that local types are handled relatively so that different project paths yield the same path
  static String getFullLibraryPath({
    required String clusterRootPath,
    required String? fullLibraryName,
  }) {
    String libraryName = fullLibraryName ?? '';
    // if the library is inside the project we make the path relative so that two projects from different locations can be compared
    if (path.isWithin(clusterRootPath, libraryName)) {
      libraryName = path.relative(libraryName, from: clusterRootPath);
    }

    return libraryName;
  }
}
