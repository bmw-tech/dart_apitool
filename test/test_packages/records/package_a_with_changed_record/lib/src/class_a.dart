class ClassA {
  final String someValue;
  final int? someOtherValue;
  const ClassA(this.someValue, this.someOtherValue);

  ({String someValue, int someOtherValue}) get asRecord => (someValue: someValue, someOtherValue: someOtherValue ?? 0);
}
