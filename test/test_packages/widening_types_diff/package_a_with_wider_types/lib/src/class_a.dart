class ClassA {
  void someMethod(String? stringParam) {
    print(stringParam);
  }

  void methodUsingLocalType(SomeSuperType localTypeParam) {
    print(param);
  }

  SomeSuperType returnSomeInstance() {
    return SomeSubType();
  }
}

class SomeSuperType {}

class SomeSubType extends SomeSuperType {}
