class ClassA {
  void someMethod(String stringParam) {
    print(stringParam);
  }

  void methodUsingLocalType(SomeSubType localTypeParam) {
    print(param);
  }

  SomeSubType returnSomeInstance() {
    return SomeSubType();
  }
}

class SomeSuperType {}

class SomeSubType extends SomeSuperType {}
