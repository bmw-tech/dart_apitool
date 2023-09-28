import 'package:meta/meta.dart';
import 'package:package_b/package_b.dart';
import 'package:package_a/types/mixin_a.dart';

@experimental
class ClassA with MixinA {
  final ClassB classB;

  ClassA({required this.classB});

  String getName() {
    return classB.getName();
  }
}
