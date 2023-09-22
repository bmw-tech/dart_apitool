import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_apitool/api_tool_cli.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

import '../helper/integration_test_helper.dart';

void main() {
  group('diff command', () {
    late CommandRunner<int> runner;

    setUp(() {
      final diffCommand = DiffCommand();
      runner = CommandRunner<int>('dart_apitool_tests', 'Test for dart_apitool')
        ..addCommand(diffCommand);
    });

    test(
      'diffing the same package works',
      () async {
        final packagePath = path.join(
          'test',
          'test_packages',
          'path_references',
          'cluster_a',
          'package_a',
        );
        final exitCode = await runner.run([
          'diff',
          '--old',
          packagePath,
          '--new',
          packagePath,
        ]);
        expect(exitCode, 0);
      },
      timeout: integrationTestTimeout,
    );
    test(
      'diffing grpc 3.2.2 to 3.2.3',
      () async {
        final exitCode = await runner.run([
          'diff',
          '--old',
          'pub://grpc/3.2.2',
          '--new',
          'pub://grpc/3.2.3',
        ]);
        expect(exitCode, 0);
      },
      timeout: integrationTestTimeout,
    );
    test(
      'diffing cloud_firestore 4.3.1 to 4.3.2 works',
      () async {
        // just some random package for testing the diff command for pub refs
        final diffCommand = DiffCommand();
        final runner =
            CommandRunner<int>('dart_apitool_tests', 'Test for dart_apitool')
              ..addCommand(diffCommand);
        final exitCode = await runner.run([
          'diff',
          '--old',
          'pub://cloud_firestore/4.3.1',
          '--new',
          'pub://cloud_firestore/4.3.2',
        ]);
        expect(exitCode, 0);
      },
      timeout: integrationTestTimeout,
    );

    test(
      'diffing cloud_firestore 4.3.1 to 4.3.2 and producing a markdown report works',
      () async {
        final tempDir = await Directory.systemTemp.createTemp();
        final reportFilePath = path.join(tempDir.path, 'markdown_report.md');
        // just some random package for testing the diff command for pub refs
        final diffCommand = DiffCommand();
        final runner =
            CommandRunner<int>('dart_apitool_tests', 'Test for dart_apitool')
              ..addCommand(diffCommand);
        final exitCode = await runner.run([
          'diff',
          '--old',
          'pub://cloud_firestore/4.3.1',
          '--new',
          'pub://cloud_firestore/4.3.2',
          '--report-format',
          'markdown',
          '--report-file-path',
          reportFilePath
        ]);
        expect(exitCode, 0);
        expect(File(reportFilePath).existsSync(), isTrue);

        final markdownContent = File(reportFilePath).readAsStringSync();
        tempDir.deleteSync(recursive: true);

        // just some random probes
        expect(markdownContent, contains('No breaking changes!'));
        expect(markdownContent, contains('readme/change_codes.md'));
      },
      timeout: integrationTestTimeout,
    );
  });
}
