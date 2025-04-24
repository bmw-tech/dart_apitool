class ClassA {
  final int _value = 0;

  ClassA({required int value = 0}) : _value = value;

  operator +(ClassA other) {
    return ClassA(
      value: _value + other._value,
    );
  }

  operator -(ClassA other) {
    return ClassA(
      value: _value - other._value,
    );
  }

  operator -() {
    return ClassA(
      value: -_value,
    );
  }
}
