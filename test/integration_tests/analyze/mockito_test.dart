import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

void main() {
  group('mockito get analyzed correctly', () {
    late PackageApi packageApi;
    setUpAll(() async {
      final packageName = 'mockito';
      final packageVersion = '5.3.0';
      //download from pub
      final packageDirectory = await PubInteraction.installPackageToCache(
        packageName,
        packageVersion,
      );

      final analyzer = PackageApiAnalyzer(packagePath: packageDirectory);
      packageApi = await analyzer.analyze();
    });
    test('Root level field "any" is available', () {
      final anyField = packageApi.fieldDeclarations
          .singleWhere((element) => element.name == 'any');
      expect(anyField.name, 'any');
      expect(anyField.typeName, 'Null');
      expect(anyField.isDeprecated, isFalse);
    });
    test('Root level field "when" is available', () {
      final whenField = packageApi.fieldDeclarations
          .singleWhere((element) => element.name == 'when');
      expect(whenField.name, 'when');
      expect(whenField.typeName, contains('PostExpectation'));
      expect(whenField.isDeprecated, isFalse);
    });
    test('Root level field "verify" is available', () {
      final verifyField = packageApi.fieldDeclarations
          .singleWhere((element) => element.name == 'verify');
      expect(verifyField.name, 'verify');
      expect(verifyField.typeName, contains('Verification'));
      expect(verifyField.isDeprecated, isFalse);
    });
    test('Root level field "verifyNever" is available', () {
      final verifyNeverField = packageApi.fieldDeclarations
          .singleWhere((element) => element.name == 'verifyNever');
      expect(verifyNeverField.name, 'verifyNever');
      expect(verifyNeverField.typeName, contains('Verification'));
      expect(verifyNeverField.isDeprecated, isFalse);
    });
    test('Root level executable "resetMockitoState" is available', () {
      final resetMockitoStateExec = packageApi.executableDeclarations
          .singleWhere((element) => element.name == 'resetMockitoState');
      expect(resetMockitoStateExec.name, 'resetMockitoState');
      expect(resetMockitoStateExec.returnTypeName, 'void');
      expect(resetMockitoStateExec.isDeprecated, isFalse);
    });
  });
}
