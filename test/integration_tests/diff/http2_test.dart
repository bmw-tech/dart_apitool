// ignore_for_file: non_constant_identifier_names

import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('http2 version diff', () {
    group('2.3.0 to 2.3.1_wip', () {
      final packageName = 'http2';
      final retriever_2_3_0 = PackageApiRetriever(packageName, '2.3.0');
      final retriever_2_3_1_wip = GitPackageApiRetriever(
          'https://github.com/dart-lang/http2.git',
          'aeb506cb0fc78e42a812137cdc40ed307fe8f64c');
      late PackageApiDiffResult diffResult;

      setUpAll(() async {
        diffResult = PackageApiDiffer(
            options: PackageApiDifferOptions(
          doCheckSdkVersion: false,
        )).diff(
          oldApi: await retriever_2_3_0.retrieve(),
          newApi: await retriever_2_3_1_wip.retrieve(),
        );
      });

      test(
          'no breaking change is detected (even though parameter type changed from dynamic to Object?)',
          () {
        expect(
            diffResult.apiChanges.every((element) => !element.type.isBreaking),
            isTrue);
      });
    });
  });
}
