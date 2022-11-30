// we know that device_info_plus_platform_interface had a breaking change problem between 2.2.0 and 2.4.0
// this integration test makes sure that dart_apitool detects that correctly
import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('device_info_plus_platform_interface', () {
    final packageName = 'device_info_plus_platform_interface';

    group('2.2.0 to 2.4.0', () {
      final retriever_2_2_0 = PackageApiRetriever(packageName, '2.2.0');
      final retriever_2_4_0 = PackageApiRetriever(packageName, '2.4.0');
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
            oldApi: await retriever_2_2_0.retrieve(),
            newApi: await retriever_2_4_0.retrieve());
      });

      test('any breaking changes are detected', () {
        expect(
            diffResult.apiChanges.any((element) => element.isBreaking), isTrue);
      });
      test('adding username breaking change is detected', () {
        final userNameChange = diffResult.apiChanges
            .where((change) => change.changeDescription.contains('userName'))
            .first;
        expect(userNameChange.type, ApiChangeType.addBreaking);
      });
    });
  });
}
