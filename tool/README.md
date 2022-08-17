# Dart API Tool

Create a model of the public API of a given package.
This model can be stored and later compared against a new version of the package to get the needed semantic version jump.

## Limitations
It doesn't cover all potential API changes that might lead to breaking changes.

### It does not look into implementations
Imagine a class:
```dart
class MyClass<T> {
  String doSomething(T arg) {
    final castedArg = arg as SomeBaseClass;
    return castedArg.baseClassMethod();
  }
}
```
that got changed to
```dart
class MyClass<T> {
  String doSomething(T arg) {
    final castedArg = arg as SomeOtherBaseClass;
    return castedArg.otherBaseClassMethod();
  }
}
```
Changes in the implementation are not detected.
So you have to keep your eyes 👀 open and always remember the public API! 😉
