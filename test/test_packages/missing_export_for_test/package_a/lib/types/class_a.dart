import 'package:meta/meta.dart';

import 'class_b.dart';

@experimental
class ClassA {
  ClassA();

  @visibleForTesting
  ClassB createClassB() => ClassB('someValue');
}
