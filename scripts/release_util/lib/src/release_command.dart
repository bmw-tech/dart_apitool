import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:path/path.dart' as path;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

class ReleaseCommand extends Command {
  @override
  String get description => 'Releases a new version of dart_apitool';

  @override
  String get name => 'release';

  ReleaseCommand() {
    argParser.addFlag(
      'prerelease',
      abbr: 'p',
      help: 'Whether this is a prerelease or not.',
      defaultsTo: false,
    );
  }

  @override
  Future run() async {
    final isPrerelease = argResults!['prerelease'] as bool;

    _checkIfEverythingIsCommited();
    _getPackageDependencies();
    _runAnalyzer();
    _runTests();
    _checkSemver();
    if (!isPrerelease) {
      _removePrereleaseFlagFromPubspec();
      _commit('Version ${_getCurrentVersion()}');
    }
    _createTag('releases/${_getCurrentVersion()}');
    await _publishAsync();
    _setNextPrereleaseVersion();
    _commit('Version ${_getCurrentVersion()}');
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

  String _getLastReleasedVersionFilePath() {
    return path.join(_getApiToolRootPath(), 'last_released_version.txt');
  }

  String _getLastReleasedVersion() {
    final lastReleasedVersionFilePath = _getLastReleasedVersionFilePath();
    if (!File(lastReleasedVersionFilePath).existsSync()) {
      print('Missing last_released_version.txt file.');
      exit(1);
    }
    return File(lastReleasedVersionFilePath).readAsLinesSync()[0];
  }

  String _getCurrentVersion() {
    final pubspecFilePath = path.join(_getApiToolRootPath(), 'pubspec.yaml');
    final pubspec = Pubspec.parse(File(pubspecFilePath).readAsStringSync());
    return pubspec.version.toString();
  }

  void _checkIfEverythingIsCommited() {
    print('checking if everything is commited');
    final apiToolRootPath = _getApiToolRootPath();
    final gitStatus = Process.runSync(
      'git',
      [
        'diff',
        '--quiet',
      ],
      workingDirectory: apiToolRootPath,
    );
    if (gitStatus.exitCode != 0) {
      print('Please commit all changes before releasing.');
      exit(1);
    }
  }

  void _getPackageDependencies() {
    print('running pub get');
    final apiToolRootPath = _getApiToolRootPath();
    final pubGetStatus = Process.runSync(
      'fvm',
      [
        'dart',
        'pub',
        'get',
      ],
      workingDirectory: apiToolRootPath,
    );
    if (pubGetStatus.exitCode != 0) {
      print('pub get failed:');
      print(pubGetStatus.stderr);
      print(pubGetStatus.stdout);
      exit(1);
    }
  }

  void _runAnalyzer() {
    print('running analyzer');
    final apiToolRootPath = _getApiToolRootPath();
    final analyzerStatus = Process.runSync(
      'fvm',
      [
        'dart',
        'analyze',
        '--fatal-warnings',
        '--fatal-infos',
      ],
      workingDirectory: apiToolRootPath,
    );
    if (analyzerStatus.exitCode != 0) {
      print('analyzer failed:');
      print(analyzerStatus.stderr);
      print(analyzerStatus.stdout);
      exit(1);
    }
  }

  void _runTests() {
    print('running tests');
    final apiToolRootPath = _getApiToolRootPath();
    final testStatus = Process.runSync(
      'fvm',
      [
        'dart',
        'test',
      ],
      workingDirectory: apiToolRootPath,
    );
    if (testStatus.exitCode != 0) {
      print('tests failed:');
      print(testStatus.stderr);
      print(testStatus.stdout);
      exit(1);
    }
  }

  void _checkSemver() {
    print('checking semver');
    final apiToolRootPath = _getApiToolRootPath();
    final lastReleaseVersion = _getLastReleasedVersion();
    final semverStatus = Process.runSync(
      'fvm',
      [
        'dart',
        'bin/main.dart',
        'diff',
        '--old',
        'pub://dart_apitool/$lastReleaseVersion',
        '--new',
        '.',
      ],
      workingDirectory: apiToolRootPath,
    );
    if (semverStatus.exitCode != 0) {
      print('semver check failed:');
      print(semverStatus.stderr);
      print(semverStatus.stdout);
      exit(1);
    }
  }

  void _removePrereleaseFlagFromPubspec() {
    final String pubspecPath = path.join(_getApiToolRootPath(), 'pubspec.yaml');
    final pubspecContent = File(pubspecPath).readAsStringSync();

    final pubspec = Pubspec.parse(pubspecContent);
    final currentVersion = pubspec.version!;

    if (currentVersion.preRelease.isEmpty) {
      return;
    }

    final currentVersionString = currentVersion.canonicalizedVersion;

    final newVersion = Version(
        currentVersion.major, currentVersion.minor, currentVersion.patch);
    final newVersionString = newVersion.canonicalizedVersion;

    final newPubspecContent = pubspecContent.replaceAll(
      'version: $currentVersionString',
      'version: $newVersionString',
    );

    File(pubspecPath).writeAsStringSync(newPubspecContent);
  }

  void _commit(String message) {
    print('commiting: $message');
    final apiToolRootPath = _getApiToolRootPath();
    final commitStatus = Process.runSync(
      'git',
      [
        'commit',
        '-am',
        message,
      ],
      workingDirectory: apiToolRootPath,
    );
    if (commitStatus.exitCode != 0) {
      print('commit failed:');
      print(commitStatus.stderr);
      print(commitStatus.stdout);
      exit(1);
    }
  }

  void _createTag(String tag) {
    print('creating tag: $tag');
    final apiToolRootPath = _getApiToolRootPath();
    final tagStatus = Process.runSync(
      'git',
      [
        'tag',
        tag,
      ],
      workingDirectory: apiToolRootPath,
    );
    if (tagStatus.exitCode != 0) {
      print('creating tag failed:');
      print(tagStatus.stderr);
      print(tagStatus.stdout);
      exit(1);
    }
  }

  Future _publishAsync() async {
    print('publishing');
    final apiToolRootPath = _getApiToolRootPath();
    final pubProcess = await Process.start(
      'fvm',
      [
        'dart',
        'pub',
        'publish',
        '--dry-run',
      ],
      workingDirectory: apiToolRootPath,
    );
    pubProcess.stdout.transform(utf8.decoder).forEach(print);
    pubProcess.stderr.transform(utf8.decoder).forEach(print);
    final subscription = stdin.listen(pubProcess.stdin.add);
    final pubExitCode = await pubProcess.exitCode;
    subscription.cancel();
    if (pubExitCode != 0) {
      print('publish failed!');
      exit(1);
    }
  }

  void _setNextPrereleaseVersion() {
    final apiToolRootPath = _getApiToolRootPath();
    final pubspecPath = path.join(apiToolRootPath, 'pubspec.yaml');
    final pubspecContent = File(pubspecPath).readAsStringSync();
    final pubspec = Pubspec.parse(pubspecContent);
    final currentVersion = pubspec.version!;
    final newVersion = currentVersion.nextPatch;
    final currentVersionString = pubspec.version!.canonicalizedVersion;
    final newVersionString = '${newVersion.canonicalizedVersion}-dev';
    final newPubspecContent = pubspecContent.replaceAll(
      'version: $currentVersionString',
      'version: $newVersionString',
    );
    File(pubspecPath).writeAsStringSync(newPubspecContent);
  }
}
