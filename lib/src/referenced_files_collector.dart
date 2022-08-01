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

  FileReference({
    required this.uri,
    required this.originLibrary,
    this.referencedLibrary,
    required this.type,
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
  }) {
    if (uri is DirectiveUriWithRelativeUriString) {
      fileReferences.add(FileReference(
        uri: uri.relativeUriString,
        originLibrary: originLibrary,
        referencedLibrary: referencedLibrary,
        type: type,
      ));
    }
  }
}
