import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package with library rename but untouched entry point', () {
    late PackageApiAnalyzer packageAWithOldLibraryName;
    late PackageApiAnalyzer packageAWithNewLibraryName;

    setUpAll(
      () {
        packageAWithOldLibraryName = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'library_rename_without_entry_point_change',
          'package_a_with_old_library_name',
        ));
        packageAWithNewLibraryName = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'library_rename_without_entry_point_change',
          'package_a_with_new_library_name',
        ));
      },
    );
    group('diff', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithOldLibraryName.analyze(),
          newApi: await packageAWithNewLibraryName.analyze(),
        );
      });

      test('doesn\'t count as any public API change', () {
        expect(
          diffResult.apiChanges.length,
          0,
        );
      });
    });
  });
}
