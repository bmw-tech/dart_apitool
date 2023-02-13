import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('flutter_blue version diff', () {
    group('4.3.1 to 4.3.2', () {
      final packageName = 'cloud_firestore';
      final retriever_4_3_1 = PackageApiRetriever(packageName, '4.3.1');
      final retriever_4_3_2 = PackageApiRetriever(packageName, '4.3.2');
      late PackageApiDiffResult diffResult;

      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
            oldApi: await retriever_4_3_1.retrieve(),
            newApi: await retriever_4_3_2.retrieve());
      });

      test('compatible dependency changes lead to an expected patch change',
          () {
        expect(
            diffResult.apiChanges.every(
              (element) =>
                  !element.type.requiresMinorBump && !element.type.isBreaking,
            ),
            isTrue);
      });
    });
  });
}
