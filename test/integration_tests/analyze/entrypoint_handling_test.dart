import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('Entrypoint handling', () {
    late PackageApi packageApi;

    setUpAll(() async {
      packageApi = await PackageApiAnalyzer(
        packagePath: 'test/test_packages/missing_export/package_a',
      ).analyzePrepared();
    });

    test('records all barrel entrypoints for a re-exported declaration', () {
      final classA = packageApi.interfaceDeclarations.singleWhere(
        (declaration) => declaration.name == 'ClassA',
      );

      expect(classA.entryPoints, contains('package_a.dart'));
      expect(classA.entryPoints, contains('package_a_extra.dart'));
      expect(classA.entryPoints, isNot(contains('types/class_a.dart')));
    });
  });
}
