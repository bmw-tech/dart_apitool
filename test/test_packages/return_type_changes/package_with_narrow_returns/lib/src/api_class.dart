/// API class with narrow return types
class ApiClass {
  /// Returns non-nullable string (narrow type)
  String nullableString() => "test";

  /// Returns specific integer type (narrow type)
  int generalNumber() => 42;

  /// Returns list of specific integers (narrow type)
  List<int> numberList() => [1, 2, 3];

  /// Returns set of specific integers (narrow type)
  Set<int> numberSet() => {1, 2, 3};

  /// Returns iterable of specific integers (narrow type)
  Iterable<int> numberIterable() => [1, 2, 3];

  /// Returns list of specific integers (narrow base type and type parameter)
  List<int> wideIterableToNarrowList() => [1, 2, 3];

  /// Returns subtype (narrow type)
  SomeSubType getSuperType() => SomeSubType();

  /// Getter returning non-nullable string (narrow type)
  String get nullableStringGetter => "test";

  /// Getter returning specific integer (narrow type)
  int get generalNumberGetter => 42;
}

/// Base class for type hierarchy testing
class SomeSuperType {
  String get name => "super";
}

/// Subclass for type hierarchy testing
class SomeSubType extends SomeSuperType {
  @override
  String get name => "sub";
}
