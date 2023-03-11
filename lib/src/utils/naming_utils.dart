import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as path;

/// Utilities for naming things
abstract class NamingUtils {
  /// calculates the unique name of a type
  static String computeUniqueTypeName(
      String projectRootPath, Element? element) {
    return computeUniqueTypeNameFromNames(
      projectRootPath: projectRootPath,
      fullLibraryName: element?.librarySource?.fullName,
      name: element?.name,
    );
  }

  /// calculates the unique name of a type from the library name and the type name
  static String computeUniqueTypeNameFromNames({
    required String projectRootPath,
    required String? fullLibraryName,
    required String? name,
  }) {
    //TODO: this is still a problem for monorepos with path dependencies as the base is not the project root but the copy root.
    // so maybe we want to make a relative path if not from the cache or something
    String libraryName = fullLibraryName ?? '';
    // if the library is inside the project we make the path relative so that two projects from different locations can be compared
    if (path.isWithin(projectRootPath, libraryName)) {
      libraryName = path.relative(libraryName, from: projectRootPath);
    }
    return '$libraryName/${name ?? ''}';
  }
}
