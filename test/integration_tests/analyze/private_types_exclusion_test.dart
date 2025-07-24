import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

void main() {
  group('Private types exclusion', () {
    late PackageApiAnalyzer packageAnalyzer;
    late PackageApi packageApi;
    setUp(() async {
      packageAnalyzer = PackageApiAnalyzer(
        packagePath: 'test/test_packages/missing_export/package_a',
      );
      packageApi = await packageAnalyzer.analyze();
    });

    test('should not include private class in extracted API', () {
      final privateClassDeclarations = packageApi.interfaceDeclarations
          .where((id) => id.name == '_PrivateClass');
      expect(privateClassDeclarations, isEmpty,
          reason:
              'Private class _PrivateClass should not be included in public API');
    });

    test('should not include private enum in extracted API', () {
      final privateEnumDeclarations = packageApi.interfaceDeclarations
          .where((id) => id.name == '_PrivateEnum');
      expect(privateEnumDeclarations, isEmpty,
          reason:
              'Private enum _PrivateEnum should not be included in public API');
    });

    test('should not include private property in extracted API', () {
      final privatePropertyDeclarations = packageApi.fieldDeclarations
          .where((fd) => fd.name == '_privateProperty');
      expect(privatePropertyDeclarations, isEmpty,
          reason:
              'Private property _privateProperty should not be included in public API');
    });

    test('should not include private function in extracted API', () {
      final privateFunctionDeclarations = packageApi.executableDeclarations
          .where((ed) => ed.name == '_privateFunction');
      expect(privateFunctionDeclarations, isEmpty,
          reason:
              'Private function _privateFunction should not be included in public API');
    });

    test('should not include any declarations from private_types.dart', () {
      // Check that no declarations have their relative path pointing to private_types.dart
      final allDeclarations = [
        ...packageApi.interfaceDeclarations,
        ...packageApi.executableDeclarations,
        ...packageApi.fieldDeclarations,
        ...packageApi.typeAliasDeclarations,
      ];

      final privateTypesDeclarations = allDeclarations
          .where((d) => d.relativePath.endsWith('private_types.dart'));

      expect(privateTypesDeclarations, isEmpty,
          reason:
              'No declarations from private_types.dart should be included in public API');
    });

    test('should verify that public types are still extracted', () {
      // Verify that the test package still extracts legitimate public API elements
      final classADeclarations =
          packageApi.interfaceDeclarations.where((id) => id.name == 'ClassA');
      expect(classADeclarations, isNotEmpty,
          reason: 'Public class ClassA should be included in API');

      // Check for ClassC as a typedef instead of interface
      final classCTypeAliases =
          packageApi.typeAliasDeclarations.where((tad) => tad.name == 'ClassC');
      expect(classCTypeAliases, isNotEmpty,
          reason: 'Public typedef ClassC should be included in API');
    });
  });
}
