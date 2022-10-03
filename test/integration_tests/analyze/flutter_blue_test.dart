import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('flutter_blue get analyzed correctly', () {
    final packageName = 'flutter_blue';
    final packageVersion = '0.6.1';
    final retriever = PackageApiRetriever(packageName, packageVersion);
    late PackageApi packageApi;

    setUpAll(() async {
      packageApi = await retriever.retrieve();
    });

    test('BluetoothCharacteristic exists two times in different namespaces',
        () {
      final bluetoothCharacteristicClasses = packageApi.classDeclarations
          .where((element) => element.name.endsWith('BluetoothCharacteristic'))
          .toList();

      expect(bluetoothCharacteristicClasses.length, 2);

      final bluetoothCharacteristicMainClasses = packageApi.classDeclarations
          .where((element) => element.name == 'BluetoothCharacteristic')
          .toList();
      expect(bluetoothCharacteristicMainClasses.length, 1);
      final bluetoothCharacteristicProtoClasses = packageApi.classDeclarations
          .where((element) => element.name == 'protos.BluetoothCharacteristic')
          .toList();
      expect(bluetoothCharacteristicProtoClasses.length, 1);
    });
  });
}
