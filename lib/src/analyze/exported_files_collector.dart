import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/visitor2.dart';

/// represents a file reference extracted from a dart source file
class FileReference {
  /// uri of the file
  final String uri;

  /// library the reference comes from
  final LibraryElement2 originLibrary;

  /// library the reference points to
  final LibraryElement2? referencedLibrary;

  /// list of show parameters for this reference
  final List<String> shownNames;

  /// list of hide parameters for this reference
  final List<String> hiddenNames;

  /// constructor
  FileReference({
    required this.uri,
    required this.originLibrary,
    this.referencedLibrary,
    this.shownNames = const [],
    this.hiddenNames = const [],
  });
}

/// connector to collect exported files from an Element
///
/// it will collect all encountered export elements and store them to [fileReferences]
class ExportedFilesCollector extends RecursiveElementVisitor2<void> {
  final fileReferences = List<FileReference>.empty(growable: true);

  @override
  void visitLibraryElement(LibraryElement2 element) {
    for (final libraryFragment in element.fragments) {
      for (final exportedLibrary in libraryFragment.libraryExports2) {
        _addUri(
          uri: exportedLibrary.uri,
          originLibrary: element,
          referencedLibrary: exportedLibrary.exportedLibrary2,
          combinators: exportedLibrary.combinators,
        );
      }
    }
  }

  void _addUri({
    required DirectiveUri uri,
    required LibraryElement2 originLibrary,
    LibraryElement2? referencedLibrary,
    required List<NamespaceCombinator> combinators,
  }) {
    if (uri is DirectiveUriWithRelativeUriString) {
      fileReferences.add(FileReference(
        uri: uri.relativeUriString,
        originLibrary: originLibrary,
        referencedLibrary: referencedLibrary,
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
