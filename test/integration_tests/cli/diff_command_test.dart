import 'package:args/command_runner.dart';
import 'package:dart_apitool/api_tool_cli.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('diff', () {
    test('diffing the same package works', () async {
      final diffCommand = DiffCommand();
      final packagePath = path.join(
        'test',
        'test_packages',
        'path_references',
        'cluster_a',
        'package_a',
      );
      final runner =
          CommandRunner<int>('dart_apitool_tests', 'Test for dart_apitool')
            ..addCommand(diffCommand);
      final exitCode = await runner.run([
        'diff',
        '--old',
        packagePath,
        '--new',
        packagePath,
        '--include-path-dependencies',
      ]);
      expect(exitCode, 0);
    });
    test('diffing grpc 3.2.2 to 3.2.3', () async {
      final diffCommand = DiffCommand();
      final runner =
          CommandRunner<int>('dart_apitool_tests', 'Test for dart_apitool')
            ..addCommand(diffCommand);
      final exitCode = await runner.run([
        'diff',
        '--old',
        'pub://grpc/3.2.2',
        '--new',
        'pub://grpc/3.2.3',
      ]);
      expect(exitCode, 0);
    });
  }, timeout: Timeout(Duration(minutes: 2)));
}
