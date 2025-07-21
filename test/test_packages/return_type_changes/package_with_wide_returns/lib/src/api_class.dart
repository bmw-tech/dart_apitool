/// API class with wide return types
class ApiClass {
  /// Returns nullable string (wide type)
  String? nullableString() => "test";

  /// Returns general number type (wide type)
  num generalNumber() => 42;

  /// Returns list of general numbers (wide type)
  List<num> numberList() => [1, 2, 3];

  /// Returns set of general numbers (wide type)
  Set<num> numberSet() => {1, 2, 3};

  /// Returns iterable of general numbers (wide type)
  Iterable<num> numberIterable() => [1, 2, 3];

  /// Returns iterable of general numbers (wide base type and type parameter)
  Iterable<num> wideIterableToNarrowList() => [1, 2, 3];

  /// Returns supertype (wide type)
  SomeSuperType getSuperType() => SomeSubType();

  SomeSuperType? getSuperType2() => SomeSuperType();

  /// Getter returning nullable string (wide type)
  String? get nullableStringGetter => "test";

  /// Getter returning general number (wide type)
  num get generalNumberGetter => 42;

  Map<String, dynamic> returnAMap1() {
    return {'key': 'value'};
  }

  Map<String, String?> returnAMap2() {
    return {'key': 'value'};
  }

  List<dynamic> returnAList1() {
    return ['value'];
  }

  List<String?> returnAList2() {
    return ['value'];
  }

  dynamic returnSomething() {
    return 1;
  }
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
