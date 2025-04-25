// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

/// represents a file reference extracted from a dart source file
class FileReference {
  /// uri of the file
  final String uri;

  /// library the reference comes from
  final LibraryElement originLibrary;

  /// library the reference points to
  final LibraryElement? referencedLibrary;

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
class ExportedFilesCollector extends RecursiveElementVisitor<void> {
  final fileReferences = List<FileReference>.empty(growable: true);

  @override
  visitLibraryExportElement(LibraryExportElement element) {
    _addUri(
      uri: element.uri,
      originLibrary: element.library,
      referencedLibrary: element.exportedLibrary,
      combinators: element.combinators,
    );
    super.visitLibraryExportElement(element);
  }

  void _addUri({
    required DirectiveUri uri,
    required LibraryElement originLibrary,
    LibraryElement? referencedLibrary,
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
