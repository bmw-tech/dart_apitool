import 'package:meta/meta.dart';

@sealed
abstract class ClassD {
  static ClassD instance; // this is causing ClassD to be required (normally)
  void someMethod() {
    print('ClassD.someMethod()');
  }

  String newMethod() {
    return 'newMethod';
  }
}
