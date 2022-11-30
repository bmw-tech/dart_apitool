import 'package:meta/meta.dart';

@experimental
class ClassA {
  final String name;

  ClassA({required this.name});

  String getName() {
    return name;
  }
}
