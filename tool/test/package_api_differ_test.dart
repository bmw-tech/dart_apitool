import 'dart:math';

import 'package:dart_apitool/api_tool.dart';
import 'package:dart_apitool/src/package_api_differ.dart';
import 'package:test/test.dart';

part 'package_api_differ_test_data.dart';

void main() {
  group('Sanity checks', () {
    test('Same package doesn\'t yield api changes', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageClassAApi,
        newApi: packageClassAApi,
      );
      expect(diffResult.apiChanges.length, 0);
    });
  });
  group('Simple Diff', () {
    test('new class is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageClassAApi,
        newApi: packageClassAClassBApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final newClassApiChange = diffResult.apiChanges.first;
      expect(newClassApiChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(newClassApiChange.type, ApiChangeType.add);
      expect(newClassApiChange.changeDescription, contains('ClassB'));
      expect(newClassApiChange.context, isNull);
    });
    test('removed class is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageClassAClassBApi,
        newApi: packageClassAApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final removedClassApiChange = diffResult.apiChanges.first;
      expect(
          removedClassApiChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(removedClassApiChange.type, ApiChangeType.remove);
      expect(removedClassApiChange.changeDescription, contains('ClassB'));
      expect(removedClassApiChange.context, isNull);
    });
    test('new root level executable is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageExecutable1Executable2Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final newExecutableApiChange = diffResult.apiChanges.first;
      expect(newExecutableApiChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(newExecutableApiChange.type, ApiChangeType.add);
      expect(
          newExecutableApiChange.changeDescription, contains('doSomething2'));
      expect(newExecutableApiChange.context, isNull);
    });
    test('removed root level executable is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Executable2Api,
        newApi: packageExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final removedExecutableApiChange = diffResult.apiChanges.first;
      expect(removedExecutableApiChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(removedExecutableApiChange.type, ApiChangeType.remove);
      expect(removedExecutableApiChange.changeDescription,
          contains('doSomething2'));
      expect(removedExecutableApiChange.context, isNull);
    });
    test('new root level field is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageFieldA,
        newApi: packageFieldAFieldB,
      );
      expect(diffResult.apiChanges.length, 1);
      final newFieldApiChange = diffResult.apiChanges.first;
      expect(newFieldApiChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(newFieldApiChange.type, ApiChangeType.add);
      expect(newFieldApiChange.changeDescription, contains('fieldB'));
      expect(newFieldApiChange.context, isNull);
    });
    test('removed root level field is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageFieldAFieldB,
        newApi: packageFieldA,
      );
      expect(diffResult.apiChanges.length, 1);
      final removedFieldApiChange = diffResult.apiChanges.first;
      expect(
          removedFieldApiChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(removedFieldApiChange.type, ApiChangeType.remove);
      expect(removedFieldApiChange.changeDescription, contains('fieldB'));
      expect(removedFieldApiChange.context, isNull);
    });
  });
  group('Deprecated Flag handling', () {
    final packageDeprecatedClassAApi = packageClassAApi.copyWith(
      classDeclarations: packageClassAApi.classDeclarations
          .map((cd) => cd.copyWith(isDeprecated: true))
          .toList(),
    );
    test('Class deprecated flag added is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageClassAApi,
        newApi: packageDeprecatedClassAApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(
          deprecatedAddedChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.context, isNull);
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('ClassA'));
      expect(deprecatedAddedChange.changeDescription, contains('Deprecated'));
    });
    test('Class deprecated flag removed is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageDeprecatedClassAApi,
        newApi: packageClassAApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(
          deprecatedAddedChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.context, isNull);
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('ClassA'));
      expect(deprecatedAddedChange.changeDescription, contains('Deprecated'));
    });
  });
}
