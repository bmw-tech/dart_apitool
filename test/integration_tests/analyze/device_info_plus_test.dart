import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('device_info_plus_platform_interface gets analyzed correctly', () {
    late PackageApi packageApi;
    final packageName = 'device_info_plus_platform_interface';
    final packageVersion = '2.4.0';
    final retriever = PackageApiRetriever(packageName, packageVersion);

    setUpAll(() async {
      packageApi = await retriever.retrieve();
    });

    test('Package name is correct', () {
      expect(packageApi.packageName, 'device_info_plus_platform_interface');
    });
    test('Version is correct', () {
      expect(packageApi.packageVersion, '2.4.0');
    });
    void testField(
      ClassDeclaration Function() getHostClass,
      String fieldName, {
      required String expectedTypeName,
      required bool expectedIsDeprecatedFlag,
    }) {
      test('Field $fieldName is analyzed correctly', () {
        final field = getHostClass()
            .fieldDeclarations
            .firstWhere((element) => element.name == fieldName);
        expect(field.typeName, expectedTypeName);
        expect(field.isDeprecated, expectedIsDeprecatedFlag);
      });
    }

    group('WindowsDevice is analyzed correctly', () {
      // ignore: prefer_function_declarations_over_variables
      final getHostClass = () {
        return packageApi.classDeclarations
            .firstWhere((element) => element.name == 'WindowsDeviceInfo');
      };
      testField(getHostClass, 'computerName',
          expectedTypeName: 'String', expectedIsDeprecatedFlag: false);
      testField(getHostClass, 'numberOfCores',
          expectedTypeName: 'int', expectedIsDeprecatedFlag: false);
      testField(getHostClass, 'systemMemoryInMegabytes',
          expectedTypeName: 'int', expectedIsDeprecatedFlag: false);
      testField(getHostClass, 'userName',
          expectedTypeName: 'String', expectedIsDeprecatedFlag: false);
      test('does contain overwritten toMap() from super class', () {
        expect(
            getHostClass()
                .executableDeclarations
                .where((element) => element.name == 'toMap')
                .isNotEmpty,
            isTrue);
      });
      test('contains constructor with right number of arguments', () {
        final constructors = getHostClass()
            .executableDeclarations
            .where((element) => element.type == ExecutableType.constructor);
        expect(constructors.length, 1);
        expect(constructors.first.parameters.length, 25);
        final requiredConstructorParameters = constructors.first.parameters
            .where((element) => element.isRequired);
        expect(requiredConstructorParameters.length, 25);
      });
    });
    group('AndroidDeviceInfo is analyzed correctly', () {
      // ignore: prefer_function_declarations_over_variables
      final getHostClass = () {
        return packageApi.classDeclarations
            .firstWhere((element) => element.name == 'AndroidDeviceInfo');
      };
      testField(getHostClass, 'board',
          expectedTypeName: 'String?', expectedIsDeprecatedFlag: false);
      testField(getHostClass, 'device',
          expectedTypeName: 'String?', expectedIsDeprecatedFlag: false);
      testField(getHostClass, 'host',
          expectedTypeName: 'String?', expectedIsDeprecatedFlag: false);
      testField(getHostClass, 'isPhysicalDevice',
          expectedTypeName: 'bool?', expectedIsDeprecatedFlag: false);
      test('does contain overwritten toMap() from super class', () {
        expect(
            getHostClass()
                .executableDeclarations
                .where((element) => element.name == 'toMap')
                .isNotEmpty,
            isTrue);
      });
      test('does contain BaseDeviceInfo super class', () {
        expect(
            getHostClass()
                .superTypeNames
                .where((element) => element == 'BaseDeviceInfo')
                .isNotEmpty,
            isTrue);
      });
      test('contains constructor with right number of arguments', () {
        final constructors = getHostClass()
            .executableDeclarations
            .where((element) => element.type == ExecutableType.constructor);
        expect(constructors.length, 1);
        expect(constructors.first.parameters.length, 21);
        final requiredConstructorParameters = constructors.first.parameters
            .where((element) => element.isRequired);
        expect(requiredConstructorParameters.length, 5);
      });
    });
    group('Class existence tests', () {
      test('MethodChannelDeviceInfo is not part of the public API', () {
        // MethodChannelDeviceInfo gets used in the implementation but is not exposed directly or indirectly via
        // any signatures => not part of the public API
        expect(
            packageApi.classDeclarations
                .where((element) => element.name == 'MethodChannelDeviceInfo')
                .isEmpty,
            isTrue);
      });
      test('PlatformInterface is not part of the public API', () {
        // PlatformInterface is used as a super class for DeviceInfoPlatform but does not belong to this package
        // => it is not part of the public API
        expect(
            packageApi.classDeclarations
                .where((element) => element.name == 'PlatformInterface')
                .isEmpty,
            isTrue);
      });

      test('DeviceInfoPlatform is part of the public API', () {
        expect(
            packageApi.classDeclarations
                .where((element) => element.name == 'DeviceInfoPlatform')
                .isNotEmpty,
            isTrue);
      });
      test('BaseDeviceInfo is part of the public API', () {
        expect(
            packageApi.classDeclarations
                .where((element) => element.name == 'BaseDeviceInfo')
                .isNotEmpty,
            isTrue);
      });
      test('WebBrowserInfo is part of the public API', () {
        expect(
            packageApi.classDeclarations
                .where((element) => element.name == 'WebBrowserInfo')
                .isNotEmpty,
            isTrue);
      });
      test('MacOsDeviceInfo is part of the public API', () {
        expect(
            packageApi.classDeclarations
                .where((element) => element.name == 'MacOsDeviceInfo')
                .isNotEmpty,
            isTrue);
      });
      test('WindowsDeviceInfo is part of the public API', () {
        expect(
            packageApi.classDeclarations
                .where((element) => element.name == 'WindowsDeviceInfo')
                .isNotEmpty,
            isTrue);
      });
      test('LinuxDeviceInfo is part of the public API', () {
        expect(
            packageApi.classDeclarations
                .where((element) => element.name == 'LinuxDeviceInfo')
                .isNotEmpty,
            isTrue);
      });
      test('IosDeviceInfo is part of the public API', () {
        expect(
            packageApi.classDeclarations
                .where((element) => element.name == 'IosDeviceInfo')
                .isNotEmpty,
            isTrue);
      });
      test('AndroidDeviceInfo is part of the public API', () {
        expect(
            packageApi.classDeclarations
                .where((element) => element.name == 'AndroidDeviceInfo')
                .isNotEmpty,
            isTrue);
      });
      test('Platform constraints are null', () {
        // this is not a platform dependent package => no platform constraints
        expect(packageApi.androidPlatformConstraints, isNull);
        expect(packageApi.iosPlatformConstraints, isNull);
      });
    });
  });
  group('device_info_plus gets analyzed correctly', () {
    late PackageApi packageApi;
    final packageName = 'device_info_plus';
    final packageVersion = '4.1.2';
    final retriever = PackageApiRetriever(packageName, packageVersion);

    setUpAll(() async {
      packageApi = await retriever.retrieve();
    });

    test('Android Platform constraints get analyzed correctly', (() {
      expect(packageApi.androidPlatformConstraints, isNotNull);
      expect(packageApi.androidPlatformConstraints!.minSdkVersion, 16);
      expect(packageApi.androidPlatformConstraints!.compileSdkVersion, 31);
      expect(packageApi.androidPlatformConstraints!.targetSdkVersion, isNull);
    }));

    test('iOS Platform constraints get analyzed correctly', (() {
      expect(packageApi.iosPlatformConstraints, isNotNull);
      expect(packageApi.iosPlatformConstraints!.minimumOsVersion, 8.0);
    }));
  });
}
