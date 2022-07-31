import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:equatable/equatable.dart';
import 'package:stack/stack.dart';

/// helper function to get the type parameter list from a [TypeParameterizedElement]
///
/// the parameter [withNullability] gets passed on to [TypeParameterElement.getDisplayString]
List<String> _getTypeParameterList(
  TypeParameterizedElement element, {
  bool withNullability = true,
}) {
  if (element.typeParameters.isNotEmpty) {
    return element.typeParameters
        .map((e) => e.getDisplayString(withNullability: withNullability))
        .toList(growable: false);
  }
  return [];
}

/// Represents a found class declaration
class ClassDeclatation extends Equatable {
  /// the signature of this class condensed to one String
  /// contains Type arguments as well as base classes or implemented interfaces
  final String signature;

  /// class name of the parent class or [null] if there is no parent class
  final String? parentClassName;

  const ClassDeclatation._(this.signature, this.parentClassName);

  /// creates a new ClassDeclaration from an given ClassElement
  ///
  /// [parentClassName] gets passed on to the ClassDeclaration
  ClassDeclatation.fromClassElement(
      String? parentClassName, ClassElement classElement)
      : this._(_computeSignature(classElement), parentClassName);

  static String _computeSignature(ClassElement classElement) {
    String superTypeSuffix = '';
    if (classElement.allSupertypes.isNotEmpty) {
      superTypeSuffix =
          ' : ${classElement.allSupertypes.map((e) => e.getDisplayString(withNullability: true)).join(', ')}';
    }
    final className = classElement.getDisplayString(withNullability: true);
    return '$className$superTypeSuffix';
  }

  @override
  List<Object?> get props => [
        parentClassName,
        signature,
      ];
}

/// represents a found FieldDeclaration
class FieldDeclaration extends Equatable {
  /// the signature of this field declaration.
  ///
  /// Contains the type (including type parameters and nullability) as well as the name of this field
  final String signature;

  /// class name of the parent class or [null] if there is no parent class
  final String? parentClassName;

  const FieldDeclaration._(this.signature, this.parentClassName);

  /// creates a [FieldDeclaration] from an [PropertyInducingElement].
  ///
  /// Typically [PropertyInducingElement] are properties, fields and top level variables
  FieldDeclaration.fromPropertyInducingElement(
      String? parentClassName, PropertyInducingElement fieldElement)
      : this._(_computeSignature(fieldElement), parentClassName);

  /// helper to compute the signature of a field
  static String _computeSignature(PropertyInducingElement fieldElement) {
    final fieldTypeName =
        fieldElement.type.getDisplayString(withNullability: true);
    return '$fieldTypeName ${fieldElement.name}';
  }

  @override
  List<Object?> get props => [
        parentClassName,
        signature,
      ];
}

/// Represents the type of executable found
enum ExecutableType {
  /// method declaration
  method,
  // constructor declaration
  constructor,
}

/// Represents an executable declaration
class ExecutableDeclaration extends Equatable {
  /// signature of the executable declaration.
  ///
  /// Contains the return type, name of the executable as well as all its parameters
  final String signature;

  /// parent class name or [null] if there is none
  final String? parentClassName;

  /// type of executable (e.g. method or constructor)
  final ExecutableType type;

  const ExecutableDeclaration._(
      this.parentClassName, this.signature, this.type);

  /// creates a new ExecutableDeclaration from the given [executableElement]
  ///
  /// [parentClassName] gets directly passed into [ExecutableDeclaration]
  ExecutableDeclaration.fromExecutableElement(
      String? parentClassName, ExecutableElement executableElement)
      : this._(parentClassName, _computeSignature(executableElement),
            _computeExecutableType(executableElement));

  /// retrieves the type of executable from the given [executableElement]
  static ExecutableType _computeExecutableType(
      ExecutableElement executableElement) {
    if (executableElement is ConstructorElement) {
      return ExecutableType.constructor;
    }
    return ExecutableType.method;
  }

  /// computes the executable signature.
  ///
  /// The signature contains all public facing aspects of the executable like return value, name and parameters
  static String _computeSignature(ExecutableElement executableElement) {
    final returnType =
        executableElement.returnType.getDisplayString(withNullability: true);
    final methodName = executableElement.name;
    List<String> parameters = [];
    List<String> namedParameters = [];
    for (final parameterElement in executableElement.parameters) {
      final paramType =
          parameterElement.type.getDisplayString(withNullability: true);
      final paramName = parameterElement.name;
      if (!parameterElement.isNamed) {
        parameters.add('$paramType $paramName');
      } else {
        String requiredPrefix = '';
        if (parameterElement.isRequired) {
          requiredPrefix = 'required ';
          namedParameters.add('$requiredPrefix$paramType $paramName');
        }
      }
    }
    if (namedParameters.isNotEmpty) {
      parameters.add('{${namedParameters.join(', ')}}');
    }
    String typeParameterSuffix = '';
    final typeParameterList = _getTypeParameterList(executableElement);
    if (typeParameterList.isNotEmpty) {
      typeParameterSuffix = '<${typeParameterList.join(', ')}>';
    }
    return '$returnType $methodName$typeParameterSuffix(${parameters.join(', ')})';
  }

  @override
  List<Object?> get props => [
        parentClassName,
        signature,
      ];
}

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
    String typeParameterSuffix = '';
    final typeParameterList = _getTypeParameterList(element);
    if (typeParameterList.isNotEmpty) {
      typeParameterSuffix = '<${typeParameterList.join(', ')}>';
    }
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
