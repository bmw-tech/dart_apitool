import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

void main() {
  group('Typedefs', () {
    late PackageApiAnalyzer packageWithTypedefExportAnalyzer;
    late PackageApi packageWithTypedefExport;
    setUp(() async {
      packageWithTypedefExportAnalyzer = PackageApiAnalyzer(
        packagePath: 'test/test_packages/missing_export/package_a',
      );
      packageWithTypedefExport =
          await packageWithTypedefExportAnalyzer.analyze();
    });

    test('carry over the entrypoint to the aliased type', () {
      final privateClassCExports = packageWithTypedefExport
          .interfaceDeclarations
          .where((id) => id.name == '_PrivateClassC');
      expect(privateClassCExports, isNotEmpty);
      expect(privateClassCExports.single.entryPoints?.isNotEmpty, isTrue);
    });
  });
}
