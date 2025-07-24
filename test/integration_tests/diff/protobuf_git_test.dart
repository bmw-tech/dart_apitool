import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('protobuf version diff', () {
    group(
        '4916e6f7d34443869c27d997749d4362870fd7ce to 7f7d776a1812594b0d2b56bac41439f50006e225',
        () {
      final retrieverOld = GitPackageApiRetriever(
          'https://github.com/google/protobuf.dart.git',
          '4916e6f7d34443869c27d997749d4362870fd7ce',
          relativePackagePath: 'protobuf');
      final retrieverNew = GitPackageApiRetriever(
          'https://github.com/google/protobuf.dart.git',
          '7f7d776a1812594b0d2b56bac41439f50006e225',
          relativePackagePath: 'protobuf');

      late PackageApiDiffResult diffResult;
      late PackageApi oldApi;
      late PackageApi newApi;

      setUpAll(() async {
        oldApi = await retrieverOld.retrieve();
        newApi = await retrieverNew.retrieve();
        diffResult = PackageApiDiffer().diff(oldApi: oldApi, newApi: newApi);
      });

      test('does not report changes from type X to type X', () {
        // Check for any changes that report a type change from X to X (same type)
        final identicalTypeChanges = diffResult.apiChanges.where((change) {
          final description = change.changeDescription;

          // Look for pattern: "changed. TypeX -> TypeX" where TypeX is identical
          final typeChangePattern =
              RegExp(r'changed\.\s*(.+?)\s*->\s*(.+?)(?:\s|$)');
          final match = typeChangePattern.firstMatch(description);

          if (match != null) {
            final oldType = match.group(1)?.trim();
            final newType = match.group(2)?.trim();
            return oldType == newType && oldType != null && oldType.isNotEmpty;
          }

          return false;
        }).toList();

        // Print all identical type changes for debugging
        for (final change in identicalTypeChanges) {
          print(
              'Found identical type change: ${change.changeDescription} (${change.changeCode})');
        }

        expect(identicalTypeChanges, isEmpty,
            reason:
                'Found ${identicalTypeChanges.length} changes that report type changes from X to X');
      });
    });
  });
}
