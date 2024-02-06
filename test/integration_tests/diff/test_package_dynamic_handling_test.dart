import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package_dynamic_handling', () {
    late PackageApiAnalyzer packageAWithDynamic;
    late PackageApiAnalyzer packageAWithStricterTypes;

    setUpAll(
      () {
        packageAWithDynamic = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'dynamic_handling',
          'package_a_with_dynamic_types',
        ));
        packageAWithStricterTypes = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'dynamic_handling',
          'package_a_with_stricter_types',
        ));
      },
    );
    group('turning dynamic to Object?', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithDynamic.analyze(),
          newApi: await packageAWithStricterTypes.analyze(),
        );
      });

      test('is no breaking change for method parameters', () {
        final paramChange = diffResult.apiChanges
            .where((ac) =>
                ac.affectedDeclaration?.name.contains('parameter') ?? false)
            .single;
        expect(
          paramChange.isBreaking,
          isFalse,
        );
      });

      test('is a breaking change for function return types', () {
        final functionChange = diffResult.apiChanges
            .where((ac) =>
                ac.affectedDeclaration?.name.contains('function') ?? false)
            .single;
        expect(
          functionChange.isBreaking,
          isTrue,
        );
      });

      test('is a breaking change for property types)', () {
        final functionChange = diffResult.apiChanges
            .where((ac) =>
                ac.affectedDeclaration?.name.contains('property') ?? false)
            .single;
        expect(
          functionChange.isBreaking,
          isTrue,
        );
      });
    });
    group('turning Object? type to dynamic', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithStricterTypes.analyze(),
          newApi: await packageAWithDynamic.analyze(),
        );
      });

      test('is no breaking change for method parameters', () {
        final paramChange = diffResult.apiChanges
            .where((ac) =>
                ac.affectedDeclaration?.name.contains('parameter') ?? false)
            .single;
        expect(
          paramChange.isBreaking,
          isFalse,
        );
      });

      test('is no breaking change for function return types', () {
        final functionChange = diffResult.apiChanges
            .where((ac) =>
                ac.affectedDeclaration?.name.contains('function') ?? false)
            .single;
        expect(
          functionChange.isBreaking,
          isFalse,
        );
      });

      test('is no breaking change for property types)', () {
        final functionChange = diffResult.apiChanges
            .where((ac) =>
                ac.affectedDeclaration?.name.contains('property') ?? false)
            .single;
        expect(
          functionChange.isBreaking,
          isFalse,
        );
      });
    });
  });
}
