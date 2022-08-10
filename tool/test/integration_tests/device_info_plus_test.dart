import 'dart:io';
import 'package:dart_apitool/api_tool.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

void main() {
  final packageDirectory = path.join(Directory.current.absolute.path, '..',
      'sample_packages', 'from_pub', 'device_info_plus_platform_interface');
  group('device_info_plus_platform_interface gets analyzed correctly', () {
    late PackageApi packageApi;
    setUpAll(() async {
      // execute flutter pub get
      final result = await Process.run(
        'flutter',
        ['pub', 'get'],
        workingDirectory: packageDirectory,
        runInShell: true,
      );
      expect(result.exitCode, 0, reason: result.stderr);
      final analyzer = PackageApiAnalyzer(packagePath: packageDirectory);
      packageApi = await analyzer.analyze();
    });
    test('Package name is correct', () {
      expect(packageApi.packageName, 'device_info_plus_platform_interface');
    });
    test('Version is correct', () {
      expect(packageApi.packageVersion, '2.4.0');
    });
    void _testField(
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
      _testField(getHostClass, 'computerName',
          expectedTypeName: 'String', expectedIsDeprecatedFlag: false);
      _testField(getHostClass, 'numberOfCores',
          expectedTypeName: 'int', expectedIsDeprecatedFlag: false);
      _testField(getHostClass, 'systemMemoryInMegabytes',
          expectedTypeName: 'int', expectedIsDeprecatedFlag: false);
      _testField(getHostClass, 'userName',
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
      _testField(getHostClass, 'board',
          expectedTypeName: 'String?', expectedIsDeprecatedFlag: false);
      _testField(getHostClass, 'device',
          expectedTypeName: 'String?', expectedIsDeprecatedFlag: false);
      _testField(getHostClass, 'host',
          expectedTypeName: 'String?', expectedIsDeprecatedFlag: false);
      _testField(getHostClass, 'isPhysicalDevice',
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
    });
  });
}
