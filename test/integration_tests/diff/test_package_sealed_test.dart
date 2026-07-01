import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

import '../helper/integration_test_helper.dart';

void main() {
  group('test_package_experimental (sealed)', () {
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
    group('with sealed to without sealed', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithExperimental.analyzePrepared(),
          newApi: await packageAWithoutExperimental.analyzePrepared(),
        );
      });

      test('ignores removal of legacy sealed annotation', () {
        expect(
          diffResult.apiChanges,
          isNot(
            contains(
              predicate(
                (ApiChange change) =>
                    change.affectedDeclaration?.name == 'ClassD' &&
                    change.changeDescription.contains('Sealed'),
              ),
            ),
          ),
        );
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'newMethod' &&
                  change.isBreaking,
            ),
          ),
        );
      });
    });
    group('without sealed to with sealed', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithoutExperimental.analyzePrepared(),
          newApi: await packageAWithExperimental.analyzePrepared(),
        );
      });

      test('ignores addition of legacy sealed annotation', () {
        expect(
          diffResult.apiChanges,
          isNot(
            contains(
              predicate(
                (ApiChange change) =>
                    change.affectedDeclaration?.name == 'ClassD' &&
                    change.changeDescription.contains('Sealed'),
              ),
            ),
          ),
        );
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'newMethod' &&
                  change.isBreaking,
            ),
          ),
        );
      });
    });
  });
}
