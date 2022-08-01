import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:stack/stack.dart';

import '../model/class_declaration.dart';
import '../model/executable_declaration.dart';
import '../model/field_declaration.dart';
import '../utils/string_utils.dart';

/// collector to get all the API relevant information out of an AST
///
/// It tracks the found elements in its public properties:
/// - [classDeclarations]
/// - [executableDeclarations]
/// - [fieldDeclarations]
class APIRelevantElementsCollector extends RecursiveElementVisitor<void> {
  APIRelevantElementsCollector({this.isOnlyPublic = true});

  final List<TypeDefiningElement> _visitedTypeElements = [];

  String? _packageName;

  var _classContext = Stack<ClassElement>();
  var _executableContext = Stack<ExecutableElement>();

  ClassElement? get _currentClassContext {
    if (_classContext.isNotEmpty) {
      return _classContext.top();
    }
    return null;
  }

  // ignore: unused_element
  ExecutableElement? get _currentExecutableContext {
    if (_executableContext.isNotEmpty) {
      return _executableContext.top();
    }
    return null;
  }

  final List<ClassDeclatation> _classDeclarations = [];
  final List<ExecutableDeclaration> _executableDeclarations = [];
  final List<FieldDeclaration> _fieldDeclarations = [];

  /// all found class declarations
  List<ClassDeclatation> get classDeclarations => _classDeclarations;

  /// all found executable declarations (like methods and constructors)
  List<ExecutableDeclaration> get executableDeclarations =>
      _executableDeclarations;

  /// all found field declarations (fields, top level variables and properties)
  List<FieldDeclaration> get fieldDeclarations => _fieldDeclarations;

  /// determines if the collector shall only collect publicly exposed declarations
  final bool isOnlyPublic;

  void _executeInRootContext({
    required Function toExecute,
  }) {
    final classContextBackup = _classContext;
    _classContext = Stack<ClassElement>();
    final executableContextBackup = _executableContext;
    _executableContext = Stack<ExecutableElement>();
    toExecute();
    _classContext = classContextBackup;
    _executableContext = executableContextBackup;
  }

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
      onEnter: () => _classContext.push(classContext),
      onExit: () => _classContext.pop(),
    );
  }

  void _executeInExecutableContext({
    required Function toExecute,
    required ExecutableElement executableContext,
  }) {
    _executeInContext(
      toExecute: toExecute,
      onEnter: () => _executableContext.push(executableContext),
      onExit: () => _executableContext.pop(),
    );
  }

  String _getClassName(ClassElement? element) {
    if (element == null) {
      return '';
    }
    String typeParameterSuffix = getTypeParameterSuffix(
        element.typeParameters.map((tpe) => tpe.name).toList());
    final className = element.name;
    return '$className$typeParameterSuffix';
  }

  void _onTypeUsed(TypeDefiningElement element) {
    if (_visitedTypeElements.contains(element)) {
      return;
    }
    final packageName =
        getPackageNameFromLibraryIdentifier(element.library!.identifier);
    if (packageName == _packageName) {
      _executeInRootContext(
        toExecute: () {
          element.accept(this);
        },
      );
    }
  }

  void _onVisitAnyElement(Element element) {
    // set the package name to the first element's package we see
    _packageName ??= element.library?.identifier != null
        ? getPackageNameFromLibraryIdentifier(element.library!.identifier)
        : null;
  }

  @override
  void visitClassElement(ClassElement element) {
    _onVisitAnyElement(element);
    if (_visitedTypeElements.contains(element)) {
      return;
    }
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    _visitedTypeElements.add(element);
    _classDeclarations.add(ClassDeclatation.fromClassElement(
        _getClassName(_currentClassContext), element));
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
    _fieldDeclarations.add(FieldDeclaration.fromPropertyInducingElement(
        _getClassName(_currentClassContext), element));
    super.visitFieldElement(element);
    if (element.type.element != null) {
      _onTypeUsed(element.type.element as TypeDefiningElement);
    }
  }

  @override
  visitTopLevelVariableElement(TopLevelVariableElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    _fieldDeclarations.add(FieldDeclaration.fromPropertyInducingElement(
        _getClassName(_currentClassContext), element));
    super.visitTopLevelVariableElement(element);
    if (element.type.element != null) {
      _onTypeUsed(element.type.element as TypeDefiningElement);
    }
  }

  @override
  void visitParameterElement(ParameterElement element) {
    _onVisitAnyElement(element);
    super.visitParameterElement(element);
    // this includes method, function and constructor calls
    if (element.type.element != null) {
      _onTypeUsed(element.type.element as TypeDefiningElement);
    }
  }

  @override
  void visitMethodElement(MethodElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    _executableDeclarations.add(ExecutableDeclaration.fromExecutableElement(
      _getClassName(_currentClassContext),
      element,
    ));
    _executeInExecutableContext(
      toExecute: () {
        super.visitMethodElement(element);
      },
      executableContext: element,
    );
    if (element.returnType.element != null) {
      _onTypeUsed(element.returnType.element as TypeDefiningElement);
    }
  }

  @override
  visitFunctionElement(FunctionElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    _executableDeclarations.add(ExecutableDeclaration.fromExecutableElement(
      _getClassName(_currentClassContext),
      element,
    ));
    _executeInExecutableContext(
      toExecute: () {
        super.visitFunctionElement(element);
      },
      executableContext: element,
    );
    if (element.returnType.element != null) {
      _onTypeUsed(element.returnType.element as TypeDefiningElement);
    }
  }

  @override
  visitConstructorElement(ConstructorElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
      return;
    }

    _executableDeclarations.add(ExecutableDeclaration.fromExecutableElement(
      _getClassName(_currentClassContext),
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
      _onTypeUsed(element.aliasedType.element as TypeDefiningElement);
    }
  }

  @override
  visitTypeParameterElement(TypeParameterElement element) {
    _onVisitAnyElement(element);
    super.visitTypeParameterElement(element);
    if (element.bound?.element != null) {
      _onTypeUsed(element.bound!.element as TypeDefiningElement);
    }
  }

  @override
  void visitExtensionElement(ExtensionElement element) {
    _onVisitAnyElement(element);
    super.visitExtensionElement(element);
    if (element.extendedType.element != null) {
      _onTypeUsed(element.extendedType.element as TypeDefiningElement);
    }
  }
}
