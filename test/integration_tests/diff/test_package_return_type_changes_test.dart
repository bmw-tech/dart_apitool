import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package_return_type_changes', () {
    late PackageApiAnalyzer packageWithWideReturns;
    late PackageApiAnalyzer packageWithNarrowReturns;

    setUpAll(
      () {
        packageWithWideReturns = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'return_type_changes',
          'package_with_wide_returns',
        ));
        packageWithNarrowReturns = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'return_type_changes',
          'package_with_narrow_returns',
        ));
      },
    );

    group('return type narrowing (should be non-breaking)', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageWithWideReturns.analyze(),
          newApi: await packageWithNarrowReturns.analyze(),
        );
      });

      test(
          'detects nullable to non-nullable string return type change as non-breaking',
          () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('String? -> String') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isFalse,
          reason:
              'Narrowing String? to String should be non-breaking for return types',
        );
      });

      test('detects num to int return type change as non-breaking', () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('num -> int') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isFalse,
          reason:
              'Narrowing num to int should be non-breaking for return types',
        );
      });

      test('detects List<num> to List<int> return type change as non-breaking',
          () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('List<num> -> List<int>') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isFalse,
          reason:
              'Narrowing List<num> to List<int> should be non-breaking for return types',
        );
      });

      test('detects Set<num> to Set<int> return type change as non-breaking',
          () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('Set<num> -> Set<int>') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isFalse,
          reason:
              'Narrowing Set<num> to Set<int> should be non-breaking for return types',
        );
      });

      test(
          'detects Iterable<num> to Iterable<int> return type change as non-breaking',
          () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription
                    .contains('Iterable<num> -> Iterable<int>') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isFalse,
          reason:
              'Narrowing Iterable<num> to Iterable<int> should be non-breaking for return types',
        );
      });

      test('detects supertype to subtype return type change as non-breaking',
          () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('SomeSuperType -> SomeSubType') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isFalse,
          reason:
              'Narrowing supertype to subtype should be non-breaking for return types',
        );
      });

      test(
          'detects Iterable<num> to List<int> return type change as non-breaking',
          () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('Iterable<num> -> List<int>') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isFalse,
          reason:
              'Narrowing Iterable<num> to List<int> should be non-breaking for return types (both base type and type parameter narrowing)',
        );
      });
    });

    group('return type widening (should be breaking)', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageWithNarrowReturns.analyze(),
          newApi: await packageWithWideReturns.analyze(),
        );
      });

      test(
          'detects non-nullable to nullable string return type change as breaking',
          () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('String -> String?') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isTrue,
          reason:
              'Widening String to String? should be breaking for return types',
        );
      });

      test('detects int to num return type change as breaking', () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('int -> num') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isTrue,
          reason: 'Widening int to num should be breaking for return types',
        );
      });

      test('detects List<int> to List<num> return type change as breaking', () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('List<int> -> List<num>') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isTrue,
          reason:
              'Widening List<int> to List<num> should be breaking for return types',
        );
      });

      test('detects subtype to supertype return type change as breaking', () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('SomeSubType -> SomeSuperType') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isTrue,
          reason:
              'Widening subtype to supertype should be breaking for return types',
        );
      });

      test('detects List<int> to Iterable<num> return type change as breaking',
          () {
        final returnTypeChange = diffResult.apiChanges
            .where((ac) =>
                ac.changeDescription.contains('List<int> -> Iterable<num>') &&
                ac.changeDescription.contains('Return type changed'))
            .single;
        expect(
          returnTypeChange.isBreaking,
          isTrue,
          reason:
              'Widening List<int> to Iterable<num> should be breaking for return types (both base type and type parameter widening)',
        );
      });
    });
  });
}
