import 'package:meta/meta.dart';
import 'package:package_c/package_c.dart';

@experimental
class ClassB {
  final ClassC classC;

  ClassB({required this.classC});

  String getName() {
    return classC.getName();
  }
}
