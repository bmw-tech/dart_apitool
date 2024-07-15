abstract class ClassA {
  String instanceMethod() {
    return 'instanceMethod';
  }
}

String useClassASoThatItBecomesRequired(ClassA classA) {
  return classA.instanceMethod();
}
