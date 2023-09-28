import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_apitool/api_tool_cli.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

import '../helper/integration_test_helper.dart';

void main() {
  group('Extract command', () {
    late CommandRunner<int> runner;

    setUp(() {
      final extractCommand = ExtractCommand();
      runner = CommandRunner<int>('dart_apitool_tests', 'Test for dart_apitool')
        ..addCommand(extractCommand);
    });

    test(
      'Can handle complex path dependencies',
      () async {
        final exitCode = await runner.run([
          'extract',
          '--input',
          path.join(
            'test',
            'test_packages',
            'path_references',
            'cluster_a',
            'package_a',
          ),
        ]);
        expect(exitCode, 0);
      },
      timeout: integrationTestTimeout,
    );

    test(
      'packages with path dependencies don\'t yield unresolvable types',
      () async {
        final tempDir = await Directory.systemTemp.createTemp();
        final tempFilePath = path.join(tempDir.path, 'extract_paths_test.json');
        final exitCode = await runner.run([
          'extract',
          '--input',
          path.join(
            'test',
            'test_packages',
            'path_references',
            'cluster_a',
            'package_a',
          ),
          '--output',
          tempFilePath,
        ]);
        expect(exitCode, 0);

        final jsonReportFile = File(tempFilePath);
        expect(await jsonReportFile.exists(), isTrue);

        final jsonReport = jsonDecode(await jsonReportFile.readAsString());
        await tempDir.delete(recursive: true);

        // check if the ClassB field in ClassA has resolved its type
        final interfaceDeclarations =
            jsonReport['packageApi']['interfaceDeclarations'] as List;
        final classADeclaration =
            interfaceDeclarations.singleWhere((id) => id['name'] == 'ClassA');
        final classBField = (classADeclaration['fieldDeclarations'] as List)
            .singleWhere((fd) => fd['name'] == 'classB');
        expect(classBField['typeName'], 'ClassB');
      },
      timeout: integrationTestTimeout,
    );

    test(
      'local packages don\'t break own package refs',
      () async {
        final tempDir = await Directory.systemTemp.createTemp();
        final tempFilePath = path.join(tempDir.path, 'extract_paths_test.json');
        final exitCode = await runner.run([
          'extract',
          '--input',
          path.join(
            'test',
            'test_packages',
            'path_references',
            'cluster_a',
            'package_a',
          ),
          '--output',
          tempFilePath,
        ]);
        expect(exitCode, 0);

        final jsonReportFile = File(tempFilePath);
        expect(await jsonReportFile.exists(), isTrue);

        final jsonReport = jsonDecode(await jsonReportFile.readAsString());
        await tempDir.delete(recursive: true);

        // check if the thisIsAMixinField in ClassA was extracted
        final interfaceDeclarations =
            jsonReport['packageApi']['interfaceDeclarations'] as List;
        final classADeclaration =
            interfaceDeclarations.singleWhere((id) => id['name'] == 'ClassA');
        final thisIsAMixinFields =
            (classADeclaration['fieldDeclarations'] as List)
                .where((fd) => fd['name'] == 'thisIsAMixinField');
        expect(thisIsAMixinFields.length, 1);
      },
      timeout: integrationTestTimeout,
    );

    test(
      'Can handle pub ref',
      () async {
        final exitCode = await runner.run([
          'extract',
          '--input',
          'pub://dart_apitool/0.4.0',
        ]);
        expect(exitCode, 0);
      },
      timeout: integrationTestTimeout,
    );

    test(
      'Can handle nested path dependencies',
      () async {
        final exitCode = await runner.run([
          'extract',
          '--input',
          path.join(
            'test',
            'test_packages',
            'nested_path_references',
            'package_a',
          ),
        ]);
        expect(exitCode, 0);
      },
      timeout: integrationTestTimeout,
    );

    test(
      'Handles `set-exit-on-missing-export` well if an export is missing',
      () async {
        final exitCode = await runner.run([
          'extract',
          '--input',
          path.join(
            'test',
            'test_packages',
            'missing_export',
            'package_a',
          ),
          '--set-exit-on-missing-export',
        ]);
        expect(exitCode, -1);
      },
      timeout: integrationTestTimeout,
    );

    test(
      'Handles `set-exit-on-missing-export` well if nothing is missing',
      () async {
        final exitCode = await runner.run([
          'extract',
          '--input',
          path.join(
            'test',
            'test_packages',
            'nested_path_references',
            'package_a',
          ),
          '--set-exit-on-missing-export',
        ]);
        expect(exitCode, 0);
      },
      timeout: integrationTestTimeout,
    );

    test(
      'Handles `set-exit-on-missing-export` well if an export is missing',
      () async {
        final exitCode = await runner.run([
          'extract',
          '--input',
          path.join(
            'test',
            'test_packages',
            'missing_export',
            'package_a',
          ),
          '--set-exit-on-missing-export',
        ]);
        expect(exitCode, -1);
      },
      timeout: integrationTestTimeout,
    );
  });
}
