import 'package:dart_apitool/api_tool.dart';
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
      expect(newClassApiChange.type, ApiChangeType.addCompatible);
      expect(newClassApiChange.changeDescription, contains('ClassB'));
      expect(newClassApiChange.contextTrace, isEmpty);
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
      expect(removedClassApiChange.contextTrace, isEmpty);
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
      expect(newExecutableApiChange.type, ApiChangeType.addCompatible);
      expect(
          newExecutableApiChange.changeDescription, contains('doSomething2'));
      expect(newExecutableApiChange.contextTrace, isEmpty);
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
      expect(removedExecutableApiChange.contextTrace, isEmpty);
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
      expect(newFieldApiChange.type, ApiChangeType.addCompatible);
      expect(newFieldApiChange.changeDescription, contains('fieldB'));
      expect(newFieldApiChange.contextTrace, isEmpty);
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
      expect(removedFieldApiChange.contextTrace, isEmpty);
    });
  });
  group('Deprecated Flag handling', () {
    test('Class deprecated flag added is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageClassAApi,
        newApi: packageClassADeprecatedApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(
          deprecatedAddedChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('Deprecated'));
    });
    test('Class deprecated flag removed is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageClassADeprecatedApi,
        newApi: packageClassAApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(
          deprecatedAddedChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('Deprecated'));
    });

    final packageDeprecatedExecutable1Api = packageExecutable1Api.copyWith(
      executableDeclarations: packageExecutable1Api.executableDeclarations
          .map((ed) => ed.copyWith(isDeprecated: true))
          .toList(),
    );
    test('Executable deprecated flag added is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageDeprecatedExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(deprecatedAddedChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first,
          isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('Deprecated'));
    });
    test('Executable deprecated flag removed is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageDeprecatedExecutable1Api,
        newApi: packageExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(deprecatedAddedChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first,
          isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('Deprecated'));
    });

    final packageDeprecatedFieldAApi = packageFieldA.copyWith(
      fieldDeclarations: packageFieldA.fieldDeclarations
          .map((ed) => ed.copyWith(isDeprecated: true))
          .toList(),
    );
    test('Field deprecated flag added is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageFieldA,
        newApi: packageDeprecatedFieldAApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(
          deprecatedAddedChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first, isA<FieldDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('Deprecated'));
    });
    test('Field deprecated flag removed is detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageDeprecatedFieldAApi,
        newApi: packageFieldA,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(
          deprecatedAddedChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first, isA<FieldDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('Deprecated'));
    });
  });

  group('Type parameter handling', () {
    test('Class type parameter adding detected', () {
      final differ = PackageApiDiffer(
        options: PackageApiDifferOptions(
          ignoreTypeParameterNameChanges: false,
        ),
      );
      final diffResult = differ.diff(
        oldApi: packageClassAApi,
        newApi: packageClassAWithTypeParameterTApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeParameterAddedChange = diffResult.apiChanges.first;
      expect(typeParameterAddedChange.affectedDeclaration,
          isA<ClassDeclaration>());
      expect(
          typeParameterAddedChange.contextTrace.first, isA<ClassDeclaration>());
      expect(typeParameterAddedChange.type, ApiChangeType.addBreaking);
      expect(typeParameterAddedChange.changeDescription,
          contains('Type Parameter "T"'));
    });
    test('Class type parameter removal detected', () {
      final differ = PackageApiDiffer(
        options: PackageApiDifferOptions(
          ignoreTypeParameterNameChanges: false,
        ),
      );
      final diffResult = differ.diff(
        oldApi: packageClassAWithTypeParameterTApi,
        newApi: packageClassAApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeParameterRemovedChange = diffResult.apiChanges.first;
      expect(typeParameterRemovedChange.affectedDeclaration,
          isA<ClassDeclaration>());
      expect(typeParameterRemovedChange.contextTrace.first,
          isA<ClassDeclaration>());
      expect(typeParameterRemovedChange.type, ApiChangeType.remove);
      expect(typeParameterRemovedChange.changeDescription,
          contains('Type Parameter "T"'));
    });

    test('Executable type parameter adding detected', () {
      final differ = PackageApiDiffer(
        options: PackageApiDifferOptions(
          ignoreTypeParameterNameChanges: false,
        ),
      );
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageExecutable1WithTypeParameterTApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeParameterAddedChange = diffResult.apiChanges.first;
      expect(typeParameterAddedChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(typeParameterAddedChange.contextTrace.first,
          isA<ExecutableDeclaration>());
      expect(typeParameterAddedChange.type, ApiChangeType.addBreaking);
      expect(typeParameterAddedChange.changeDescription,
          contains('Type Parameter "T"'));
    });
    test('Executable type parameter removal detected', () {
      final differ = PackageApiDiffer(
        options: PackageApiDifferOptions(
          ignoreTypeParameterNameChanges: false,
        ),
      );
      final diffResult = differ.diff(
        oldApi: packageExecutable1WithTypeParameterTApi,
        newApi: packageExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeParameterRemovedChange = diffResult.apiChanges.first;
      expect(typeParameterRemovedChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(typeParameterRemovedChange.contextTrace.first,
          isA<ExecutableDeclaration>());
      expect(typeParameterRemovedChange.type, ApiChangeType.remove);
      expect(typeParameterRemovedChange.changeDescription,
          contains('Type Parameter "T"'));
    });
    test('Class type parameter name change detected', () {
      final differ = PackageApiDiffer(
        options: PackageApiDifferOptions(
          ignoreTypeParameterNameChanges: false,
        ),
      );
      final diffResult = differ.diff(
        oldApi: packageClassAWithTypeParameterTApi,
        newApi: packageClassAWithTypeParameterRApi,
      );
      expect(diffResult.apiChanges.length, 2);
      final typeParmeterAddedChange = diffResult.apiChanges
          .where((change) => change.type == ApiChangeType.addBreaking)
          .single;
      final typeParmeterRemovedChange = diffResult.apiChanges
          .where((change) => change.type == ApiChangeType.remove)
          .single;
      expect(
          typeParmeterAddedChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(
          typeParmeterAddedChange.contextTrace.first, isA<ClassDeclaration>());
      expect(typeParmeterAddedChange.type, ApiChangeType.addBreaking);
      expect(typeParmeterAddedChange.changeDescription,
          contains('Type Parameter "R"'));
      expect(typeParmeterRemovedChange.affectedDeclaration,
          isA<ClassDeclaration>());
      expect(typeParmeterRemovedChange.contextTrace.first,
          isA<ClassDeclaration>());
      expect(typeParmeterRemovedChange.type, ApiChangeType.remove);
      expect(typeParmeterRemovedChange.changeDescription,
          contains('Type Parameter "T"'));
    });
    test('Executable type parameter name change detected', () {
      final differ = PackageApiDiffer(
        options: PackageApiDifferOptions(
          ignoreTypeParameterNameChanges: false,
        ),
      );
      final diffResult = differ.diff(
        oldApi: packageExecutable1WithTypeParameterTApi,
        newApi: packageExecutable1WithTypeParameterRApi,
      );
      expect(diffResult.apiChanges.length, 2);
      final typeParmeterAddedChange = diffResult.apiChanges
          .where((change) => change.type == ApiChangeType.addBreaking)
          .single;
      final typeParmeterRemovedChange = diffResult.apiChanges
          .where((change) => change.type == ApiChangeType.remove)
          .single;
      expect(typeParmeterAddedChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(typeParmeterAddedChange.contextTrace.first,
          isA<ExecutableDeclaration>());
      expect(typeParmeterAddedChange.type, ApiChangeType.addBreaking);
      expect(typeParmeterAddedChange.changeDescription,
          contains('Type Parameter "R"'));
      expect(typeParmeterRemovedChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(typeParmeterRemovedChange.contextTrace.first,
          isA<ExecutableDeclaration>());
      expect(typeParmeterRemovedChange.type, ApiChangeType.remove);
      expect(typeParmeterRemovedChange.changeDescription,
          contains('Type Parameter "T"'));
    });
    test(
        'Class type parameter adding detected (without type parameter name check)',
        () {
      final differ = PackageApiDiffer(
        options: PackageApiDifferOptions(
          ignoreTypeParameterNameChanges: true,
        ),
      );
      final diffResult = differ.diff(
        oldApi: packageClassAApi,
        newApi: packageClassAWithTypeParameterTApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(
          deprecatedAddedChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.addBreaking);
      expect(deprecatedAddedChange.changeDescription, contains('"T"'));
    });
    test(
        'Class type parameter removal detected (without type parameter name check)',
        () {
      final differ = PackageApiDiffer(
        options: PackageApiDifferOptions(
          ignoreTypeParameterNameChanges: true,
        ),
      );
      final diffResult = differ.diff(
        oldApi: packageClassAWithTypeParameterTApi,
        newApi: packageClassAApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(
          deprecatedAddedChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.remove);
      expect(deprecatedAddedChange.changeDescription, contains('"T"'));
    });

    test(
        'Executable type parameter adding detected (without type parameter name check)',
        () {
      final differ = PackageApiDiffer(
        options: PackageApiDifferOptions(
          ignoreTypeParameterNameChanges: true,
        ),
      );
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageExecutable1WithTypeParameterTApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(deprecatedAddedChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first,
          isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.addBreaking);
      expect(deprecatedAddedChange.changeDescription, contains('"T"'));
    });
    test(
        'Executable type parameter removal detected (without type parameter name check)',
        () {
      final differ = PackageApiDiffer(
        options: PackageApiDifferOptions(
          ignoreTypeParameterNameChanges: true,
        ),
      );
      final diffResult = differ.diff(
        oldApi: packageExecutable1WithTypeParameterTApi,
        newApi: packageExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(deprecatedAddedChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first,
          isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.remove);
      expect(deprecatedAddedChange.changeDescription, contains('"T"'));
    });
  });
  group('Type change handling', () {
    test('Field type change detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageFieldA,
        newApi: packageFieldATypeChangedApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(typeChange.changeDescription, contains('NewType'));
      expect(typeChange.contextTrace.first, isA<FieldDeclaration>());
      expect(typeChange.type, ApiChangeType.changeBreaking);
    });
    test('Return type change detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageExecutable1ReturnTypeChangedApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('NewType'));
      expect(typeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.changeBreaking);
    });
    test('Parameter type change detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageExecutable1ParameterTypeChangedApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration,
          isA<ExecutableParameterDeclaration>());
      expect(typeChange.changeDescription, contains('NewType'));
      expect(typeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.changeBreaking);
    });
  });
  group('Executable parameter changes', () {
    test('New, optional, positional parameter added', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageExecutable1OptionalPositionalParameterAddedApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('optionalPositional'));
      expect(typeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.addCompatible);
    });
    test('New, optional named parameter added', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageExecutable1OptionalNamedParameterAddedApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('optionalNamed'));
      expect(typeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.addCompatible);
    });
    test('New, required positional parameter added', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageExecutable1RequiredPositionalParameterAddedApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('requiredPositional'));
      expect(typeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.addBreaking);
    });
    test('New, required named parameter added', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageExecutable1RequiredNamedParameterAddedApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('requiredNamed'));
      expect(typeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.addBreaking);
    });
    test('optional, positional parameter removed', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1OptionalPositionalParameterAddedApi,
        newApi: packageExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('optionalPositional'));
      expect(typeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.remove);
    });
    test('optional named parameter removed', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1OptionalNamedParameterAddedApi,
        newApi: packageExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('optionalNamed'));
      expect(typeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.remove);
    });
    test('required positional parameter removed', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1RequiredPositionalParameterAddedApi,
        newApi: packageExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('requiredPositional'));
      expect(typeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.remove);
    });
    test('required named parameter removed', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1RequiredNamedParameterAddedApi,
        newApi: packageExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('requiredNamed'));
      expect(typeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.remove);
    });
  });
}
