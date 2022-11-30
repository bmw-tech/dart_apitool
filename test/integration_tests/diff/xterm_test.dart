// ignore_for_file: non_constant_identifier_names

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
        expect(
            diffResult.apiChanges.any((element) => element.isBreaking), isTrue);
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
    group('1.3.0 to 2.0.0', () {
      final packageName = 'xterm';
      final retriever_1_3_0 = PackageApiRetriever(packageName, '1.3.0');
      final retriever_2_0_0 = PackageApiRetriever(packageName, '2.0.0');
      late PackageApiDiffResult diffResult;

      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
            oldApi: await retriever_1_3_0.retrieve(),
            newApi: await retriever_2_0_0.retrieve());
      });

      test('contains correct dependency changes', () {
        expect(
            diffResult.apiChanges.any(
                (element) => element.changeDescription.contains('dependency')),
            isTrue);
        expect(
            diffResult.apiChanges.any((element) =>
                element.changeDescription.contains('dependency') &&
                element.changeDescription.contains('meta') &&
                element.changeDescription.contains('^1.1.8') &&
                element.changeDescription.contains('^1.3.0') &&
                element.type == ApiChangeType.changeCompatible),
            isTrue);
        expect(
            diffResult.apiChanges.any((element) =>
                element.changeDescription.contains('dependency') &&
                element.changeDescription.contains('async') &&
                element.changeDescription.contains('removed') &&
                element.type == ApiChangeType.removeCompatible),
            isTrue);
        expect(
            diffResult.apiChanges.any((element) =>
                element.changeDescription.contains('dependency') &&
                element.changeDescription.contains('quiver') &&
                element.changeDescription.contains('^2.1.3') &&
                element.changeDescription.contains('^3.0.0') &&
                element.type == ApiChangeType.changeBreaking),
            isTrue);
      });
    });
  });
}
