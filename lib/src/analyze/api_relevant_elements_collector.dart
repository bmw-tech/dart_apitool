import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element2.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor2.dart';

import '../model/internal/internal_declaration_utils.dart';
import '../model/internal/internal_type_alias_declaration.dart';
import '../model/internal/internal_type_usage.dart';
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
class APIRelevantElementsCollector extends RecursiveElementVisitor2<void> {
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

    /// the already collected type hierarchy
    required this.typeHierarchy,
  }) : _context = _AnalysisContext(
          shownNames: shownNames,
          hiddenNames: hiddenNames,
          namespace: namespace,
          rootPath: rootPath,
        ) {
    _collectedElementIds = <int>{};
    if (collectedElementIds != null) {
      _collectedElementIds.addAll(collectedElementIds);
    }
  }

  late final Set<int> _collectedElementIds;

  /// [directlyCollectedElementIds] is the set of element ids that are directly collected by this visitor
  Set<int> directlyCollectedElementIds = {};

  final _AnalysisContext _context;

  String? _packageName;

  final List<InternalInterfaceDeclaration> _interfaceDeclarations = [];
  final List<InternalExecutableDeclaration> _executableDeclarations = [];
  final List<InternalFieldDeclaration> _fieldDeclarations = [];
  final List<InternalTypeAliasDeclaration> _typeAliasDeclarations = [];
  final Map<int, Set<InternalTypeUsage>> typeUsages = {};
  final TypeHierarchy typeHierarchy;

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

  /// list of element ids that are allowed to be collected even if they are private
  final List<int> privateElementExceptions;

  void _onTypeUsed(DartType type, Element2 referringElement,
      {required TypeUsageKind typeUsageKind}) {
    final directElement = type.element3;
    final directElementLibrary = directElement?.library2;
    if (directElement == null || directElementLibrary == null) {
      return;
    }
    if (!typeUsages.containsKey(directElement.id)) {
      typeUsages[directElement.id] = {};
    }
    typeUsages[directElement.id]!.add(
      InternalTypeUsage.fromElement(
        kind: typeUsageKind,
        element: referringElement,
      ),
    );

    if (_collectedElementIds.contains(directElement.id)) {
      return;
    }

    _collectTypeHierarchy(type.element3);

    final packageName = getPackageNameFromLibrary(directElementLibrary);
    if (packageName == _packageName) {
      //create new collector with the used type as an exception from the public element restrictions
      final collector = APIRelevantElementsCollector(
        privateElementExceptions: [directElement.id],
        // pass on the already collected elements to make sure that we don't collect elements twice even if we are going down the usage tree
        collectedElementIds: _collectedElementIds,
        typeHierarchy: typeHierarchy,
        namespace: InternalDeclarationUtils.getNamespaceForElement(
            directElement, referringElement),
        rootPath: _context.rootPath,
      );
      directElement.accept2(collector);
      // merge result with this result
      _collectedElementIds.addAll(collector._collectedElementIds);
      interfaceDeclarations.addAll(collector.interfaceDeclarations);
      executableDeclarations.addAll(collector.executableDeclarations);
      fieldDeclarations.addAll(collector.fieldDeclarations);
      typeAliasDeclarations.addAll(collector.typeAliasDeclarations);
      for (final tu in collector.typeUsages.entries) {
        if (!typeUsages.containsKey(tu.key)) {
          typeUsages[tu.key] = {};
        }
        typeUsages[tu.key]!.addAll(tu.value);
      }
    }
    if (type is InterfaceType) {
      for (final ta in type.typeArguments) {
        if (ta is InterfaceType) {
          _onTypeUsed(
            ta,
            referringElement,
            typeUsageKind: TypeUsageKind.hierarchy,
          );
        }
      }
    } else if (type is TypeAlias) {
      final aliasedType = type.alias?.element2.aliasedType;
      if (aliasedType != null) {
        _onTypeUsed(
          aliasedType,
          referringElement,
          typeUsageKind: TypeUsageKind.hierarchy,
        );
      }
    }
  }

  void _collectTypeHierarchy(Element2? element) {
    final baseTypeIdentifiers = <TypeIdentifier>{};
    if (element is InterfaceElement2) {
      for (final st in element.allSupertypes) {
        baseTypeIdentifiers.add(TypeIdentifier.fromNameAndLibraryPath(
          typeName: st.element3.name3 ?? st.element3.displayName,
          libraryPath: NamingUtils.getFullLibraryPathFromElement(
            element: st.element3,
          ),
        ));
      }
      typeHierarchy.registerType(
        TypeIdentifier.fromNameAndLibraryPath(
          typeName: element.name3 ?? element.displayName,
          libraryPath: NamingUtils.getFullLibraryPathFromElement(
            element: element,
          ),
        ),
        baseTypeIdentifiers,
      );
    }
  }

  void _onVisitAnyElement(Element2 element) {
    // set the package name to the first element's package we see
    _packageName ??= element.library2 != null
        ? getPackageNameFromLibrary(element.library2!)
        : null;

    _collectTypeHierarchy(element);
  }

  bool _isNameExported(String name) {
    if (_context.shownNames.isNotEmpty) {
      return _context.shownNames.contains(name);
    }
    return !_context.hiddenNames.contains(name);
  }

  bool _isElementAllowedToBeCollected(Element2 element) {
    // here we filter out elements that are technically part of the public API but actually aren't accessible
    // (like Enum constructors)
    if (element is ConstructorElement2) {
      // constructors of enums aren't collected
      if (element.enclosingElement2 is EnumElement2) {
        return false;
      }
    }
    // don't collect any override -> already part of the source
    if (element is Annotatable &&
        (element as Annotatable).metadata2.hasOverride) {
      return false;
    }

    var isInternal = false;

    if (element is Annotatable) {
      isInternal = InternalDeclarationUtils.hasInternal(element as Annotatable);
    }

    // if the element is public, it is allowed to be collected
    if (!isInternal && element.isPublic) {
      return true;
    }
    // only collect explicitly allowed private or internal elements (are used somewhere and therefore implicitly public)
    return privateElementExceptions.contains(element.id);
  }

  /// marks the given element as collected.
  /// Returns [true] if it got marked, returns [false] if it is already marked as collected
  bool _markElementAsCollected(Element2 element) {
    directlyCollectedElementIds.add(element.id);
    if (_collectedElementIds.contains(element.id)) {
      return false;
    }
    _collectedElementIds.add(element.id);
    return true;
  }

  bool _onVisitInterfaceElement(InterfaceElement2 interfaceElement) {
    _onVisitAnyElement(interfaceElement);
    if (interfaceElement.name3 != null &&
        !_isNameExported(interfaceElement.name3!)) {
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
        _onTypeUsed(st, interfaceElement,
            typeUsageKind: TypeUsageKind.hierarchy);
      }
    }
    return true;
  }

  @override
  void visitClassElement(ClassElement2 element) {
    if (_onVisitInterfaceElement(element)) {
      super.visitClassElement(element);
    }
  }

  @override
  void visitEnumElement(EnumElement2 element) {
    if (_onVisitInterfaceElement(element)) {
      super.visitEnumElement(element);
    }
  }

  @override
  void visitMixinElement(MixinElement2 element) {
    if (_onVisitInterfaceElement(element)) {
      super.visitMixinElement(element);
    }
  }

  @override
  void visitFieldElement(FieldElement2 element) {
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
    if (element.type.element3 != null) {
      bool canBeSet = !element.isFinal &&
          !element.isConst &&
          !element.isPrivate &&
          element.setter2 != null;
      _onTypeUsed(element.type, element, typeUsageKind: TypeUsageKind.output);
      if (canBeSet) {
        _onTypeUsed(element.type, element, typeUsageKind: TypeUsageKind.input);
      }
    }
  }

  @override
  visitTopLevelVariableElement(TopLevelVariableElement2 element) {
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
    if (element.type.element3 != null) {
      bool canBeSet =
          !element.isFinal && !element.isConst && !element.isPrivate;
      _onTypeUsed(element.type, element, typeUsageKind: TypeUsageKind.output);
      if (canBeSet) {
        _onTypeUsed(element.type, element, typeUsageKind: TypeUsageKind.input);
      }
    }
  }

  @override
  void visitFormalParameterElement(FormalParameterElement element) {
    _onVisitAnyElement(element);
    super.visitFormalParameterElement(element);
    // exclude parameters for fields and properties as they are handled separately
    if (element.enclosingElement2 is PropertyAccessorElement2) {
      return;
    }
    // this includes method, function and constructor calls
    if (element.type.element3 != null) {
      _onTypeUsed(element.type, element, typeUsageKind: TypeUsageKind.input);
    }
  }

  @override
  void visitMethodElement(MethodElement2 element) {
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
    if (element.returnType.element3 != null) {
      _onTypeUsed(element.returnType, element,
          typeUsageKind: TypeUsageKind.output);
    }
  }

  @override
  void visitTopLevelFunctionElement(TopLevelFunctionElement element) {
    if (_onVisitFunctionElement(element)) {
      super.visitTopLevelFunctionElement(element);
    }
  }

  @override
  void visitLocalFunctionElement(LocalFunctionElement element) {
    if (_onVisitFunctionElement(element)) {
      super.visitLocalFunctionElement(element);
    }
  }

  bool _onVisitFunctionElement(ExecutableElement2 element) {
    _onVisitAnyElement(element);
    if (!_isElementAllowedToBeCollected(element)) {
      return false;
    }
    if (!_markElementAsCollected(element)) {
      return false;
    }
    _executableDeclarations
        .add(InternalExecutableDeclaration.fromExecutableElement(
      element,
      namespace: _context.namespace,
      rootPath: _context.rootPath,
    ));
    if (element.returnType.element3 != null) {
      _onTypeUsed(element.returnType, element,
          typeUsageKind: TypeUsageKind.output);
    }
    return true;
  }

  @override
  visitConstructorElement(ConstructorElement2 element) {
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
  visitTypeAliasElement(TypeAliasElement2 element) {
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
    if (element.aliasedType.element3 != null) {
      _onTypeUsed(element.aliasedType, element,
          typeUsageKind: TypeUsageKind.hierarchy);
    }
  }

  @override
  visitTypeParameterElement(TypeParameterElement2 element) {
    _onVisitAnyElement(element);
    super.visitTypeParameterElement(element);
    if (element.bound?.element3 != null) {
      _onTypeUsed(element.bound!, element,
          typeUsageKind: TypeUsageKind.hierarchy);
    }
  }

  @override
  void visitExtensionElement(ExtensionElement2 element) {
    _onVisitAnyElement(element);
    if (element.name3 != null && !_isNameExported(element.name3!)) {
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
    if (element.extendedType.element3 != null) {
      _onTypeUsed(element.extendedType, element,
          typeUsageKind: TypeUsageKind.hierarchy);
    }

    super.visitExtensionElement(element);
  }
}

class _AnalysisContext {
  final List<String> shownNames;
  final List<String> hiddenNames;
  final String? namespace;
  final String rootPath;

  _AnalysisContext({
    this.shownNames = const [],
    this.hiddenNames = const [],
    this.namespace,
    required this.rootPath,
  });
}
