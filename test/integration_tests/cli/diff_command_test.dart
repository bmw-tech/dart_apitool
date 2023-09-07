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
      ]);
      expect(exitCode, 0);
    });
    test('diffing cloud_firestore 4.3.1 to 4.3.2 works', () async {
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
    });
  }, timeout: Timeout(Duration(minutes: 2)));
}
