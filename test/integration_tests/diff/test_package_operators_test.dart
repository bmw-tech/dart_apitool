import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package_operators', () {
    late PackageApiAnalyzer packageAWithRecord;
    late PackageApiAnalyzer packageAWithChangedRecord;

    setUpAll(
      () {
        packageAWithRecord = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'operators',
          'package_a_with_operators',
        ));
        // we test the same package against itself.
        // We just want to know if the differ can handle two operators with the same name
        packageAWithChangedRecord = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'operators',
          'package_a_with_operators',
        ));
      },
    );
    group('having the - operator two times (unary and not)', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithRecord.analyze(),
          newApi: await packageAWithChangedRecord.analyze(),
        );
      });

      test('does not crash', () {
        expect(
          diffResult.apiChanges,
          isEmpty,
        );
      });
    });
  });
}
