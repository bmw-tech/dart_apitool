import 'package:dart_apitool/api_tool.dart';
import 'package:pub_semver/pub_semver.dart';
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
      expect(
          newClassApiChange.affectedDeclaration, isA<InterfaceDeclaration>());
      expect(newClassApiChange.type, ApiChangeType.addCompatibleMinor);
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
      expect(removedClassApiChange.affectedDeclaration,
          isA<InterfaceDeclaration>());
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
      expect(newExecutableApiChange.type, ApiChangeType.addCompatibleMinor);
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
      expect(newFieldApiChange.type, ApiChangeType.addCompatibleMinor);
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
      expect(deprecatedAddedChange.affectedDeclaration,
          isA<InterfaceDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first,
          isA<InterfaceDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatibleMinor);
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
      expect(deprecatedAddedChange.affectedDeclaration,
          isA<InterfaceDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first,
          isA<InterfaceDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatibleMinor);
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
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatibleMinor);
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
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatibleMinor);
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
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatibleMinor);
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
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatibleMinor);
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
          isA<InterfaceDeclaration>());
      expect(typeParameterAddedChange.contextTrace.first,
          isA<InterfaceDeclaration>());
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
          isA<InterfaceDeclaration>());
      expect(typeParameterRemovedChange.contextTrace.first,
          isA<InterfaceDeclaration>());
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
      expect(typeParmeterAddedChange.affectedDeclaration,
          isA<InterfaceDeclaration>());
      expect(typeParmeterAddedChange.contextTrace.first,
          isA<InterfaceDeclaration>());
      expect(typeParmeterAddedChange.type, ApiChangeType.addBreaking);
      expect(typeParmeterAddedChange.changeDescription,
          contains('Type Parameter "R"'));
      expect(typeParmeterRemovedChange.affectedDeclaration,
          isA<InterfaceDeclaration>());
      expect(typeParmeterRemovedChange.contextTrace.first,
          isA<InterfaceDeclaration>());
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
      expect(deprecatedAddedChange.affectedDeclaration,
          isA<InterfaceDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first,
          isA<InterfaceDeclaration>());
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
      expect(deprecatedAddedChange.affectedDeclaration,
          isA<InterfaceDeclaration>());
      expect(deprecatedAddedChange.contextTrace.first,
          isA<InterfaceDeclaration>());
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
  group('Static flag change handling', () {
    test('Field static flag change detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageFieldA,
        newApi: packageFieldAStaticChangedApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(typeChange.changeDescription, contains('Static'));
      expect(typeChange.contextTrace.first, isA<FieldDeclaration>());
      expect(typeChange.type, ApiChangeType.changeBreaking);
    });
    test('Executable static flag change detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageExecutable1StaticChangedApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('Static'));
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
      expect(typeChange.type, ApiChangeType.addCompatibleMinor);
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
      expect(typeChange.type, ApiChangeType.addCompatibleMinor);
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
  group('EntryPoint handling', () {
    test('EntryPoint change in field detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageFieldAEntryPointA,
        newApi: packageFieldAEntryPointB,
      );
      expect(diffResult.apiChanges.length, 2);
      final addChange = diffResult.apiChanges.singleWhere(
          (element) => element.type == ApiChangeType.addCompatibleMinor);
      final removeChange = diffResult.apiChanges
          .singleWhere((element) => element.type == ApiChangeType.remove);
      expect(removeChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(removeChange.changeDescription, contains('Entry point'));
      expect(removeChange.changeDescription, contains('a.dart'));
      expect(removeChange.contextTrace.first, isA<FieldDeclaration>());
      expect(removeChange.type, ApiChangeType.remove);

      expect(addChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(addChange.changeDescription, contains('entry point'));
      expect(addChange.changeDescription, contains('b.dart'));
      expect(addChange.contextTrace.first, isA<FieldDeclaration>());
      expect(addChange.type, ApiChangeType.addCompatibleMinor);
    });
    test('EntryPoint add in field detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageFieldAEntryPointA,
        newApi: packageFieldAEntryPointAB,
      );
      expect(diffResult.apiChanges.length, 1);
      final addChange = diffResult.apiChanges.single;

      expect(addChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(addChange.changeDescription, contains('entry point'));
      expect(addChange.changeDescription, contains('b.dart'));
      expect(addChange.contextTrace.first, isA<FieldDeclaration>());
      expect(addChange.type, ApiChangeType.addCompatibleMinor);
    });
    test('EntryPoint remove in field detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageFieldAEntryPointAB,
        newApi: packageFieldAEntryPointB,
      );
      expect(diffResult.apiChanges.length, 1);
      final removeChange = diffResult.apiChanges.single;
      expect(removeChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(removeChange.changeDescription, contains('Entry point'));
      expect(removeChange.changeDescription, contains('a.dart'));
      expect(removeChange.contextTrace.first, isA<FieldDeclaration>());
      expect(removeChange.type, ApiChangeType.remove);
    });
    test('EntryPoint change in executable detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1ApiEntryPointA,
        newApi: packageExecutable1ApiEntryPointB,
      );
      expect(diffResult.apiChanges.length, 2);
      final addChange = diffResult.apiChanges.singleWhere(
          (element) => element.type == ApiChangeType.addCompatibleMinor);
      final removeChange = diffResult.apiChanges
          .singleWhere((element) => element.type == ApiChangeType.remove);
      expect(removeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(removeChange.changeDescription, contains('Entry point'));
      expect(removeChange.changeDescription, contains('a.dart'));
      expect(removeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(removeChange.type, ApiChangeType.remove);

      expect(addChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(addChange.changeDescription, contains('entry point'));
      expect(addChange.changeDescription, contains('b.dart'));
      expect(addChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(addChange.type, ApiChangeType.addCompatibleMinor);
    });
    test('EntryPoint add in executable detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1ApiEntryPointA,
        newApi: packageExecutable1ApiEntryPointAB,
      );
      expect(diffResult.apiChanges.length, 1);
      final addChange = diffResult.apiChanges.single;

      expect(addChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(addChange.changeDescription, contains('entry point'));
      expect(addChange.changeDescription, contains('b.dart'));
      expect(addChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(addChange.type, ApiChangeType.addCompatibleMinor);
    });
    test('EntryPoint remove in executable detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1ApiEntryPointAB,
        newApi: packageExecutable1ApiEntryPointB,
      );
      expect(diffResult.apiChanges.length, 1);
      final removeChange = diffResult.apiChanges.single;
      expect(removeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(removeChange.changeDescription, contains('Entry point'));
      expect(removeChange.changeDescription, contains('a.dart'));
      expect(removeChange.contextTrace.first, isA<ExecutableDeclaration>());
      expect(removeChange.type, ApiChangeType.remove);
    });
    test('EntryPoint change in class detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageClassAApiEntryPointA,
        newApi: packageClassAApiEntryPointB,
      );
      expect(diffResult.apiChanges.length, 2);
      final addChange = diffResult.apiChanges.singleWhere(
          (element) => element.type == ApiChangeType.addCompatibleMinor);
      final removeChange = diffResult.apiChanges
          .singleWhere((element) => element.type == ApiChangeType.remove);
      expect(removeChange.affectedDeclaration, isA<InterfaceDeclaration>());
      expect(removeChange.changeDescription, contains('Entry point'));
      expect(removeChange.changeDescription, contains('a.dart'));
      expect(removeChange.contextTrace.first, isA<InterfaceDeclaration>());
      expect(removeChange.type, ApiChangeType.remove);

      expect(addChange.affectedDeclaration, isA<InterfaceDeclaration>());
      expect(addChange.changeDescription, contains('entry point'));
      expect(addChange.changeDescription, contains('b.dart'));
      expect(addChange.contextTrace.first, isA<InterfaceDeclaration>());
      expect(addChange.type, ApiChangeType.addCompatibleMinor);
    });
    test('EntryPoint add in class detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageClassAApiEntryPointA,
        newApi: packageClassAApiEntryPointAB,
      );
      expect(diffResult.apiChanges.length, 1);
      final addChange = diffResult.apiChanges.single;

      expect(addChange.affectedDeclaration, isA<InterfaceDeclaration>());
      expect(addChange.changeDescription, contains('entry point'));
      expect(addChange.changeDescription, contains('b.dart'));
      expect(addChange.contextTrace.first, isA<InterfaceDeclaration>());
      expect(addChange.type, ApiChangeType.addCompatibleMinor);
    });
    test('EntryPoint remove in class detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageClassAApiEntryPointAB,
        newApi: packageClassAApiEntryPointB,
      );
      expect(diffResult.apiChanges.length, 1);
      final removeChange = diffResult.apiChanges.single;

      expect(removeChange.affectedDeclaration, isA<InterfaceDeclaration>());
      expect(removeChange.changeDescription, contains('Entry point'));
      expect(removeChange.changeDescription, contains('a.dart'));
      expect(removeChange.contextTrace.first, isA<InterfaceDeclaration>());
      expect(removeChange.type, ApiChangeType.remove);
    });
  });

  group('Generic type compatibility handling', () {
    test(
        'Generic types with different parameter counts can be compatible (default parameters)',
        () {
      // This test covers the GitHub issue scenario where:
      // Parent: MyClass<T> -> MyClass<T, O> (with default parameter)
      // Subclass: extends MyClass<int> -> extends MyClass<int, String>
      // The subclass change should not be reported as a separate breaking change

      final oldApiWithSubclass = PackageApi(
        packageName: 'test_package',
        packageVersion: '1.0.0',
        packagePath: '.',
        typeHierarchy: TypeHierarchy.empty(),
        interfaceDeclarations: [
          InterfaceDeclaration(
            name: 'MyClass',
            typeParameterNames: const ['T'],
            executableDeclarations: const [],
            fieldDeclarations: const [],
            superTypeNames: const {},
            typeUsages: {},
            relativePath: 'lib/test.dart',
            isDeprecated: false,
            isExperimental: false,
            isSealed: false,
            isAbstract: false,
          ),
          InterfaceDeclaration(
            name: 'Other',
            typeParameterNames: const [],
            executableDeclarations: const [],
            fieldDeclarations: const [],
            superTypeNames: const {'MyClass<int>'},
            typeUsages: {},
            relativePath: 'lib/test.dart',
            isDeprecated: false,
            isExperimental: false,
            isSealed: false,
            isAbstract: false,
          ),
        ],
        executableDeclarations: const [],
        fieldDeclarations: const [],
        typeAliasDeclarations: const [],
        sdkType: SdkType.unknown,
        minSdkVersion: Version.none,
        packageDependencies: [],
      );

      final newApiWithSubclass = PackageApi(
        packageName: 'test_package',
        packageVersion: '1.0.0',
        packagePath: '.',
        typeHierarchy: TypeHierarchy.empty(),
        interfaceDeclarations: [
          InterfaceDeclaration(
            name: 'MyClass',
            typeParameterNames: const ['T', 'O'],
            executableDeclarations: const [],
            fieldDeclarations: const [],
            superTypeNames: const {},
            typeUsages: {},
            relativePath: 'lib/test.dart',
            isDeprecated: false,
            isExperimental: false,
            isSealed: false,
            isAbstract: false,
          ),
          InterfaceDeclaration(
            name: 'Other',
            typeParameterNames: const [],
            executableDeclarations: const [],
            fieldDeclarations: const [],
            superTypeNames: const {'MyClass<int, String>'},
            typeUsages: {},
            relativePath: 'lib/test.dart',
            isDeprecated: false,
            isExperimental: false,
            isSealed: false,
            isAbstract: false,
          ),
        ],
        executableDeclarations: const [],
        fieldDeclarations: const [],
        typeAliasDeclarations: const [],
        sdkType: SdkType.unknown,
        minSdkVersion: Version.none,
        packageDependencies: [],
      );

      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: oldApiWithSubclass,
        newApi: newApiWithSubclass,
      );

      // Should detect: 1) parent type parameter addition, 2) supertype change (not remove+add)
      expect(diffResult.apiChanges.length, 2);

      final parentTypeParameterChange = diffResult.apiChanges
          .where((change) => change.affectedDeclaration?.name == 'MyClass')
          .single;
      expect(parentTypeParameterChange.type, ApiChangeType.addBreaking);
      expect(parentTypeParameterChange.changeDescription,
          contains('Number of type parameters changed'));

      // Verify inheritance is reported as a single "change" not "remove + add"
      final inheritanceChange = diffResult.apiChanges
          .where((change) => change.affectedDeclaration?.name == 'Other')
          .single;
      expect(inheritanceChange.type, ApiChangeType.changeBreaking);
      expect(
          inheritanceChange.changeDescription,
          contains(
              'Super Type changed from "MyClass<int>" to "MyClass<int, String>"'));
    });
  });
}
