import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('enum ctor and toString', () {
    late PackageApiAnalyzer packageAWithEnumCtorAndToString;
    late PackageApiAnalyzer packageAWithoutEnumCtorAndToString;

    setUpAll(
      () {
        packageAWithEnumCtorAndToString = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'enum_and_tostring',
          'package_a_with_enum_ctor_and_tostring',
        ));
        packageAWithoutEnumCtorAndToString = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'enum_and_tostring',
          'package_a_without_enum_ctor_and_tostring',
        ));
      },
    );

    group('removing ctor and toString', () {
      late PackageApiDiffResult diffResult;
      setUp(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithEnumCtorAndToString.analyze(),
          newApi: await packageAWithoutEnumCtorAndToString.analyze(),
        );
      });
      test('making enum ctor private is no change at all', () {
        expect(
            diffResult.apiChanges
                .where((c) => c.changeDescription.contains('EnumA'))
                .isEmpty,
            isTrue);
      });
      test('removing toString is no breaking change', () {
        expect(
            diffResult.apiChanges
                .where((c) =>
                    c.changeDescription.contains('toString') && c.isBreaking)
                .isEmpty,
            isTrue);
      });
    });
    group('adding ctor and toString', () {
      late PackageApiDiffResult diffResult;
      setUp(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithoutEnumCtorAndToString.analyze(),
          newApi: await packageAWithEnumCtorAndToString.analyze(),
        );
      });
      test('making enum ctor public is no change at all', () {
        expect(
            diffResult.apiChanges
                .where((c) => c.changeDescription.contains('EnumA'))
                .isEmpty,
            isTrue);
      });
      test('adding toString is no breaking change', () {
        expect(
            diffResult.apiChanges
                .where((c) =>
                    c.changeDescription.contains('toString') && c.isBreaking)
                .isEmpty,
            isTrue);
      });
    });
  });
}
