import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('sentry version diff', () {
    group('5.1.0 to 6.0.0', () {
      final packageName = 'sentry';
      final retriever_5_1_0 = PackageApiRetriever(packageName, '5.1.0');
      final retriever_6_0_0 = PackageApiRetriever(packageName, '6.0.0');
      late PackageApiDiffResult diffResult;

      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
            oldApi: await retriever_5_1_0.retrieve(),
            newApi: await retriever_6_0_0.retrieve());
      });

      test('is breaking change', () {
        final isBreakingChange =
            diffResult.apiChanges.any((element) => element.isBreaking);
        expect(isBreakingChange, isTrue);
      });
    });
    group('5.0.0 to 5.1.0', () {
      final packageName = 'sentry';
      final retriever_5_0_0 = PackageApiRetriever(packageName, '5.0.0');
      final retriever_5_1_0 = PackageApiRetriever(packageName, '5.1.0');
      late PackageApiDiffResult diffResult;

      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
            oldApi: await retriever_5_0_0.retrieve(),
            newApi: await retriever_5_1_0.retrieve());
      });

      test('is non-breaking change', () {
        final isBreakingChange =
            diffResult.apiChanges.any((element) => element.isBreaking);
        expect(isBreakingChange, isFalse);
      });
    });
  });
}
