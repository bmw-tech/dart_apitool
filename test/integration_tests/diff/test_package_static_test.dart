import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package_static_test', () {
    late PackageApiAnalyzer packageAWithoutStaticElement;
    late PackageApiAnalyzer packageAWithStaticElement;

    setUpAll(
      () {
        packageAWithoutStaticElement = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'static_elements',
          'package_a_without_static_element',
        ));
        packageAWithStaticElement = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'static_elements',
          'package_a_with_static_element',
        ));
      },
    );
    group('adding a static method to a required type', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithoutStaticElement.analyze(),
          newApi: await packageAWithStaticElement.analyze(),
        );
      });

      test('detects the addition of the static type', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.changeDescription.contains('thisIsANewStaticMethod'),
            ),
          ),
        );
      });

      test('addition of the static type is not breaking', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.changeDescription.contains('thisIsANewStaticMethod') &&
                  !change.isBreaking,
            ),
          ),
        );
      });
    });
  });
}
