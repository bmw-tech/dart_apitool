import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_apitool/api_tool_cli.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

import '../../helper/integration_test_helper.dart';

/// Tests for testing the package preparation
/// Especially that the new approach of using a temporary package as an intermediary
void main() {
  group('Package Preparation', () {
    late CommandRunner<int> runner;

    setUp(() {
      final extractCommand = ExtractCommand();
      runner = CommandRunner<int>('dart_apitool_tests', 'Test for dart_apitool')
        ..addCommand(extractCommand);
    });

    Future<Map<String, dynamic>> getExtractResultJson(
        String packageName, String version) async {
      final tempDir = Directory.systemTemp.createTempSync();
      final jsonReportFile = File(p.join(tempDir.path, 'report.json'));
      final exitCode = await runner.run([
        'extract',
        '--input',
        'pub://$packageName/$version',
        '--output',
        jsonReportFile.path,
      ]);
      expect(exitCode, 0);
      final result = jsonDecode(await jsonReportFile.readAsString());
      await tempDir.delete(recursive: true);
      return result;
    }

    test(
      'Analyzes sentry 5.1.0 correctly',
      () async {
        final result = await getExtractResultJson('sentry', '5.1.0');
        final interfaceDeclarations =
            result['packageApi']['interfaceDeclarations'] as List;
        final sentryAssetBundleDeclaration =
            interfaceDeclarations.singleWhere((id) => id['name'] == 'Scope');
        final clearMethod =
            (sentryAssetBundleDeclaration['executableDeclarations'] as List)
                .singleWhere((ex) => ex['name'] == 'clear');
        expect(clearMethod['returnTypeName'], 'void');
      },
      timeout: integrationTestTimeout,
    );

    test(
      'Analyzes cloud_firestore 4.3.1 correctly',
      () async {
        final result = await getExtractResultJson('cloud_firestore', '4.3.1');
        final interfaceDeclarations =
            result['packageApi']['interfaceDeclarations'] as List;
        final collectionReferenceDeclaration = interfaceDeclarations
            .singleWhere((id) => id['name'] == 'CollectionReference');
        final addMethod =
            (collectionReferenceDeclaration['executableDeclarations'] as List)
                .singleWhere((ex) => ex['name'] == 'add');
        expect(addMethod['returnTypeName'], 'Future<DocumentReference<T>>');
      },
      timeout: integrationTestTimeout,
    );

    test(
      'Analyzes device_info_plus_platform_interface 2.2.0 correctly',
      () async {
        final result = await getExtractResultJson(
            'device_info_plus_platform_interface', '2.2.0');
        final interfaceDeclarations =
            result['packageApi']['interfaceDeclarations'] as List;
        final deviceInfoPlatformDeclaration = interfaceDeclarations
            .singleWhere((id) => id['name'] == 'DeviceInfoPlatform');
        final androidInfoMethod =
            (deviceInfoPlatformDeclaration['executableDeclarations'] as List)
                .singleWhere((ex) => ex['name'] == 'androidInfo');
        expect(
            androidInfoMethod['returnTypeName'], 'Future<AndroidDeviceInfo>');
      },
      timeout: integrationTestTimeout,
    );

    test(
      'Analyzes http2 2.3.0 correctly',
      () async {
        final result = await getExtractResultJson('http2', '2.3.0');
        final interfaceDeclarations =
            result['packageApi']['interfaceDeclarations'] as List;
        final clientSettingsDeclaration = interfaceDeclarations
            .singleWhere((id) => id['name'] == 'ClientSettings');
        final allowServerPushesField =
            (clientSettingsDeclaration['fieldDeclarations'] as List)
                .singleWhere((fd) => fd['name'] == 'allowServerPushes');
        expect(allowServerPushesField['typeName'], 'bool');
      },
      timeout: integrationTestTimeout,
    );

    test(
      'Analyzes sqflite_common 2.3.0 correctly',
      () async {
        final result = await getExtractResultJson('sqflite_common', '2.3.0');
        final interfaceDeclarations =
            result['packageApi']['interfaceDeclarations'] as List;
        final databaseFactoryDeclaration = interfaceDeclarations
            .singleWhere((id) => id['name'] == 'DatabaseFactory');
        final openDatabaseMethod =
            (databaseFactoryDeclaration['executableDeclarations'] as List)
                .singleWhere((ex) => ex['name'] == 'openDatabase');
        expect(openDatabaseMethod['returnTypeName'], 'Future<Database>');
      },
      timeout: integrationTestTimeout,
    );
  });
}
