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
  void run() {
    //final isPrerelease = argResults!['prerelease'] as bool;

    _checkIfEverythingIsCommited();
    _getPackageDependencies();
    _runAnalyzer();
    _runTests();
    _checkSemver();
    _removePrereleaseFlagFromPubspec();
    // _commit();
    // _createTag();
    // _publish();
    // _setNextPrereleaseVersion();
    // _commit();
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
    final lastReleasedVersionFilePath = _getLastReleasedVersionFilePath();
    if (!File(lastReleasedVersionFilePath).existsSync()) {
      print('Missing last_released_version.txt file.');
      exit(1);
    }
    final lastReleaseVersion =
        File(lastReleasedVersionFilePath).readAsLinesSync()[0];
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
}
