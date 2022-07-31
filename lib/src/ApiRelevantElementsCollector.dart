import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:equatable/equatable.dart';

List<String> _getTypeParameterList(TypeParameterizedElement element) {
  if (element.typeParameters.isNotEmpty) {
    return element.typeParameters
        .map((e) => e.getDisplayString(withNullability: true))
        .toList(growable: false);
  }
  return [];
}

class FieldDeclaration extends Equatable {
  final String signature;
  final String? parentClassName;

  FieldDeclaration(this.signature, this.parentClassName);

  FieldDeclaration.fromFieldElement(
      this.parentClassName, FieldElement fieldElement)
      : signature = _computeSignature(fieldElement);

  static String _computeSignature(FieldElement fieldElement) {
    final fieldTypeName =
        fieldElement.type.getDisplayString(withNullability: true);
    return '${fieldTypeName} ${fieldElement.name}';
  }

  @override
  List<Object?> get props => [
        parentClassName,
        signature,
      ];
}

enum ExecutableType {
  method,
  constructor,
}

class ExecutableDeclaration extends Equatable {
  final String signature;
  final String? parentClassName;
  final ExecutableType type;

  ExecutableDeclaration(this.parentClassName, this.signature, this.type);

  ExecutableDeclaration.fromExecutableElement(
      String? parentClassName, ExecutableElement executableElement)
      : this(parentClassName, _computeSignature(executableElement),
            _computeExecutableType(executableElement));

  static ExecutableType _computeExecutableType(
      ExecutableElement executableElement) {
    if (executableElement is ConstructorElement) {
      return ExecutableType.constructor;
    }
    return ExecutableType.method;
  }

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
        parameters.add('${paramType} ${paramName}');
      } else {
        String requiredPrefix = '';
        if (parameterElement.isRequired) {
          requiredPrefix = 'required ';
          namedParameters.add('${requiredPrefix}${paramType} ${paramName}');
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
    return '${returnType} ${methodName}${typeParameterSuffix}(${parameters.join(', ')})';
  }

  @override
  List<Object?> get props => [
        parentClassName,
        signature,
      ];
}

class APIRelevantElementsCollector extends RecursiveElementVisitor<void> {
  final List<String> _things = [];

  List<String> get things => _things;

  final List<ExecutableDeclaration> _executableDeclarations = [];
  List<ExecutableDeclaration> get executableDeclarations =>
      _executableDeclarations;
  final List<FieldDeclaration> _fieldDeclarations = [];
  List<FieldDeclaration> get fieldDeclarations => _fieldDeclarations;

  ClassElement? _classContext;
  ExecutableElement? _executableContext;

  String _format(String type, String content) {
    int paddingWidth = 0;
    if (_classContext != null) {
      paddingWidth += 4;
    }
    if (_executableContext != null) {
      paddingWidth += 4;
    }
    final padding = ''.padLeft(paddingWidth);
    return '${padding}${type.padRight(15)}: ${content}';
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
    return '${className}${typeParameterSuffix}';
  }

  @override
  void visitClassElement(ClassElement element) {
    things.add(_format('Class', element.displayName));
    final prev = _classContext;
    _classContext = element;
    super.visitClassElement(element);
    _classContext = prev;
  }

  @override
  void visitFieldElement(FieldElement element) {
    things.add(_format('Field',
        '${element.displayName} (${element.type.getDisplayString(withNullability: true)})'));
    _fieldDeclarations.add(FieldDeclaration.fromFieldElement(
        _getClassName(_classContext), element));
    super.visitFieldElement(element);
  }

  @override
  void visitFieldFormalParameterElement(FieldFormalParameterElement element) {
    things.add(_format('Field-FP', element.displayName));
    super.visitFieldFormalParameterElement(element);
  }

  @override
  void visitParameterElement(ParameterElement element) {
    things.add(_format('Parameter',
        '${element.displayName} (${element.type.getDisplayString(withNullability: true)})'));
    super.visitParameterElement(element);
  }

  @override
  void visitMethodElement(MethodElement element) {
    _things.add(_format('Method',
        '${element.displayName} (${element.returnType.getDisplayString(withNullability: true)})'));
    _executableDeclarations.add(ExecutableDeclaration.fromExecutableElement(
      _getClassName(_classContext),
      element,
    ));
    final prev = _executableContext;
    _executableContext = element;
    super.visitMethodElement(element);
    _executableContext = prev;
  }

  @override
  visitConstructorElement(ConstructorElement element) {
    _executableDeclarations.add(ExecutableDeclaration.fromExecutableElement(
      _getClassName(_classContext),
      element,
    ));
    final prev = _executableContext;
    _executableContext = element;
    super.visitConstructorElement(element);
    _executableContext = prev;
  }

  @override
  void visitPropertyAccessorElement(PropertyAccessorElement element) {
    things.add(_format('PropAccess', element.displayName));
    super.visitPropertyAccessorElement(element);
  }

  @override
  void visitTopLevelVariableElement(TopLevelVariableElement element) {
    things.add(_format('Top-Var', element.displayName));
    super.visitTopLevelVariableElement(element);
  }

  @override
  void visitTypeParameterElement(TypeParameterElement element) {
    things.add(_format('Type-Param', element.displayName));
    super.visitTypeParameterElement(element);
  }
}
