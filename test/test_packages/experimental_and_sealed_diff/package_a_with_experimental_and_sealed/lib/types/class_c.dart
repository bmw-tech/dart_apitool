import 'package:meta/meta.dart';

class ClassCExperimentalMethod {
  final String name;

  ClassCExperimentalMethod({required this.name});

  @experimental
  String getName() {
    return name;
  }
}
