class ClassA {
  dynamic field;

  dynamic _backingFieldForProperty;

  dynamic get property => _backingFieldForProperty;

  set property(dynamic val) => _backingFieldForProperty = val;

  void someMethod(dynamic parameter) {
    print('$parameter');
  }

  dynamic function() {
    return '';
  }
}
