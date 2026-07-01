import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('mockito gets analyzed correctly', () {
    late PackageApi packageApi;
    final packageName = 'mockito';
    final packageVersion = '5.3.0';
    final retriever = PackageApiRetriever(packageName, packageVersion);

    setUpAll(() async {
      packageApi = await retriever.retrieve();
    });

    test('Root level field "any" is available', () {
      final anyField = packageApi.fieldDeclarations
          .singleWhere((element) => element.name == 'any');
      expect(anyField.name, 'any');
      expect(anyField.typeName, 'Null');
      expect(anyField.isDeprecated, isFalse);
      expect(anyField.entryPoints!, contains('mockito.dart'));
    });
    test('Root level field "when" is available', () {
      final whenField = packageApi.fieldDeclarations
          .singleWhere((element) => element.name == 'when');
      expect(whenField.name, 'when');
      expect(whenField.typeName, contains('PostExpectation'));
      expect(whenField.isDeprecated, isFalse);
      expect(whenField.entryPoints!, contains('mockito.dart'));
    });
    test('Root level field "verify" is available', () {
      final verifyField = packageApi.fieldDeclarations
          .singleWhere((element) => element.name == 'verify');
      expect(verifyField.name, 'verify');
      expect(verifyField.typeName, contains('Verification'));
      expect(verifyField.isDeprecated, isFalse);
      expect(verifyField.entryPoints!, contains('mockito.dart'));
    });
    test('Root level field "verifyNever" is available', () {
      final verifyNeverField = packageApi.fieldDeclarations
          .singleWhere((element) => element.name == 'verifyNever');
      expect(verifyNeverField.name, 'verifyNever');
      expect(verifyNeverField.typeName, contains('Verification'));
      expect(verifyNeverField.isDeprecated, isFalse);
      expect(verifyNeverField.entryPoints!, contains('mockito.dart'));
    });
    test('Root level executable "resetMockitoState" is available', () {
      final resetMockitoStateExec = packageApi.executableDeclarations
          .singleWhere((element) => element.name == 'resetMockitoState');
      expect(resetMockitoStateExec.name, 'resetMockitoState');
      expect(resetMockitoStateExec.returnTypeName, 'void');
      expect(resetMockitoStateExec.isDeprecated, isFalse);
      expect(resetMockitoStateExec.entryPoints!, contains('mockito.dart'));
    });
  });
}
