// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';

import '../model/internal/internal_declaration_utils.dart';
import '../model/internal/internal_type_alias_declaration.dart';
import '../model/model.dart';
import '../model/internal/internal_interface_declaration.dart';
import '../model/internal/internal_executable_declaration.dart';
import '../model/internal/internal_field_declaration.dart';
import '../utils/utils.dart';

/// collector to get all the API relevant information out of an AST
///
/// It tracks the found elements in its public properties:
/// - [interfaceDeclarations]
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

    /// the root path of the project
    required String rootPath,

    /// the root path of the cluster of packages
    required String clusterRootPath,

    /// the already collected type hierarchy items
    Map<String, TypeHierarchyItem>? typeHierarchyItems,
  }) : _context = _AnalysisContext(
          shownNames: shownNames,
          hiddenNames: hiddenNames,
          namespace: namespace,
          rootPath: rootPath,
          clusterRootPath: clusterRootPath,
        ) {
    _collectedElementIds = <int>{};
    if (collectedElementIds != null) {
      _collectedElementIds.addAll(collectedElementIds);
    }
    if (typeHierarchyItems != null) {
      _typeHierarchyItems.addAll(typeHierarchyItems);
    }
  }

  late final Set<int> _collectedElementIds;
  final _AnalysisContext _context;

  String? _packageName;

  final List<InternalInterfaceDeclaration> _interfaceDeclarations = [];
  final List<InternalExecutableDeclaration> _executableDeclarations = [];
  final List<InternalFieldDeclaration> _fieldDeclarations = [];
  final List<InternalTypeAliasDeclaration> _typeAliasDeclarations = [];
  final Set<int> _requiredElementIds = {};
  final Map<String, TypeHierarchyItem> _typeHierarchyItems = {};

  /// all found class declarations
  List<InternalInterfaceDeclaration> get interfaceDeclarations =>
      _interfaceDeclarations;

  /// all found executable declarations (like methods and constructors)
  List<InternalExecutableDeclaration> get executableDeclarations =>
      _executableDeclarations;

  /// all found field declarations (fields, top level variables and properties)
  List<InternalFieldDeclaration> get fieldDeclarations => _fieldDeclarations;

  /// all found type alias declarations
  List<InternalTypeAliasDeclaration> get typeAliasDeclarations =>
      _typeAliasDeclarations;

  /// all element ids that are used in a required context (e.g. implementable / extendable by the user)
  Set<int> get requiredElementIds => _requiredElementIds;

  /// the collected type hierarchy
  Map<String, TypeHierarchyItem> get typeHierarchyItems => _typeHierarchyItems;

  /// list of element ids that are allowed to be collected even if they are private
  final List<int> privateElementExceptions;

  void _onTypeUsed(DartType type, Element referringElement,
      {required bool isRequired}) {
    final directElement = type.element2;
    final directElementLibrary = directElement?.library;
    if (directElement == null || directElementLibrary == null) {
      return;
    }
    if (isRequired) {
      _requiredElementIds.add(directElement.id);
    }
    if (_collectedElementIds.contains(directElement.id)) {
      return;
    }

    _collectTypeHierarchy(type.element);

    final packageName = getPackageNameFromLibrary(directElementLibrary);
    if (packageName == _packageName) {
      //create new collector with the used type as an exception from the public element restrictions
      final collector = APIRelevantElementsCollector(
        privateElementExceptions: [directElement.id],
        // pass on the already collected elements to make sure that we don't collect elements twice even if we are going down the usage tree
        collectedElementIds: _collectedElementIds,
        typeHierarchyItems: _typeHierarchyItems,
        namespace: InternalDeclarationUtils.getNamespaceForElement(
            type.element2, referringElement),
        rootPath: _context.rootPath,
        clusterRootPath: _context.clusterRootPath,
      );
      directElement.accept(collector);
      // merge result with this result
      _collectedElementIds.addAll(collector._collectedElementIds);
      _typeHierarchyItems.addAll(collector._typeHierarchyItems);
      interfaceDeclarations.addAll(collector.interfaceDeclarations);
      executableDeclarations.addAll(collector.executableDeclarations);
      fieldDeclarations.addAll(collector.fieldDeclarations);
      typeAliasDeclarations.addAll(collector.typeAliasDeclarations);
      _requiredElementIds.addAll(collector.requiredElementIds);
    }
    if (type is InterfaceType) {
      for (final ta in type.typeArguments) {
        if (ta is InterfaceType) {
          _onTypeUsed(ta, referringElement, isRequired: false);
        }
      }
    } else if (type is TypeAlias) {
      final aliasedType = type.alias?.element.aliasedType;
      if (aliasedType != null) {
        _onTypeUsed(aliasedType, referringElement, isRequired: false);
      }
    }
  }

  void _collectTypeHierarchy(Element? element) {
    final baseTypeIdentifiers = <String>{};
    if (element is InterfaceElement) {
      for (final st in element.allSupertypes) {
        baseTypeIdentifiers.add(
          NamingUtils.computeUniqueTypeName(
              _context.clusterRootPath, st.element),
        );
      }
      final hierarchyItem = TypeHierarchyItem(
        name: element.name,
        namespace: _context.namespace ?? '',
        fullLibraryName: element.librarySource.fullName,
        baseTypeIdentifiers: baseTypeIdentifiers,
      );
      if (!_typeHierarchyItems
          .containsKey(hierarchyItem.getUniqueName(_context.clusterRootPath))) {
        _typeHierarchyItems[hierarchyItem
            .getUniqueName(_context.clusterRootPath)] = hierarchyItem;
      }
    }
  }

  void _onVisitAnyElement(Element element) {
    // set the package name to the first element's package we see
    _packageName ??= element.library?.identifier != null
        ? getPackageNameFromLibrary(element.library!)
        : null;

    _collectTypeHierarchy(element);
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

  bool _onVisitInterfaceElement(InterfaceElement interfaceElement) {
    _onVisitAnyElement(interfaceElement);
    if (!_isNameExported(interfaceElement.name)) {
      return false;
    }
    if (!_isElementAllowedToBeCollected(interfaceElement)) {
      return false;
    }
    if (!_markElementAsCollected(interfaceElement)) {
      return false;
    }
    _interfaceDeclarations
        .add(InternalInterfaceDeclaration.fromInterfaceElement(
      interfaceElement,
      namespace: _context.namespace,
      rootPath: _context.rootPath,
    ));
    for (final st in interfaceElement.allSupertypes) {
      if (!st.isDartCoreObject && !st.isDartCoreEnum) {
        _onTypeUsed(st, interfaceElement, isRequired: false);
      }
    }
    return true;
  }

  @override
  void visitClassElement(ClassElement element) {
    if (_onVisitInterfaceElement(element)) {
      super.visitClassElement(element);
    }
  }

  @override
  void visitEnumElement(EnumElement element) {
    if (_onVisitInterfaceElement(element)) {
      super.visitEnumElement(element);
    }
  }

  @override
  void visitMixinElement(MixinElement element) {
    if (_onVisitInterfaceElement(element)) {
      super.visitMixinElement(element);
    }
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
    _fieldDeclarations.add(InternalFieldDeclaration.fromPropertyInducingElement(
      element,
      rootPath: _context.rootPath,
    ));
    super.visitFieldElement(element);
    if (element.type.element2 != null) {
      bool canBeSet = !element.isFinal &&
          !element.isConst &&
          !element.isPrivate &&
          element.setter != null;
      _onTypeUsed(element.type, element, isRequired: canBeSet);
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
      rootPath: _context.rootPath,
    ));
    super.visitTopLevelVariableElement(element);
    if (element.type.element2 != null) {
      bool canBeSet =
          !element.isFinal && !element.isConst && !element.isPrivate;
      _onTypeUsed(element.type, element, isRequired: canBeSet);
    }
  }

  @override
  void visitParameterElement(ParameterElement element) {
    _onVisitAnyElement(element);
    super.visitParameterElement(element);
    // exclude parameters for fields and properties as they are handled separately
    if (element.enclosingElement is PropertyAccessorElement) {
      return;
    }
    // this includes method, function and constructor calls
    if (element.type.element2 != null) {
      _onTypeUsed(element.type, element, isRequired: true);
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
      rootPath: _context.rootPath,
    ));
    super.visitMethodElement(element);
    if (element.returnType.element2 != null) {
      _onTypeUsed(element.returnType, element, isRequired: false);
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
      rootPath: _context.rootPath,
    ));
    super.visitFunctionElement(element);
    if (element.returnType.element2 != null) {
      _onTypeUsed(element.returnType, element, isRequired: false);
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
        .add(InternalExecutableDeclaration.fromExecutableElement(
      element,
      rootPath: _context.rootPath,
    ));

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
      rootPath: _context.rootPath,
    ));
    super.visitTypeAliasElement(element);
    if (element.aliasedType.element2 != null) {
      _onTypeUsed(element.aliasedType, element, isRequired: false);
    }
  }

  @override
  visitTypeParameterElement(TypeParameterElement element) {
    _onVisitAnyElement(element);
    super.visitTypeParameterElement(element);
    if (element.bound?.element2 != null) {
      _onTypeUsed(element.bound!, element, isRequired: false);
    }
  }

  @override
  void visitExtensionElement(ExtensionElement element) {
    _onVisitAnyElement(element);
    if (element.name != null && !_isNameExported(element.name!)) {
      return;
    }
    if (!_isElementAllowedToBeCollected(element)) {
      return;
    }
    if (!_markElementAsCollected(element)) {
      return;
    }
    _interfaceDeclarations
        .add(InternalInterfaceDeclaration.fromExtensionElement(
      element,
      namespace: _context.namespace,
      rootPath: _context.rootPath,
    ));
    if (element.extendedType.element2 != null) {
      _onTypeUsed(element.extendedType, element, isRequired: false);
    }

    super.visitExtensionElement(element);
  }
}

class _AnalysisContext {
  final List<String> shownNames;
  final List<String> hiddenNames;
  final String? namespace;
  final String rootPath;

  /// the root path for the package cluster we analyze in. Most of the time this is rootPath
  /// only if we copy a cluster because of path dependencies they will differ
  final String clusterRootPath;

  _AnalysisContext({
    this.shownNames = const [],
    this.hiddenNames = const [],
    this.namespace,
    required this.rootPath,
    required this.clusterRootPath,
  });
}
