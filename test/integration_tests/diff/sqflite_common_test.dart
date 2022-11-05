// ignore_for_file: non_constant_identifier_names

import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('sqflite_common diff', () {
    group('2.3.0 to 2.4.0', () {
      final packageName = 'sqflite_common';
      final sqflite_common_2_3_0 = PackageApiRetriever(packageName, '2.3.0');
      final sqflite_common_2_4_0 = PackageApiRetriever(packageName, '2.4.0');
      late PackageApiDiffResult diffResult;

      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
            oldApi: await sqflite_common_2_3_0.retrieve(),
            newApi: await sqflite_common_2_4_0.retrieve());
      });

      test('detects rawQueryCursor added to required interface as breaking',
          () {
        final isBreakingChange = diffResult.apiChanges.any((element) =>
            element.affectedDeclaration!.name == 'rawQueryCursor' &&
            element.type.isBreaking);
        expect(isBreakingChange, isTrue);
      });
    });
  });
}
