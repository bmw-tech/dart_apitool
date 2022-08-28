import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

void main() {
  group('bloc get analyzed correctly', () {
    late PackageApi packageApi;
    setUpAll(() async {
      final packageName = 'bloc';
      final packageVersion = '8.1.0';
      //download from pub
      final packageDirectory = await PubInteraction.installPackageToCache(
        packageName,
        packageVersion,
      );

      final analyzer = PackageApiAnalyzer(packagePath: packageDirectory);
      packageApi = await analyzer.analyze();
    });
    test('Bloc class is available', () {
      final blocClass = packageApi.classDeclarations
          .singleWhere((element) => element.name == 'Bloc');

      expect(blocClass.name, 'Bloc');
      expect(blocClass.entryPoints, contains('bloc.dart'));
      final stateField = blocClass.fieldDeclarations
          .singleWhere((element) => element.name == 'state');
      expect(stateField.name, 'state');
      expect(stateField.typeName, 'State');
    });
    test('Transition class is available', () {
      final transitionClass = packageApi.classDeclarations
          .singleWhere((element) => element.name == 'Transition');

      expect(transitionClass.name, 'Transition');
      expect(transitionClass.entryPoints, contains('bloc.dart'));
      final eventField = transitionClass.fieldDeclarations
          .singleWhere((element) => element.name == 'event');
      expect(eventField.name, 'event');
      expect(eventField.typeName, 'Event');
    });
  });
}
