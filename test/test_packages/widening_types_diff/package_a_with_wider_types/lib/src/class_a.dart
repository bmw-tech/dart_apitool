class ClassA {
  void someMethod(String? stringParam) {
    print(stringParam);
  }

  void methodUsingLocalType(SomeSuperType localTypeParam) {
    print(param);
  }
}

class SomeSuperType {}

class SomeSubType extends SomeSuperType {}
