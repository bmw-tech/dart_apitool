import 'package:meta/meta.dart';

import 'class_b.dart';

@experimental
class ClassA {
  final ClassB classB;

  ClassA({required this.classB});

  String getName() {
    return classB.getName();
  }

  ClassB getClassB() => ClassB('someValue');
}
