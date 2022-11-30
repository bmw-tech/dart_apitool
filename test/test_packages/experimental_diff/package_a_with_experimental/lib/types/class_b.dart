import 'package:meta/meta.dart';

class ClassBExperimentalField {
  @experimental
  final String name;

  ClassBExperimentalField({required this.name});

  String getName() {
    return name;
  }
}
