import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:stack/stack.dart';

import '../utils/string_utils.dart';
import 'model/internal_class_declaration.dart';
import 'model/internal_executable_declaration.dart';
import 'model/internal_field_declaration.dart';

/// collector to get all the API relevant information out of an AST
///
/// It tracks the found elements in its public properties:
/// - [classDeclarations]
/// - [executableDeclarations]
/// - [fieldDeclarations]
class APIRelevantElementsCollector extends RecursiveElementVisitor<void> {
  APIRelevantElementsCollector({this.isOnlyPublic = true});

  final List<int> _visitedTypeElementIds = [];

  String? _packageName;

  var _classContext = Stack<ClassElement>();
  var _executableContext = Stack<ExecutableElement>();

  /*ClassElement? get _currentClassContext {
    if (_classContext.isNotEmpty) {
      return _classContext.top();
    }
    return null;
  }*/

  // ignore: unused_element
  ExecutableElement? get _currentExecutableContext {
    if (_executableContext.isNotEmpty) {
      return _executableContext.top();
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

  // String _getClassName(ClassElement? element) {
  //   if (element == null) {
  //     return '';
  //   }
  //   String typeParameterSuffix = getTypeParameterSuffix(
  //       element.typeParameters.map((tpe) => tpe.name).toList());
  //   final className = element.name;
  //   return '$className$typeParameterSuffix';
  // }

  void _onTypeUsed(DartType type) {
    if (type is InterfaceType) {
      _onInterfaceTypeUsed(type);
    }
  }

  void _onInterfaceTypeUsed(InterfaceType type) {
    final directElement = type.element;
    if (_visitedTypeElementIds.contains(type.element.id)) {
      return;
    }
    final packageName =
        getPackageNameFromLibraryIdentifier(directElement.library.identifier);
    if (packageName == _packageName) {
      _executeInRootContext(
        toExecute: () {
          directElement.accept(this);
        },
      );
    }
    for (final ta in type.typeArguments) {
      if (ta is InterfaceType) {
        _onTypeUsed(ta);
      }
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
    if (_visitedTypeElementIds.contains(element.id)) {
      return;
    }
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    _visitedTypeElementIds.add(element.id);
    _classDeclarations.add(InternalClassDeclaration.fromClassElement(element));
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
    _fieldDeclarations
        .add(InternalFieldDeclaration.fromPropertyInducingElement(element));
    super.visitFieldElement(element);
    if (element.type.element != null) {
      _onTypeUsed(element.type);
    }
  }

  @override
  visitTopLevelVariableElement(TopLevelVariableElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
      return;
    }
    _fieldDeclarations
        .add(InternalFieldDeclaration.fromPropertyInducingElement(element));
    super.visitTopLevelVariableElement(element);
    if (element.type.element != null) {
      _onTypeUsed(element.type);
    }
  }

  @override
  void visitParameterElement(ParameterElement element) {
    _onVisitAnyElement(element);
    super.visitParameterElement(element);
    // this includes method, function and constructor calls
    if (element.type.element != null) {
      _onTypeUsed(element.type);
    }
  }

  @override
  void visitMethodElement(MethodElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
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
      _onTypeUsed(element.returnType);
    }
  }

  @override
  visitFunctionElement(FunctionElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
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
      _onTypeUsed(element.returnType);
    }
  }

  @override
  visitConstructorElement(ConstructorElement element) {
    _onVisitAnyElement(element);
    if (isOnlyPublic && !element.isPublic) {
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
      _onTypeUsed(element.aliasedType);
    }
  }

  @override
  visitTypeParameterElement(TypeParameterElement element) {
    _onVisitAnyElement(element);
    super.visitTypeParameterElement(element);
    if (element.bound?.element != null) {
      _onTypeUsed(element.bound!);
    }
  }

  @override
  void visitExtensionElement(ExtensionElement element) {
    _onVisitAnyElement(element);
    super.visitExtensionElement(element);
    if (element.extendedType.element != null) {
      _onTypeUsed(element.extendedType);
    }
  }
}
