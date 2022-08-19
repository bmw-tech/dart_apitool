# Dart API Tool

A tool to analyze the public API of a package and create a model of it.
This model can be stored and later compared against a new version of the package to get the needed semantic version jump.

## Installation

To install activate the tool via dart pub:
```bash
dart pub global activate dart_apitool
```

## Usage

After activation the tool is usable via
```bash
dart-apitool
```

```
A set of utilities for Package APIs

Usage: dart-apitool <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  diff      Creates a diff of 2 given packages.
  extract   Extracts the API from the given package ref.

Run "dart-apitool help <command>" for more information about a command.
```

### extract

### diff

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
