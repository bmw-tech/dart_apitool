import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('xterm version diff', () {
    group('2.5.0 to 2.6.0', () {
      final packageName = 'xterm';
      final retriever_2_5_0 = PackageApiRetriever(packageName, '2.5.0-pre');
      final retriever_2_6_0 = PackageApiRetriever(packageName, '2.6.0');
      late PackageApiDiffResult diffResult;

      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
            oldApi: await retriever_2_5_0.retrieve(),
            newApi: await retriever_2_6_0.retrieve());
      });

      test('breaking change is detected', () {
        expect(diffResult.apiChanges.any((element) => element.type.isBreaking),
            isTrue);
      });
      test('contains "selectWord" removal', () {
        expect(
            diffResult.apiChanges.any((change) =>
                change.type == ApiChangeType.remove &&
                change.changeDescription.contains('selectWord')),
            isTrue);
      });

      test('contains "enableSuggestions" parameter addition', () {
        expect(
            diffResult.apiChanges.any((change) =>
                change.type == ApiChangeType.addCompatible &&
                change.changeDescription.contains('enableSuggestions')),
            isTrue);
      });
    });
  });
}
