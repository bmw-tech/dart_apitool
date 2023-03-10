import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package_widening_types', () {
    late PackageApiAnalyzer packageAWithNarrowTypes;
    late PackageApiAnalyzer packageAWithWiderTypes;

    setUpAll(
      () {
        packageAWithNarrowTypes = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'widening_types_diff',
          'package_a_with_narrow_types',
        ));
        packageAWithWiderTypes = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'widening_types_diff',
          'package_a_with_wider_types',
        ));
      },
    );
    group('widening types', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithNarrowTypes.analyze(),
          newApi: await packageAWithWiderTypes.analyze(),
        );
      });

      test(
          'detects type change in stringParam of someMethod which is not breaking',
          () {
        final stringParamChange = diffResult.apiChanges
            .where((ac) => ac.changeDescription.contains('stringParam'))
            .single;
        expect(
          stringParamChange.isBreaking,
          isFalse,
        );
      });
    });
    group('narrowing types', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithWiderTypes.analyze(),
          newApi: await packageAWithNarrowTypes.analyze(),
        );
      });

      test('detects type change in stringParam of someMethod which is breaking',
          () {
        final stringParamChange = diffResult.apiChanges
            .where((ac) => ac.changeDescription.contains('stringParam'))
            .single;
        expect(
          stringParamChange.isBreaking,
          isTrue,
        );
      });
    });
  });
}
