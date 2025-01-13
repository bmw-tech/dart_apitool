import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:path/path.dart' as path;

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

  static Set<String> computeSuperTypeNames(List<InterfaceType> allSupertypes) {
    return allSupertypes
        .map((st) => st.getDisplayString())
        // if there are supertypes with the same name then only one survives
        // this is accepted for now as we don't want to dig that far into type hierarchy changes
        .toSet();
  }

  static bool containsAnnotation(Element element, String name,
      {bool ignoreCase = true}) {
    bool result = element.metadata.any((annotation) {
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

  static bool hasVisibleForTesting(Element element) {
    return containsAnnotation(element, 'visibleForTesting');
  }

  static bool hasExperimental(Element element) {
    return containsAnnotation(element, 'experimental');
  }

  static bool hasSealed(Element element) {
    return containsAnnotation(element, 'sealed');
  }

  static String getRelativePath(String rootPath, Element? element) {
    final name = element?.librarySource?.fullName;
    if (name != null) {
      return path.relative(name, from: rootPath);
    }
    return '';
  }

  static String getFullQualifiedNameFor(Element element) {
    final parts = <String>[];

    /// stop at compilation unit level + adapt display name to show the relative path
    if (element is CompilationUnitElement) {
      Uri uri = element.source.uri;
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

    if (element.enclosingElement3 != null) {
      parts.add(getFullQualifiedNameFor(element.enclosingElement3!));
    }
    parts.add(element.displayName);

    return parts.join('::');
  }

  static String? getNamespaceForElement(
      Element? referredElement, Element referringElement) {
    final referredElementLibrary = referredElement?.library;
    if (referredElementLibrary == null) {
      return null;
    }
    final sourceLibrary = referringElement.library;
    if (sourceLibrary == null) {
      return null;
    }
    // search for the import of the referred library
    for (final libraryImport
        in sourceLibrary.definingCompilationUnit.libraryImports) {
      final importedLibrary = libraryImport.importedLibrary;
      if (importedLibrary == null) {
        continue;
      }
      if (importedLibrary.library.id == referredElementLibrary.id) {
        // we found the import => return the given prefix (if specified)
        return libraryImport.prefix?.element.name;
      }
    }

    return null;
  }
}
