abstract class ClassA {
  String instanceMethod() {
    return 'instanceMethod${thisIsANewStaticMethod()}';
  }

  static String thisIsANewStaticMethod() {
    return 'staticMethod';
  }

  static int thisIsANewStaticField = 5;
  const int thisIsANewConst = 42;
}

String useClassASoThatItBecomesRequired(ClassA classA) {
  return classA.instanceMethod();
}
