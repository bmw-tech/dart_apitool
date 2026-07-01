import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

import '../helper/integration_test_helper.dart';

void main() {
  group('test_package_experimental (experimental)', () {
    late PackageApiAnalyzer packageAWithExperimental;
    late PackageApiAnalyzer packageAWithoutExperimental;

    setUpAll(() {
      packageAWithExperimental = PackageApiAnalyzer(
        packagePath: path.join(
          'test',
          'test_packages',
          'experimental_and_sealed_diff',
          'package_a_with_experimental_and_sealed',
        ),
      );
      packageAWithoutExperimental = PackageApiAnalyzer(
        packagePath: path.join(
          'test',
          'test_packages',
          'experimental_and_sealed_diff',
          'package_a_without_experimental_and_sealed',
        ),
      );
    });
    group('with experimental to without experimental', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithExperimental.analyzePrepared(),
          newApi: await packageAWithoutExperimental.analyzePrepared(),
        );
      });

      test('detects removal of experimental flag', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'ClassA' &&
                  !change.isBreaking,
            ),
          ),
        );
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'name' &&
                  !change.isBreaking,
            ),
          ),
        );
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'getName' &&
                  !change.isBreaking,
            ),
          ),
        );
      });
    });
    group('without experimental to with experimental', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithoutExperimental.analyzePrepared(),
          newApi: await packageAWithExperimental.analyzePrepared(),
        );
      });

      test('detects addition of experimental flag', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'ClassA' &&
                  change.isBreaking,
            ),
          ),
        );
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'name' &&
                  change.isBreaking,
            ),
          ),
        );
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'getName' &&
                  change.isBreaking,
            ),
          ),
        );
      });
    });
  });
}
