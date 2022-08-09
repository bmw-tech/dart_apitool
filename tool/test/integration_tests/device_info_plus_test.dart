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
      expect(result.exitCode, 0, reason: result.stdout);
    });
    setUp(() async {
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
    });
  });
}
