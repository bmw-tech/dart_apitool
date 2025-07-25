import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('test_package_operators', () {
    late PackageApiAnalyzer packageAWithRecord;
    late PackageApiAnalyzer packageAWithChangedRecord;

    setUpAll(
      () {
        packageAWithRecord = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'operators',
          'package_a_with_operators',
        ));
        // we test the same package against itself.
        // We just want to know if the differ can handle two operators with the same name
        packageAWithChangedRecord = PackageApiAnalyzer(
            packagePath: path.join(
          'test',
          'test_packages',
          'operators',
          'package_a_with_operators',
        ));
      },
    );
    group('having the - operator two times (unary and not)', () {
      late PackageApiDiffResult diffResult;
      setUpAll(() async {
        diffResult = PackageApiDiffer().diff(
          oldApi: await packageAWithRecord.analyze(),
          newApi: await packageAWithChangedRecord.analyze(),
        );
      });

      test('does not crash', () {
        expect(
          diffResult.apiChanges,
          isEmpty,
        );
      });
    });

    group('reproducing GitHub issue #225', () {
      test('unary operator name should not show "unary" twice', () async {
        // Create a simple test case to check the operator naming
        final api = await packageAWithRecord.analyze();

        // Find the ClassA interface
        final classAInterface = api.interfaceDeclarations
            .firstWhere((interface) => interface.name == 'ClassA');

        // Look for minus operators (binary and unary)
        final minusOperators = classAInterface.executableDeclarations
            .where((method) => method.name.contains('-'))
            .toList();

        // Should have both binary and unary minus operators
        expect(minusOperators.length, equals(2));

        // Find the specific operators
        final binaryMinusOperator =
            minusOperators.firstWhere((op) => op.name == 'binary-');
        final unaryMinusOperator =
            minusOperators.firstWhere((op) => op.name == 'unary-');

        // Verify the names are correct (not duplicated)
        expect(binaryMinusOperator.name, equals('binary-'));
        expect(unaryMinusOperator.name, equals('unary-'));

        // Check if any of them has duplicated text
        for (final op in minusOperators) {
          expect(op.name, isNot(contains('unaryunary')));
          expect(op.name, isNot(contains('binarybinary')));
        }
      });
    });
  });
}
