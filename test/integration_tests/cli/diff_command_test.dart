import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_apitool/api_tool_cli.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

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

    test(
      'diffing cloud_firestore 4.3.1 to 4.3.2 and producing a json report works',
      () async {
        final tempDir = await Directory.systemTemp.createTemp();
        final reportFilePath = path.join(tempDir.path, 'json_report.json');
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
          'json',
          '--report-file-path',
          reportFilePath
        ]);
        expect(exitCode, 0);
        expect(File(reportFilePath).existsSync(), isTrue);

        final jsonContent = File(reportFilePath).readAsStringSync();
        tempDir.deleteSync(recursive: true);

        // just some random probes
        final parsedJson = jsonDecode(jsonContent);
        expect(parsedJson, isNotNull);
        expect(parsedJson['apiToolInfo'], isNotNull);
        expect(parsedJson['reportName'], isNotNull);
        expect(parsedJson['report'], isNotNull);
      },
      timeout: integrationTestTimeout,
    );

    test(
      'diffing cloud_firestore 4.3.1 to latest works',
      () async {
        // just some random package for testing the diff command for pub refs without version
        final diffCommand = DiffCommand();
        final runner =
            CommandRunner<int>('dart_apitool_tests', 'Test for dart_apitool')
              ..addCommand(diffCommand);
        final exitCode = await runner.run([
          'diff',
          '--old',
          'pub://cloud_firestore/4.3.1',
          '--new',
          'pub://cloud_firestore',
        ]);
        expect(exitCode, 0);
      },
      timeout: integrationTestTimeout,
    );

    test(
      'diffing protobuf 4916e6f7d34443869c27d997749d4362870fd7ce to protobuf 7f7d776a1812594b0d2b56bac41439f50006e225 works',
      () async {
        // just some random package that we know the git refs of
        final diffCommand = DiffCommand();
        final runner =
            CommandRunner<int>('dart_apitool_tests', 'Test for dart_apitool')
              ..addCommand(diffCommand);
        final exitCode = await runner.run([
          'diff',
          '--old',
          'git://https://github.com/google/protobuf.dart.git/protobuf:4916e6f7d34443869c27d997749d4362870fd7ce',
          '--new',
          'git://https://github.com/google/protobuf.dart.git/protobuf:7f7d776a1812594b0d2b56bac41439f50006e225',
        ]);
        expect(exitCode, 0);
      },
      timeout: integrationTestTimeout,
    );
  });
}
