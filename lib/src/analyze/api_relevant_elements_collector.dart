// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';

import '../model/internal/internal_type_alias_declaration.dart';
import '../utils/string_utils.dart';
import '../model/internal/internal_class_declaration.dart';
import '../model/internal/internal_executable_declaration.dart';
import '../model/internal/internal_field_declaration.dart';

/// collector to get all the API relevant information out of an AST
///
/// It tracks the found elements in its public properties:
/// - [classDeclarations]
/// - [executableDeclarations]
/// - [fieldDeclarations]
/// - [typeAliasDeclarations]
class APIRelevantElementsCollector extends RecursiveElementVisitor<void> {
  APIRelevantElementsCollector({
    this.privateElementExceptions = const [],

    /// [shownNames] are all element names that are marked as "shown" when the visited item got exported
    List<String> shownNames = const [],

    /// [hiddenNames] are all element names that are marked as "hidden" when the visited item got exported
    List<String> hiddenNames = const [],

    /// [namespace] defines the namespace all items are imported into
    String? namespace,

    /// [collectedElementIds] is the set of element ids that are already collected and therefore should not be collected (again) by this visitor
    Set<int>? collectedElementIds,
  }) : _context = _AnalysisContext(
          shownNames: shownNames,
          hiddenNames: hiddenNames,
          namespace: namespace,
        ) {
    _collectedElementIds = <int>{};
    if (collectedElementIds != null) {
      _collectedElementIds.addAll(collectedElementIds);
    }
  }

  late final Set<int> _collectedElementIds;
  final _AnalysisContext _context;

  String? _packageName;

  final List<InternalClassDeclaration> _classDeclarations = [];
  final List<InternalExecutableDeclaration> _executableDeclarations = [];
  final List<InternalFieldDeclaration> _fieldDeclarations = [];
  final List<InternalTypeAliasDeclaration> _typeAliasDeclarations = [];

  /// all found class declarations
  List<InternalClassDeclaration> get classDeclarations => _classDeclarations;

  /// all found executable declarations (like methods and constructors)
  List<InternalExecutableDeclaration> get executableDeclarations =>
      _executableDeclarations;

  /// all found field declarations (fields, top level variables and properties)
  List<InternalFieldDeclaration> get fieldDeclarations => _fieldDeclarations;

  /// all found type alias declarations
  List<InternalTypeAliasDeclaration> get typeAliasDeclarations =>
      _typeAliasDeclarations;

  /// list of element ids that are allowed to be collected even if they are private
  final List<int> privateElementExceptions;

  String? _getNamespaceForLibrary(
      LibraryElement referredLibrary, Element referringElement) {
    final sourceLibrary = referringElement.library;
    if (sourceLibrary == null) {
      return null;
    }
    // search for the import of the referred library
    for (final libraryImport in sourceLibrary.libraryImports) {
      final importedLibrary = libraryImport.importedLibrary;
      if (importedLibrary == null) {
        continue;
      }
      if (importedLibrary.library.id == referredLibrary.id) {
        // we found the import => return the given prefix (if specified)
        return libraryImport.prefix?.element.name;
      }
    }

    return null;
  }

  void _onTypeUsed(DartType type, Element referringElement) {
    final directElement = type.element2;
    final directElementLibrary = directElement?.library;
    if (directElement == null || directElementLibrary == null) {
      return;
    }
    if (_collectedElementIds.contains(directElement.id)) {
      return;
    }
    final packageName = getPackageNameFromLibrary(directElementLibrary);
    if (packageName == _packageName) {
      //create new collector with the used type as an exception from the public element restrictions
      final collector = APIRelevantElementsCollector(
        privateElementExceptions: [directElement.id],
        // pass on the already collected elements to make sure that we don't collect elements twice even if we are going down the usage tree
        collectedElementIds: _collectedElementIds,
        namespace:
            _getNamespaceForLibrary(directElementLibrary, referringElement),
      );
      directElement.accept(collector);
      // merge result with this result
      _collectedElementIds.addAll(collector._collectedElementIds);
      classDeclarations.addAll(collector.classDeclarations);
      executableDeclarations.addAll(collector.executableDeclarations);
      fieldDeclarations.addAll(collector.fieldDeclarations);
      typeAliasDeclarations.addAll(collector.typeAliasDeclarations);
    }
    if (type is InterfaceType) {
      for (final ta in type.typeArguments) {
        if (ta is InterfaceType) {
          _onTypeUsed(ta, referringElement);
        }
      }
    } else if (type is TypeAlias) {
      final aliasedType = type.alias?.element.aliasedType;
      if (aliasedType != null) {
        _onTypeUsed(aliasedType, referringElement);
      }
    }
  }

  void _onVisitAnyElement(Element element) {
    // set the package name to the first element's package we see
    _packageName ??= element.library?.identifier != null
        ? getPackageNameFromLibrary(element.library!)
        : null;
  }

  bool _isNameExported(String name) {
    if (_context.shownNames.isNotEmpty) {
      return _context.shownNames.contains(name);
    }
    return !_context.hiddenNames.contains(name);
  }

  bool _isElementAllowedToBeCollected(Element element) {
    if (element.isPublic) {
      return true;
    }
    return privateElementExceptions.contains(element.id);
  }

  /// marks the given element as collected.
  /// Returns [true] if it got marked, returns [false] if it is already marked as collected
  bool _markElementAsCollected(Element element) {
    if (_collectedElementIds.contains(element.id)) {
      return false;
    }
    _collectedElementIds.add(element.id);
    return true;
  }

  @override
  void visitClassElement(ClassElement element) {
    _onVisitAnyElement(element);
    if (!_isNameExported(element.name)) {
      return;
    }
    if (!_isElementAllowedToBeCollected(element)) {
      return;
    }
    if (!_markElementAsCollected(element)) {
      return;
    }
    _classDeclarations.add(InternalClassDeclaration.fromClassElement(element,
        namespace: _context.namespace));
    for (final st in element.allSupertypes) {
      if (!st.element.isDartCoreObject && !st.element.isDartCoreEnum) {
        _onTypeUsed(st, element);
      }
    }
    super.visitClassElement(element);
  }

  @override
  void visitFieldElement(FieldElement element) {
    _onVisitAnyElement(element);
    if (!_isElementAllowedToBeCollected(element)) {
      return;
    }
    if (!_markElementAsCollected(element)) {
      return;
    }
    _fieldDeclarations
        .add(InternalFieldDeclaration.fromPropertyInducingElement(element));
    super.visitFieldElement(element);
    if (element.type.element != null) {
      _onTypeUsed(element.type, element);
    }
  }

  @override
  visitTopLevelVariableElement(TopLevelVariableElement element) {
    _onVisitAnyElement(element);
    if (!_isElementAllowedToBeCollected(element)) {
      return;
    }
    if (!_markElementAsCollected(element)) {
      return;
    }
    _fieldDeclarations.add(InternalFieldDeclaration.fromPropertyInducingElement(
      element,
      namespace: _context.namespace,
    ));
    super.visitTopLevelVariableElement(element);
    if (element.type.element != null) {
      _onTypeUsed(element.type, element);
    }
  }

  @override
  void visitParameterElement(ParameterElement element) {
    _onVisitAnyElement(element);
    super.visitParameterElement(element);
    // this includes method, function and constructor calls
    if (element.type.element != null) {
      _onTypeUsed(element.type, element);
    }
  }

  @override
  void visitMethodElement(MethodElement element) {
    _onVisitAnyElement(element);
    if (!_isElementAllowedToBeCollected(element)) {
      return;
    }
    if (!_markElementAsCollected(element)) {
      return;
    }
    _executableDeclarations
        .add(InternalExecutableDeclaration.fromExecutableElement(
      element,
    ));
    super.visitMethodElement(element);
    if (element.returnType.element != null) {
      _onTypeUsed(element.returnType, element);
    }
  }

  @override
  visitFunctionElement(FunctionElement element) {
    _onVisitAnyElement(element);
    if (!_isElementAllowedToBeCollected(element)) {
      return;
    }
    if (!_markElementAsCollected(element)) {
      return;
    }
    _executableDeclarations
        .add(InternalExecutableDeclaration.fromExecutableElement(
      element,
      namespace: _context.namespace,
    ));
    super.visitFunctionElement(element);
    if (element.returnType.element2 != null) {
      _onTypeUsed(element.returnType, element);
    }
  }

  @override
  visitConstructorElement(ConstructorElement element) {
    _onVisitAnyElement(element);
    if (!_isElementAllowedToBeCollected(element)) {
      return;
    }
    if (!_markElementAsCollected(element)) {
      return;
    }

    _executableDeclarations
        .add(InternalExecutableDeclaration.fromExecutableElement(element));

    super.visitConstructorElement(element);
  }

  @override
  visitTypeAliasElement(TypeAliasElement element) {
    _onVisitAnyElement(element);
    if (!_isElementAllowedToBeCollected(element)) {
      return;
    }
    if (!_markElementAsCollected(element)) {
      return;
    }
    _typeAliasDeclarations
        .add(InternalTypeAliasDeclaration.fromTypeAliasElement(
      element,
      namespace: _context.namespace,
    ));
    super.visitTypeAliasElement(element);
    if (element.aliasedType.element != null) {
      _onTypeUsed(element.aliasedType, element);
    }
  }

  @override
  visitTypeParameterElement(TypeParameterElement element) {
    _onVisitAnyElement(element);
    super.visitTypeParameterElement(element);
    if (element.bound?.element != null) {
      _onTypeUsed(element.bound!, element);
    }
  }

  @override
  void visitExtensionElement(ExtensionElement element) {
    _onVisitAnyElement(element);
    super.visitExtensionElement(element);
    if (element.extendedType.element != null) {
      _onTypeUsed(element.extendedType, element);
    }
  }
}

class _AnalysisContext {
  final List<String> shownNames;
  final List<String> hiddenNames;
  final String? namespace;

  _AnalysisContext({
    this.shownNames = const [],
    this.hiddenNames = const [],
    this.namespace,
  });
}
