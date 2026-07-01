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

    test('BluetoothCharacteristic exists two times', () {
      final bluetoothCharacteristicClasses = packageApi.interfaceDeclarations
          .where((element) => element.name.endsWith('BluetoothCharacteristic'))
          .toList();

      expect(bluetoothCharacteristicClasses.length, 2);

      expect(
        bluetoothCharacteristicClasses.where(
          (element) => element.name == 'BluetoothCharacteristic',
        ),
        hasLength(2),
      );
    });

    test('ScanResult exists two times', () {
      final scanResultClasses = packageApi.interfaceDeclarations
          .where((element) => element.name.endsWith('ScanResult'))
          .toList();

      expect(scanResultClasses.length, 2);

      expect(
        scanResultClasses.where((element) => element.name == 'ScanResult'),
        hasLength(2),
      );
    });

    test('Contains dependencies', () {
      expect(packageApi.packageDependencies.length, 3);
      expectPackageDependency(packageApi, 'convert', '^2.1.1');
      expectPackageDependency(packageApi, 'protobuf', '^0.14.1');
      expectPackageDependency(packageApi, 'rxdart', '^0.22.0');
    });
  });
}
