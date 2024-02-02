class ClassA {
  Object? field;

  Object? _backingFieldForProperty;

  Object? get property => _backingFieldForProperty;

  set property(Object? val) => _backingFieldForProperty = val;

  void someMethod(Object? parameter) {
    print('$parameter');
  }

  Object? function() {
    return '';
  }
}
