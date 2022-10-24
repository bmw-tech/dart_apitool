import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('bloc get analyzed correctly', () {
    final packageName = 'bloc';
    final packageVersion = '8.1.0';
    final retriever = PackageApiRetriever(packageName, packageVersion);
    late PackageApi packageApi;

    setUpAll(() async {
      packageApi = await retriever.retrieve();
    });

    test('Bloc class is available', () {
      final blocClass = packageApi.interfaceDeclarations
          .singleWhere((element) => element.name == 'Bloc');

      expect(blocClass.name, 'Bloc');
      expect(blocClass.entryPoints, contains('bloc.dart'));
      final stateField = blocClass.fieldDeclarations
          .singleWhere((element) => element.name == 'state');
      expect(stateField.name, 'state');
      expect(stateField.typeName, 'State');
    });
    test('Transition class is available', () {
      final transitionClass = packageApi.interfaceDeclarations
          .singleWhere((element) => element.name == 'Transition');

      expect(transitionClass.name, 'Transition');
      expect(transitionClass.entryPoints, contains('bloc.dart'));
      final eventField = transitionClass.fieldDeclarations
          .singleWhere((element) => element.name == 'event');
      expect(eventField.name, 'event');
      expect(eventField.typeName, 'Event');
    });
    test('EventHandler typedef is available', () {
      final eventHandlerTypedef = packageApi.typeAliasDeclarations
          .singleWhere((element) => element.name == 'EventHandler');

      expect(eventHandlerTypedef.name, 'EventHandler');
      expect(eventHandlerTypedef.aliasedTypeName,
          'FutureOr<void> Function(Event, Emitter<State>)');
    });
  });
}
