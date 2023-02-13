import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('flutter_blue version diff', () {
    group('0.5.0 to 0.6.0', () {
      final packageName = 'flutter_blue';
      final retriever_0_5_0 = PackageApiRetriever(packageName, '0.5.0');
      final retriever_0_6_0 = PackageApiRetriever(packageName, '0.6.0');
      late PackageApiDiffResult diffResult;

      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
            oldApi: await retriever_0_5_0.retrieve(),
            newApi: await retriever_0_6_0.retrieve());
      });

      test('sdk diff is detected', () {
        expect(
            diffResult.apiChanges.any((c) =>
                c.changeDescription.contains('Minimum SDK version changed')),
            isTrue);
      });

      test('Differ detects dependency changes', () async {
        expect(
            diffResult.apiChanges.any((element) =>
                element.changeDescription.contains('dependency') &&
                element.changeDescription.contains('rxdart') &&
                element.type == ApiChangeType.addBreaking),
            isTrue);
        expect(
            diffResult.apiChanges.any((element) =>
                element.changeDescription.contains('dependency') &&
                element.changeDescription.contains('protobuf') &&
                element.changeDescription.contains('^0.10.5') &&
                element.changeDescription.contains('^0.13.12') &&
                element.type == ApiChangeType.changeBreaking),
            isTrue);
      });

      test('Differ option "allowAdd" works', () async {
        final allowAddDiffResult = PackageApiDiffer(
            options: PackageApiDifferOptions(
          dependencyCheckMode: DependencyCheckMode.allowAdding,
        )).diff(
            oldApi: await retriever_0_5_0.retrieve(),
            newApi: await retriever_0_6_0.retrieve());

        // adding dependencies is no not breaking
        expect(
            allowAddDiffResult.apiChanges.any((element) =>
                element.changeDescription.contains('dependency') &&
                element.changeDescription.contains('rxdart') &&
                element.type == ApiChangeType.addCompatibleMinor),
            isTrue);
        // changes are still breaking
        expect(
            allowAddDiffResult.apiChanges.any((element) =>
                element.changeDescription.contains('dependency') &&
                element.changeDescription.contains('protobuf') &&
                element.changeDescription.contains('^0.10.5') &&
                element.changeDescription.contains('^0.13.12') &&
                element.type == ApiChangeType.changeBreaking),
            isTrue);
      });
    });
  });
}
