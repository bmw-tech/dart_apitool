import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('analyzer gets analyzed correctly', () {
    final packageName = 'analyzer';
    final packageVersion = '5.2.0';
    final retriever = PackageApiRetriever(packageName, packageVersion,
        doConsiderNonSrcAsEntryPoints: true);
    late PackageApi packageApi;

    setUpAll(() async {
      packageApi = await retriever.retrieve();
    });

    test('MixinAugmentationElement is detected as experimental', () {
      final mixinAugmentationElement = packageApi.interfaceDeclarations
          .singleWhere((element) => element.name == 'MixinAugmentationElement');

      expect(mixinAugmentationElement.name, 'MixinAugmentationElement');
      expect(mixinAugmentationElement.isExperimental, isTrue);
    });
  });
}
