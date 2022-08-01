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

  final _classContext = Stack<ClassElement>();
  final _executableContext = Stack<ExecutableElement>();

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

  @override
  void visitClassElement(ClassElement element) {
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
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
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    _fieldDeclarations.add(FieldDeclaration.fromPropertyInducingElement(
        _getClassName(_currentClassContext), element));
    super.visitFieldElement(element);
  }

  @override
  visitTopLevelVariableElement(TopLevelVariableElement element) {
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    _fieldDeclarations.add(FieldDeclaration.fromPropertyInducingElement(
        _getClassName(_currentClassContext), element));
    super.visitTopLevelVariableElement(element);
  }

  @override
  void visitParameterElement(ParameterElement element) {
    super.visitParameterElement(element);
  }

  @override
  void visitMethodElement(MethodElement element) {
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
  }

  @override
  visitFunctionElement(FunctionElement element) {
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
  }

  @override
  visitConstructorElement(ConstructorElement element) {
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
}
