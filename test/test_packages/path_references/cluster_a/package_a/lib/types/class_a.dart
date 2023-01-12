import 'package:meta/meta.dart';
import 'package:package_b/package_b.dart';

@experimental
class ClassA {
  final ClassB classB;

  ClassA({required this.classB});

  String getName() {
    return classB.getName();
  }
}
