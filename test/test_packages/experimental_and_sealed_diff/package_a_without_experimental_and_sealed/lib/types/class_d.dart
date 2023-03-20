abstract class ClassD {
  static ClassD instance; // this is causing ClassD to be required
  void someMethod() {
    print('ClassD.someMethod()');
  }
}
