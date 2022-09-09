import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

void main() {
  group('sentry version diff', () {
    group('5.1.0 to 6.0.0', () {
      late PackageApi packageApi_5_1_0;
      late PackageApi packageApi_6_0_0;
      late PackageApiDiffResult diffResult;

      setUpAll(() async {
        final packageName = 'sentry';
        //download from pub
        final packageDirectory_5_1_0 =
            await PubInteraction.installPackageToCache(
          packageName,
          '5.1.0',
        );
        final packageDirectory_6_0_0 =
            await PubInteraction.installPackageToCache(
          packageName,
          '6.0.0',
        );

        final analyzer_5_1_0 =
            PackageApiAnalyzer(packagePath: packageDirectory_5_1_0);
        packageApi_5_1_0 = await analyzer_5_1_0.analyze();
        final analyzer_6_0_0 =
            PackageApiAnalyzer(packagePath: packageDirectory_6_0_0);
        packageApi_6_0_0 = await analyzer_6_0_0.analyze();

        diffResult = PackageApiDiffer()
            .diff(oldApi: packageApi_5_1_0, newApi: packageApi_6_0_0);
      });

      test('is breaking change', () {
        final isBreakingChange =
            diffResult.apiChanges.any((element) => element.type.isBreaking);
        expect(isBreakingChange, isTrue);
      });
    });
  });
}
