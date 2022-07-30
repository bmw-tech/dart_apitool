import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class APIRelevantElementsCollector extends RecursiveElementVisitor<void> {
  final List<String> _things = [];

  List<String> get things => _things;

  ClassElement? _classContext;
  MethodElement? _methodContext;

  String _format(String type, String content) {
    int paddingWidth = 0;
    if (_classContext != null) {
      paddingWidth += 4;
    }
    if (_methodContext != null) {
      paddingWidth += 4;
    }
    final padding = ''.padLeft(paddingWidth);
    return '${padding}${type.padRight(15)}: ${content}';
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
    things.add(_format('Method',
        '${element.displayName} (${element.returnType.getDisplayString(withNullability: true)})'));
    final prev = _methodContext;
    _methodContext = element;
    super.visitMethodElement(element);
    _methodContext = prev;
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
