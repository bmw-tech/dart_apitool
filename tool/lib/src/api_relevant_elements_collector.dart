import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:stack/stack.dart';

import '../utils/string_utils.dart';
import 'model/internal/internal_class_declaration.dart';
import 'model/internal/internal_executable_declaration.dart';
import 'model/internal/internal_field_declaration.dart';

typedef OnTypeUsedHandler = void Function(DartType onTypeUsed);

/// collector to get all the API relevant information out of an AST
///
/// It tracks the found elements in its public properties:
/// - [classDeclarations]
/// - [executableDeclarations]
/// - [fieldDeclarations]
class APIRelevantElementsCollector extends RecursiveElementVisitor<void> {
  APIRelevantElementsCollector({
    this.isOnlyPublic = true,
    List<String> shownNames = const [],
    List<String> hiddenNames = const [],
    OnTypeUsedHandler? onTypeUsedHandler,

    /// [visitedElementIds] is the set of element ids that are already visited and therefore should not be visited by this visitor
    Set<int>? visitedElementIds,
  }) : _context = _AnalysisContext(
          shownNames: shownNames,
          hiddenNames: hiddenNames,
        ) {
    _onTypeUsedHandler = onTypeUsedHandler ?? _onTypeUsed;
    _visitedElementIds = <int>{};
    if (visitedElementIds != null) {
      _visitedElementIds.addAll(visitedElementIds);
    }
  }

  late final Set<int> _visitedElementIds;
  final _AnalysisContext _context;

  String? _packageName;

  // ignore: unused_element
  ExecutableElement? get _currentExecutableContext {
    if (_context.executablesStack.isNotEmpty) {
      return _context.executablesStack.top();
    }
    return null;
  }

  final List<InternalClassDeclaration> _classDeclarations = [];
  final List<InternalExecutableDeclaration> _executableDeclarations = [];
  final List<InternalFieldDeclaration> _fieldDeclarations = [];

  /// all found class declarations
  List<InternalClassDeclaration> get classDeclarations => _classDeclarations;

  /// all found executable declarations (like methods and constructors)
  List<InternalExecutableDeclaration> get executableDeclarations =>
      _executableDeclarations;

  /// all found field declarations (fields, top level variables and properties)
  List<InternalFieldDeclaration> get fieldDeclarations => _fieldDeclarations;

  /// determines if the collector shall only collect publicly exposed declarations
  final bool isOnlyPublic;
  late final OnTypeUsedHandler _onTypeUsedHandler;

  void _executeInContext({
    required Function toExecute,
    required Function onEnter,
    required Function onExit,
  }) {
    onEnter();
    toExecute();
    onExit();
  }

  void _executeInClassContext({
    required Function toExecute,
    required ClassElement classContext,
  }) {
    _executeInContext(
      toExecute: toExecute,
      onEnter: () => _context.classesStack.push(classContext),
      onExit: () => _context.classesStack.pop(),
    );
  }

  void _executeInExecutableContext({
    required Function toExecute,
    required ExecutableElement executableContext,
  }) {
    _executeInContext(
      toExecute: toExecute,
      onEnter: () => _context.executablesStack.push(executableContext),
      onExit: () => _context.executablesStack.pop(),
    );
  }

  void _onTypeUsed(DartType type) {
    if (type is InterfaceType) {
      _onInterfaceTypeUsed(type);
    }
  }

  void _onInterfaceTypeUsed(InterfaceType type) {
    final directElement = type.element;
    if (_visitedElementIds.contains(type.element.id)) {
      return;
    }
    final packageName = getPackageNameFromLibrary(directElement.library);
    if (packageName == _packageName) {
      //create new collector with isOnlyPublic = false as we know that this type is used directly and therefore gets exported implicitly (e.g. private mixins (Freezed))
      final collector = APIRelevantElementsCollector(
        isOnlyPublic: false,
        visitedElementIds: _visitedElementIds,
      );
      directElement.accept(collector);
      // merge result with this result
      _visitedElementIds.addAll(collector._visitedElementIds);
      classDeclarations.addAll(collector.classDeclarations);
      executableDeclarations.addAll(collector.executableDeclarations);
      fieldDeclarations.addAll(collector.fieldDeclarations);
    }
    for (final ta in type.typeArguments) {
      if (ta is InterfaceType) {
        _onTypeUsedHandler(ta);
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

  /// marks the given element as visited.
  /// Returns [true] if it got marked, returns [false] if it is already marked as visited
  bool _markElementAsVisited(Element element) {
    if (_visitedElementIds.contains(element.id)) {
      return false;
    }
    _visitedElementIds.add(element.id);
    return true;
  }

  @override
  void visitClassElement(ClassElement element) {
    _onVisitAnyElement(element);
    if (!_isNameExported(element.name)) {
      return;
    }
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    if (!_markElementAsVisited(element)) {
      return;
    }
    _classDeclarations.add(InternalClassDeclaration.fromClassElement(element));
    for (final st in element.allSupertypes) {
      if (!st.element.isDartCoreObject && !st.element.isDartCoreEnum) {
        _onTypeUsedHandler(st);
      }
    }
    _executeInClassContext(
      toExecute: () {
        super.visitClassElement(element);
      },
      classContext: element,
    );
  }

  @override
  void visitFieldElement(FieldElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    if (!_markElementAsVisited(element)) {
      return;
    }
    _fieldDeclarations
        .add(InternalFieldDeclaration.fromPropertyInducingElement(element));
    super.visitFieldElement(element);
    if (element.type.element != null) {
      _onTypeUsedHandler(element.type);
    }
  }

  @override
  visitTopLevelVariableElement(TopLevelVariableElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    if (!_markElementAsVisited(element)) {
      return;
    }
    _fieldDeclarations
        .add(InternalFieldDeclaration.fromPropertyInducingElement(element));
    super.visitTopLevelVariableElement(element);
    if (element.type.element != null) {
      _onTypeUsedHandler(element.type);
    }
  }

  @override
  void visitParameterElement(ParameterElement element) {
    _onVisitAnyElement(element);
    super.visitParameterElement(element);
    // this includes method, function and constructor calls
    if (element.type.element != null) {
      _onTypeUsedHandler(element.type);
    }
  }

  @override
  void visitMethodElement(MethodElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    if (!_markElementAsVisited(element)) {
      return;
    }
    _executableDeclarations
        .add(InternalExecutableDeclaration.fromExecutableElement(
      element,
    ));
    _executeInExecutableContext(
      toExecute: () {
        super.visitMethodElement(element);
      },
      executableContext: element,
    );
    if (element.returnType.element != null) {
      _onTypeUsedHandler(element.returnType);
    }
  }

  @override
  visitFunctionElement(FunctionElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    if (!_markElementAsVisited(element)) {
      return;
    }
    _executableDeclarations
        .add(InternalExecutableDeclaration.fromExecutableElement(
      element,
    ));
    _executeInExecutableContext(
      toExecute: () {
        super.visitFunctionElement(element);
      },
      executableContext: element,
    );
    if (element.returnType.element != null) {
      _onTypeUsedHandler(element.returnType);
    }
  }

  @override
  visitConstructorElement(ConstructorElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    if (!_markElementAsVisited(element)) {
      return;
    }

    _executableDeclarations
        .add(InternalExecutableDeclaration.fromExecutableElement(
      element,
    ));

    _executeInExecutableContext(
      toExecute: () {
        super.visitConstructorElement(element);
      },
      executableContext: element,
    );
  }

  @override
  visitTypeAliasElement(TypeAliasElement element) {
    _onVisitAnyElement(element);
    super.visitTypeAliasElement(element);
    if (element.aliasedType.element != null) {
      _onTypeUsedHandler(element.aliasedType);
    }
  }

  @override
  visitTypeParameterElement(TypeParameterElement element) {
    _onVisitAnyElement(element);
    super.visitTypeParameterElement(element);
    if (element.bound?.element != null) {
      _onTypeUsedHandler(element.bound!);
    }
  }

  @override
  void visitExtensionElement(ExtensionElement element) {
    _onVisitAnyElement(element);
    super.visitExtensionElement(element);
    if (element.extendedType.element != null) {
      _onTypeUsedHandler(element.extendedType);
    }
  }
}

class _AnalysisContext {
  final List<String> shownNames;
  final List<String> hiddenNames;

  final Stack<ClassElement> classesStack = Stack<ClassElement>();
  final Stack<ExecutableElement> executablesStack = Stack<ExecutableElement>();

  _AnalysisContext({
    this.shownNames = const [],
    this.hiddenNames = const [],
  });
}
