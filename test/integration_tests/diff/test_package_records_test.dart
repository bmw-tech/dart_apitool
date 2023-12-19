import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package_records', () {
    late PackageApiAnalyzer packageAWithRecord;
    late PackageApiAnalyzer packageAWithChangedRecord;

    setUpAll(
      () {
        packageAWithRecord = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'records',
          'package_a_with_record',
        ));
        packageAWithChangedRecord = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'records',
          'package_a_with_changed_record',
        ));
      },
    );
    group('changing the record type structure', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithRecord.analyze(),
          newApi: await packageAWithChangedRecord.analyze(),
        );
      });

      test('is detected as breaking change', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.isBreaking &&
                  change.changeDescription
                      .contains('({int? someOtherValue, String someValue})') &&
                  change.affectedDeclaration!.toString().contains('asRecord'),
            ),
          ),
        );
      });
    });
  });
}
