import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('Unexported functions', () {
    late PackageApiAnalyzer packageAnalyzer;
    late PackageApi packageApi;
    setUp(() async {
      packageAnalyzer = PackageApiAnalyzer(
        packagePath: 'test/test_packages/missing_export/package_a',
      );
      packageApi = await packageAnalyzer.analyzePrepared();
    });

    test('should not include unexported top level function', () {
      final buildPublicClassExecutables = packageApi.executableDeclarations
          .where((ed) => ed.name == 'buildPublicClass')
          .toList();
      expect(buildPublicClassExecutables, isEmpty);
    });

    test('should not include unexported PrivateClass', () {
      final privateClassEntries = packageApi.interfaceDeclarations
          .where((id) => id.name == 'PrivateClass')
          .toList();
      expect(privateClassEntries, isEmpty);
    });
  });
}
