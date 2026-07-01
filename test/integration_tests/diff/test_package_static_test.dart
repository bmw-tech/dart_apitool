import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

import '../helper/integration_test_helper.dart';

void main() {
  group('test_package_static_test', () {
    late PackageApiAnalyzer packageAWithoutStaticElement;
    late PackageApiAnalyzer packageAWithStaticElement;

    setUpAll(() {
      packageAWithoutStaticElement = PackageApiAnalyzer(
        packagePath: path.join(
          'test',
          'test_packages',
          'static_elements',
          'package_a_without_static_element',
        ),
      );
      packageAWithStaticElement = PackageApiAnalyzer(
        packagePath: path.join(
          'test',
          'test_packages',
          'static_elements',
          'package_a_with_static_element',
        ),
      );
    });
    group('adding a static method to a required type', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithoutStaticElement.analyzePrepared(),
          newApi: await packageAWithStaticElement.analyzePrepared(),
        );
      });

      test('detects the addition of a static method', () {
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

      test('addition of a static method is not breaking', () {
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

      test('detects the addition of a static field', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.changeDescription.contains('thisIsANewStaticField'),
            ),
          ),
        );
      });

      test('addition of a static field is not breaking', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.changeDescription.contains('thisIsANewStaticField') &&
                  !change.isBreaking,
            ),
          ),
        );
      });

      test('detects the addition of a const field as a field', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.changeDescription.contains('thisIsANewConst'),
            ),
          ),
        );
      });

      test('addition of a const field is not breaking', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.changeDescription.contains('thisIsANewConst') &&
                  !change.isBreaking,
            ),
          ),
        );
      });
    });
  });
}
