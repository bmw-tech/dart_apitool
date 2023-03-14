class ClassA {
  void someMethod(String stringParam) {
    print(stringParam);
  }

  void methodUsingLocalType(SomeSubType localTypeParam) {
    print(param);
  }
}

class SomeSuperType {}

class SomeSubType extends SomeSuperType {}
