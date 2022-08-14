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
      expect(deprecatedAddedChange.context, isNull);
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('doSomething1'));
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
      expect(deprecatedAddedChange.context, isNull);
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('doSomething1'));
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
      expect(deprecatedAddedChange.context, isNull);
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('fieldA'));
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
      expect(deprecatedAddedChange.context, isNull);
      expect(deprecatedAddedChange.type, ApiChangeType.changeCompatible);
      expect(deprecatedAddedChange.changeDescription, contains('fieldA'));
      expect(deprecatedAddedChange.changeDescription, contains('Deprecated'));
    });
  });

  group('Type parameter handling', () {
    final packageTypeParameterClassAApi = packageClassAApi.copyWith(
      classDeclarations: packageClassAApi.classDeclarations
          .map((cd) => cd.copyWith(typeParameterNames: ['T']))
          .toList(),
    );
    test('Class type parameter adding detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageClassAApi,
        newApi: packageTypeParameterClassAApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(
          deprecatedAddedChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.context, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.addRequired);
      expect(deprecatedAddedChange.changeDescription,
          contains('Type Parameter T'));
    });
    test('Class type parameter removal detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageTypeParameterClassAApi,
        newApi: packageClassAApi,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(
          deprecatedAddedChange.affectedDeclaration, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.context, isA<ClassDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.remove);
      expect(deprecatedAddedChange.changeDescription,
          contains('Type Parameter T'));
    });

    final packageTypeParameterExecutable1Api = packageExecutable1Api.copyWith(
      executableDeclarations: packageExecutable1Api.executableDeclarations
          .map((cd) => cd.copyWith(typeParameterNames: ['T']))
          .toList(),
    );

    test('Executable type parameter adding detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageTypeParameterExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(deprecatedAddedChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.context, isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.addRequired);
      expect(deprecatedAddedChange.changeDescription,
          contains('Type Parameter T'));
    });
    test('Executable type parameter removal detected', () {
      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageTypeParameterExecutable1Api,
        newApi: packageExecutable1Api,
      );
      expect(diffResult.apiChanges.length, 1);
      final deprecatedAddedChange = diffResult.apiChanges.first;
      expect(deprecatedAddedChange.affectedDeclaration,
          isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.context, isA<ExecutableDeclaration>());
      expect(deprecatedAddedChange.type, ApiChangeType.remove);
      expect(deprecatedAddedChange.changeDescription,
          contains('Type Parameter T'));
    });
  });
  group('Type change handling', () {
    test('Field type change detected', () {
      final packageApiTypeFieldAChanged = packageFieldA.copyWith(
        fieldDeclarations: packageFieldA.fieldDeclarations
            .map((fd) => fd.copyWith(typeName: 'NewType'))
            .toList(),
      );

      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageFieldA,
        newApi: packageApiTypeFieldAChanged,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<FieldDeclaration>());
      expect(typeChange.changeDescription, contains('NewType'));
      expect(typeChange.context, isNull);
      expect(typeChange.type, ApiChangeType.change);
    });
    test('Return type change detected', () {
      final packageApiReturnTypeExecutable1Changed =
          packageExecutable1Api.copyWith(
        executableDeclarations: packageExecutable1Api.executableDeclarations
            .map((exd) => exd.copyWith(returnTypeName: 'NewType'))
            .toList(),
      );

      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageApiReturnTypeExecutable1Changed,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(typeChange.affectedDeclaration, isA<ExecutableDeclaration>());
      expect(typeChange.changeDescription, contains('NewType'));
      expect(typeChange.context, isNull);
      expect(typeChange.type, ApiChangeType.change);
    });
    test('Parameter type change detected', () {
      bool parameterChanged = false;
      final packageApiReturnTypeExecutable1Changed =
          packageExecutable1Api.copyWith(
        executableDeclarations: packageExecutable1Api.executableDeclarations
            .map(
              (exd) => exd.copyWith(
                parameters: exd.parameters.map(
                  (param) {
                    if (parameterChanged) {
                      return param;
                    }
                    parameterChanged = true;
                    return param.copyWith(
                      typeName: 'NewType',
                    );
                  },
                ).toList(),
              ),
            )
            .toList(),
      );

      final differ = PackageApiDiffer();
      final diffResult = differ.diff(
        oldApi: packageExecutable1Api,
        newApi: packageApiReturnTypeExecutable1Changed,
      );
      expect(diffResult.apiChanges.length, 1);
      final typeChange = diffResult.apiChanges.first;
      expect(
          typeChange.affectedDeclaration, isA<ExecutablParameterDeclaration>());
      expect(typeChange.changeDescription, contains('NewType'));
      expect(typeChange.context, isA<ExecutableDeclaration>());
      expect(typeChange.type, ApiChangeType.change);
    });
  });
}
