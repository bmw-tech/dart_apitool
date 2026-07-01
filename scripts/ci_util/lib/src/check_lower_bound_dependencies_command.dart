import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;
import 'package:pool/pool.dart';
import 'package:pubspec_manager/pubspec_manager.dart';

class CheckLowerBoundDependenciesCommand extends Command {
  @override
  String get description =>
      'checks if the package can compile with only the lower bound constraints of its dependencies.';

  @override
  String get name => 'check-lower-bound-dependencies';

  @override
  Future run() async {
    // copy sources to temporary directory
    final String apiToolRootPath = _getApiToolRootPath();

    // get all dependencies
    final pubspec =
        PubSpec.loadFromPath(path.join(apiToolRootPath, 'pubspec.yaml'));

    final testExecutions = pubspec.dependencies.list
        .whereType<DependencyVersioned>()
        .map((d) async => () async {
              final dependencyName = (d as Dependency).name;
              stdout.writeln('Testing lower bound of $dependencyName');
              try {
                await _testWithFixedDependency(dependencyName);
              } catch (e) {
                return LowerBoundCheckResult(
                    dependencyName: dependencyName, error: e.toString());
              }
              return LowerBoundCheckResult(dependencyName: dependencyName);
            })
        .toList(growable: true);

    final numberOfParallelTasks = (Platform.numberOfProcessors / 2).ceil();

    final pool = Pool(numberOfParallelTasks);
    final failedDependencies = <LowerBoundCheckResult>[];

    try {
      final results = await Future.wait(
        testExecutions.map((run) => pool.withResource(() async {
              return (await run)();
            })),
      );

      failedDependencies.addAll(
        results.where((element) => element.error != null),
      );
    } finally {
      pool.close();
    }

    if (failedDependencies.isNotEmpty) {
      final errorMessage = StringBuffer();
      errorMessage.writeln(
          'Following dependencies failed when locked to their lower bound:');
      errorMessage
          .writeln(failedDependencies.map((e) => e.dependencyName).join('\n'));
      errorMessage.writeln();
      errorMessage.writeln('See error messages for details:');
      errorMessage.writeln(
          failedDependencies.map((e) => e.error!).join('\n-----------\n'));
      throw Exception(errorMessage.toString());
    }
  }

  Future _testWithFixedDependency(String dependencyName) async {
    final String apiToolRootPath = _getApiToolRootPath();
    final tempDir = await Directory.systemTemp.createTemp();
    try {
      stdout
          .writeln('[$dependencyName] Copying api tool to temporary directory');
      await _copyPath(apiToolRootPath, tempDir.path);
      stdout.writeln('[$dependencyName] Fixing dependency');
      await _fixDependency(
          path.join(tempDir.path, 'pubspec.yaml'), dependencyName);
      stdout.writeln('[$dependencyName] Running pub get');
      await _executePubGet(tempDir.path);
      stdout.writeln('[$dependencyName] Running build');
      await _executeBuild(tempDir.path);
    } finally {
      await tempDir.delete(recursive: true);
    }
  }

  String _getApiToolRootPath() {
    return path.normalize(
      path.join(
        path.dirname(path.absolute(Platform.script.path)),
        '..',
        '..',
        '..',
      ),
    );
  }

  Future _executePubGet(String path) async {
    await _executeDart(path, ['pub', 'get']);
  }

  Future _executeBuild(String path) async {
    await _executeDart(path, ['compile', 'exe', 'bin/main.dart']);
  }

  Future _executeDart(String path, List<String> arguments) async {
    // check if we are in a fvm environment
    final fvmPath = await Process.run('which', ['fvm']);
    String executable = 'fvm';
    List<String> additionalArguments = ['dart'];
    if (fvmPath.exitCode != 0) {
      print('fvm not found, using default dart.');
      executable = 'dart';
      additionalArguments = [];
    }
    final result = await Process.run(
      executable,
      [...additionalArguments, ...arguments],
      workingDirectory: path,
    );
    print(result.stdout);
    print(result.stderr);
    if (result.exitCode != 0) {
      throw Exception('Error executing dart: ${result.stderr}');
    }
  }

  Future _fixDependency(String pubspecPath, String dependencyName) async {
    // load pubspec yaml
    final pubspec = PubSpec.loadFromPath(pubspecPath);
    // adapt dependency
    bool adaptedOne = false;
    for (final dependency in pubspec.dependencies.list) {
      if (dependency.name == dependencyName &&
          dependency is DependencyVersioned) {
        final castedDependency = dependency as DependencyVersioned;
        castedDependency.versionConstraint =
            castedDependency.versionConstraint.replaceFirst('^', '');
        adaptedOne = true;
        stdout.writeln(
            '[$dependencyName] Fixing dependency to ${castedDependency.versionConstraint}');
      }
    }
    if (!adaptedOne) {
      throw Exception('Dependency $dependencyName not found in pubspec.yaml.');
    }
    // write pubspec yaml
    pubspec.saveTo(pubspecPath);
  }

  Future<void> _copyPath(String from, String to) async {
    if (_doNothing(from, to)) {
      return;
    }
    if (await Directory(to).exists()) {
      await Directory(to).delete();
    }
    await Directory(to).create(recursive: true);
    await for (final file in Directory(from).list(recursive: true)) {
      // ignore .git directory and its content
      if (path.split(file.path).contains('.git')) {
        continue;
      }
      final copyTo = path.join(to, path.relative(file.path, from: from));
      if (file is Directory) {
        await Directory(copyTo).create(recursive: true);
      } else if (file is File) {
        await File(file.path).copy(copyTo);
      } else if (file is Link) {
        await Link(copyTo).create(await file.target(), recursive: true);
      }
    }
  }

  bool _doNothing(String from, String to) {
    if (path.canonicalize(from) == path.canonicalize(to)) {
      return true;
    }
    if (path.isWithin(from, to)) {
      throw ArgumentError('Cannot copy from $from to $to');
    }
    return false;
  }
}

class LowerBoundCheckResult {
  final String dependencyName;
  final String? error;

  LowerBoundCheckResult({required this.dependencyName, this.error});
}
