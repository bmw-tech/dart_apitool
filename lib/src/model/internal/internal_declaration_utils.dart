import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:collection/collection.dart';
import 'package:path/path.dart' as path;

abstract class InternalDeclarationUtils {
  static int? getIdFromElement(Element2? element) {
    if (element == null) {
      return null;
    }
    return element.id;
  }

  static int? getIdFromParentElement(Element2? element) {
    if (element is InterfaceElement2 || element is ExtensionElement2) {
      return getIdFromElement(element);
    }
    return null;
  }

  static List<String> computeTypeParameters(
      List<TypeParameterElement2> typeParameters) {
    return typeParameters.map((e) => e.name3 ?? e.displayName).toList();
  }

  static Set<String> computeSuperTypeNames(List<InterfaceType> allSupertypes) {
    return allSupertypes
        .map((st) => st.getDisplayString())
        // if there are supertypes with the same name then only one survives
        // this is accepted for now as we don't want to dig that far into type hierarchy changes
        .toSet();
  }

  static bool containsAnnotation(Annotatable element, String name,
      {bool ignoreCase = true}) {
    bool result = element.metadata2.annotations.any((annotation) {
      // this is really hacky but currently there is no other way of getting into the guts of the annotation
      dynamic dynamicAnnotation = annotation;
      final String annotationName = dynamicAnnotation.annotationAst.name.name;

      if (ignoreCase) {
        return annotationName.toUpperCase() == name.toUpperCase();
      } else {
        return annotationName == name;
      }
    });
    return result;
  }

  static bool hasVisibleForTesting(Annotatable element) {
    return containsAnnotation(element, 'visibleForTesting');
  }

  static bool hasExperimental(Annotatable element) {
    return containsAnnotation(element, 'experimental');
  }

  static bool hasSealed(Annotatable element) {
    return element.metadata2.hasSealed;
  }

  static String getRelativePath(String rootPath, Element2? element) {
    final libraryUri = element?.library2?.uri;
    if (libraryUri != null) {
      try {
        final libraryPath = libraryUri.toFilePath();
        return path.relative(libraryPath, from: rootPath);
      } catch (e) {
        // ignore
      }
    }
    return libraryUri.toString();
  }

  static String getFullQualifiedNameForLibrary(LibraryElement2 library) {
    final uri = library.uri;
    if (uri.isScheme('file')) {
      final pathParts = path.split(uri.toFilePath());
      final libIndex = pathParts.lastIndexOf('lib');
      if (libIndex >= 0) {
        pathParts.removeRange(0, libIndex + 1);
      }
      return path.joinAll(pathParts);
    }
    // in case we have a URI we just show the path segments. If we happen to find "src" then we only show the path after that
    // this works as we only have usages in our own package
    final uriPathSegments = [...uri.pathSegments];
    final srcIndex = uriPathSegments.lastIndexOf('src');
    if (srcIndex >= 0) {
      uriPathSegments.removeRange(0, srcIndex + 1);
    }

    return uriPathSegments.join('/');
  }

  static String getFullQualifiedNameFor(Element2 element) {
    final parts = <String>[];

    if (element.enclosingElement2 != null) {
      parts.add(getFullQualifiedNameFor(element.enclosingElement2!));
    } else if (element.library2 != null) {
      /// stop at root level and add the fully qualified library name
      parts.add(getFullQualifiedNameForLibrary(element.library2!));
    }
    parts.add(element.name3 ?? element.displayName);

    return parts.where((part) => part.isNotEmpty).join('::');
  }

  static String? getNamespaceForElement(
      Element2? referredElement, Element2 referringElement) {
    final referredElementLibrary = referredElement?.library2;
    if (referredElementLibrary == null) {
      return null;
    }
    final sourceLibrary = referringElement.library2;
    if (sourceLibrary == null) {
      return null;
    }
    for (final sourceLibraryFragment in sourceLibrary.fragments) {
      for (final libraryImport in sourceLibraryFragment.libraryImports2) {
        if (libraryImport.importedLibrary2?.id == referredElementLibrary.id) {
          return libraryImport.prefix2?.element.name3;
        }
      }
    }

    return null;
  }
}
