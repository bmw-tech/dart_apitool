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
          '--include-path-dependencies',
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
  });
}
