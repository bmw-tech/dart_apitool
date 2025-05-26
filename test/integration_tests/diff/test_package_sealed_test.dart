import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package_experimental (sealed)', () {
    late PackageApiAnalyzer packageAWithExperimental;
    late PackageApiAnalyzer packageAWithoutExperimental;

    setUpAll(
      () {
        final packageAPath = path.join(
          'test',
          'test_packages',
          'experimental_and_sealed_diff',
          'package_a_with_experimental_and_sealed',
        );
        final packageBPath = path.join(
          'test',
          'test_packages',
          'experimental_and_sealed_diff',
          'package_a_without_experimental_and_sealed',
        );
        packageAWithExperimental = PackageApiAnalyzer(
          packagePath: packageAPath,
          analyzerRootPath: packageAPath,
        );
        packageAWithoutExperimental = PackageApiAnalyzer(
          packagePath: packageBPath,
          analyzerRootPath: packageBPath,
        );
      },
    );
    group('with sealed to without sealed', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithExperimental.analyze(),
          newApi: await packageAWithoutExperimental.analyze(),
        );
      });

      test('detects removal of sealed flag', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'ClassD' &&
                  change.changeDescription.contains('Sealed') &&
                  !change.isBreaking,
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
          oldApi: await packageAWithoutExperimental.analyze(),
          newApi: await packageAWithExperimental.analyze(),
        );
      });

      test('detects addition of sealed flag', () {
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'ClassD' &&
                  change.changeDescription.contains('Sealed') &&
                  change.isBreaking,
            ),
          ),
        );
        expect(
          diffResult.apiChanges,
          containsOnce(
            predicate(
              (ApiChange change) =>
                  change.affectedDeclaration?.name == 'newMethod' &&
                  !change.isBreaking,
            ),
          ),
        );
      });
    });
  });
}
