import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  final gitUrl = 'https://github.com/dart-lang/native.git';
  group('native diff tests', () {
    group('widening in extensions', () {
      final refParent = '0924cb0e80ed6ac39298363fabe0916808a4a1fe';
      final refChild = '29cf243b4b3452354ef905f62874a8c975ef1538';
      final parentRetriever = GitPackageApiRetriever(
        gitUrl,
        refParent,
        relativePackagePath: 'pkgs/data_assets',
      );
      final childRetriever = GitPackageApiRetriever(
        gitUrl,
        refChild,
        relativePackagePath: 'pkgs/data_assets',
      );

      late PackageApiDiffResult diffResult;

      setUpAll(() async {
        final oldApi = await parentRetriever.retrieve();
        final newApi = await childRetriever.retrieve();
        diffResult = PackageApiDiffer(
            options: PackageApiDifferOptions(
          doCheckSdkVersion: false,
        )).diff(
          oldApi: oldApi,
          newApi: newApi,
        );
      });

      test('should not be breaking', () {
        final breakingChanges =
            diffResult.apiChanges.where((change) => change.isBreaking).toList();
        expect(breakingChanges, []);
      });
    });

    group('objective_c', () {
      late final PackageApi objcApi;
      final refObjc = '0924cb0e80ed6ac39298363fabe0916808a4a1fe';

      setUp(() async {
        final objcRetriever = GitPackageApiRetriever(
          gitUrl,
          refObjc,
          relativePackagePath: 'pkgs/objective_c',
        );
        objcApi = await objcRetriever.retrieve();
      });

      test('_FinalizablePointer should not be leaked in the public API',
          () async {
        final hasFinalizablePointer = objcApi.interfaceDeclarations
            .any((id) => id.name == '_FinalizablePointer');
        expect(hasFinalizablePointer, isFalse);
      });
    });
  });
}
