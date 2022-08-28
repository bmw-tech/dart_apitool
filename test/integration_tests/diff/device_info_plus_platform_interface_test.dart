// we know that device_info_plus_platform_interface had a breaking change problem between 2.2.0 and 2.4.0
// this integration test makes sure that dart_apitool detects that correctly
import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

void main() {
  group('device_info_plus_platform_interface', () {
    late PackageApi packageApi_2_2_0;
    late PackageApi packageApi_2_4_0;
    late PackageApiDiffResult diffResult;
    setUpAll(() async {
      final packageName = 'device_info_plus_platform_interface';
      //download from pub
      final packageDirectory_2_2_0 = await PubInteraction.installPackageToCache(
        packageName,
        '2.2.0',
      );
      final packageDirectory_2_4_0 = await PubInteraction.installPackageToCache(
        packageName,
        '2.4.0',
      );

      final analyzer_2_2_0 =
          PackageApiAnalyzer(packagePath: packageDirectory_2_2_0);
      packageApi_2_2_0 = await analyzer_2_2_0.analyze();
      final analyzer_2_4_0 =
          PackageApiAnalyzer(packagePath: packageDirectory_2_4_0);
      packageApi_2_4_0 = await analyzer_2_4_0.analyze();

      diffResult = PackageApiDiffer()
          .diff(oldApi: packageApi_2_2_0, newApi: packageApi_2_4_0);
    });

    test('Any breaking changes are detected', () {
      expect(diffResult.apiChanges.any((element) => element.type.isBreaking),
          isTrue);
    });
    test('adding username breaking change is detected', () {
      final userNameChange = diffResult.apiChanges
          .where((change) => change.changeDescription.contains('userName'))
          .first;
      expect(userNameChange.type, ApiChangeType.addBreaking);
    });
  });
}
