abstract class ClassA {
  String instanceMethod() {
    return 'instanceMethod${thisIsANewStaticMethod()}';
  }

  static String thisIsANewStaticMethod() {
    return 'staticMethod';
  }
}

String useClassASoThatItBecomesRequired(ClassA classA) {
  return classA.instanceMethod();
}
