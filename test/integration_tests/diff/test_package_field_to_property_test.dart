import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package_field_to_property', () {
    late PackageApiAnalyzer packageAWithField;
    late PackageApiAnalyzer packageAWithProperty;

    setUpAll(
      () {
        final packageAPath = path.join(
          'test',
          'test_packages',
          'field_to_property',
          'package_a_with_field',
        );
        final packageBPath = path.join(
          'test',
          'test_packages',
          'field_to_property',
          'package_a_with_property',
        );
        packageAWithField = PackageApiAnalyzer(
          packagePath: packageAPath,
          analyzerRootPath: packageAPath,
        );
        packageAWithProperty = PackageApiAnalyzer(
          packagePath: packageBPath,
          analyzerRootPath: packageBPath,
        );
      },
    );
    group('changing a field to a read-only property', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithField.analyze(),
          newApi: await packageAWithProperty.analyze(),
        );
      });

      test('is detected as breaking change', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.isBreaking &&
                  change.affectedDeclaration.toString().contains('stringValue'),
            ),
          ),
        );
      });
    });
  });
}
