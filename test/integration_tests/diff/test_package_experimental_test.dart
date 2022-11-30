import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package_experimental', () {
    late PackageApiAnalyzer packageAWithExperimental;
    late PackageApiAnalyzer packageAWithoutExperimental;

    setUpAll(
      () {
        packageAWithExperimental = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'experimental_diff',
          'package_a_with_experimental',
        ));
        packageAWithoutExperimental = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'experimental_diff',
          'package_a_without_experimental',
        ));
      },
    );
    group('with experimental to without experimental', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithExperimental.analyze(),
          newApi: await packageAWithoutExperimental.analyze(),
        );
      });

      test('detects removal of experimental flag', () {
        expect(diffResult.apiChanges.length, 4); // experimental + meta package
        expect(
          diffResult.apiChanges.any(
            (element) =>
                element.affectedDeclaration?.name == 'ClassA' &&
                !element.isBreaking,
          ),
          isTrue,
        );
        expect(
          diffResult.apiChanges.any(
            (element) =>
                element.affectedDeclaration?.name == 'name' &&
                !element.isBreaking,
          ),
          isTrue,
        );
        expect(
          diffResult.apiChanges.any(
            (element) =>
                element.affectedDeclaration?.name == 'getName' &&
                !element.isBreaking,
          ),
          isTrue,
        );
      });
    });
    group('without experimental to with experimental', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithoutExperimental.analyze(),
          newApi: await packageAWithExperimental.analyze(),
        );
      });

      test('detects addition of experimental flag', () {
        expect(diffResult.apiChanges.length, 4); // experimental + meta package
        expect(
          diffResult.apiChanges.any(
            (element) =>
                element.affectedDeclaration?.name == 'ClassA' &&
                element.isBreaking,
          ),
          isTrue,
        );
        expect(
          diffResult.apiChanges.any(
            (element) =>
                element.affectedDeclaration?.name == 'name' &&
                element.isBreaking,
          ),
          isTrue,
        );
        expect(
          diffResult.apiChanges.any(
            (element) =>
                element.affectedDeclaration?.name == 'getName' &&
                element.isBreaking,
          ),
          isTrue,
        );
      });
    });
  });
}
