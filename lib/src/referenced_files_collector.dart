import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

enum FileReferenceType {
  import,
  export,
}

class FileReference {
  final String uri;
  final LibraryElement originLibrary;
  final LibraryElement? referencedLibrary;
  final FileReferenceType type;
  final List<String> shownNames;
  final List<String> hiddenNames;

  FileReference({
    required this.uri,
    required this.originLibrary,
    this.referencedLibrary,
    required this.type,
    this.shownNames = const [],
    this.hiddenNames = const [],
  });
}

class ReferencedFilesCollector extends RecursiveElementVisitor<void> {
  final fileReferences = List<FileReference>.empty(growable: true);

  @override
  visitLibraryExportElement(LibraryExportElement element) {
    _addUri(
      uri: element.uri,
      originLibrary: element.library,
      referencedLibrary: element.exportedLibrary,
      type: FileReferenceType.export,
      combinators: element.combinators,
    );
    super.visitLibraryExportElement(element);
  }

  @override
  visitLibraryImportElement(LibraryImportElement element) {
    // _addUri(
    //   uri: element.uri,
    //   originLibrary: element.library,
    //   referencedLibrary: element.importedLibrary,
    //   type: FileReferenceType.import,
    // );
    super.visitLibraryImportElement(element);
  }

  void _addUri({
    required DirectiveUri uri,
    required LibraryElement originLibrary,
    LibraryElement? referencedLibrary,
    required FileReferenceType type,
    required List<NamespaceCombinator> combinators,
  }) {
    if (uri is DirectiveUriWithRelativeUriString) {
      fileReferences.add(FileReference(
        uri: uri.relativeUriString,
        originLibrary: originLibrary,
        referencedLibrary: referencedLibrary,
        type: type,
        shownNames: _getShownNamesFromCombinators(combinators),
        hiddenNames: _getHiddenNamesFromCombinators(combinators),
      ));
    }
  }

  List<String> _getShownNamesFromCombinators(
      List<NamespaceCombinator> combinators) {
    final List<String> shownNames = [];
    for (final c in combinators) {
      if (c is ShowElementCombinator) {
        shownNames.addAll(c.shownNames);
      }
    }
    return shownNames;
  }

  List<String> _getHiddenNamesFromCombinators(
      List<NamespaceCombinator> combinators) {
    final List<String> hiddenNames = [];
    for (final c in combinators) {
      if (c is HideElementCombinator) {
        hiddenNames.addAll(c.hiddenNames);
      }
    }
    return hiddenNames;
  }
}
