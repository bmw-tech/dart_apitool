import 'dart:io';

import 'package:dart_apitool/api_tool.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:test/test.dart';
import 'package:yaml_edit/yaml_edit.dart';
import 'package:path/path.dart' as p;

final _preparedPackageApis = <String, Future<PackageApi>>{};

extension PreparedPackageApiAnalyzer on PackageApiAnalyzer {
  Future<PackageApi> analyzePrepared() async {
    final normalizedPackagePath = p.normalize(p.absolute(packagePath));
    final cacheKey = [
      normalizedPackagePath,
      doAnalyzePlatformConstraints,
      doConsiderNonSrcAsEntryPoints,
    ].join('|');
    return _preparedPackageApis.putIfAbsent(cacheKey, () async {
      await _preparePackagePath(normalizedPackagePath);
      return analyze();
    });
  }
}

Future<void> _preparePackagePath(String packagePath) async {
  final dartToolDirectory = Directory(p.join(packagePath, '.dart_tool'));
  await dartToolDirectory.create(recursive: true);
  final lockFile = await File(
    p.join(dartToolDirectory.path, 'package_config.lock'),
  ).open(mode: FileMode.write);

  try {
    await lockFile.lock();
    final packageConfigFile = File(
      p.join(dartToolDirectory.path, 'package_config.json'),
    );
    if (!await packageConfigFile.exists()) {
      await _runFixturePubGet(packagePath);
    }
  } finally {
    await lockFile.unlock();
    await lockFile.close();
  }
}

Future<void> _runFixturePubGet(String packagePath) async {
  final pubspecFile = File(p.join(packagePath, 'pubspec.yaml'));
  final originalPubspecContent = await pubspecFile.readAsString();
  final pubspec = Pubspec.parse(originalPubspecContent);
  final compatiblePubspecContent = _pubGetCompatiblePubspec(
    originalPubspecContent,
    pubspec,
    relaxHostedDependencies: false,
  );
  final fallbackPubspecContent = _pubGetCompatiblePubspec(
    originalPubspecContent,
    pubspec,
    relaxHostedDependencies: true,
  );

  try {
    await _writeAndRunFixturePubGet(
      pubspecFile,
      compatiblePubspecContent,
      packagePath,
    );
  } catch (_) {
    if (fallbackPubspecContent == compatiblePubspecContent) {
      rethrow;
    }
    await _writeAndRunFixturePubGet(
      pubspecFile,
      fallbackPubspecContent,
      packagePath,
    );
  } finally {
    await pubspecFile.writeAsString(originalPubspecContent);
  }
}

Future<void> _writeAndRunFixturePubGet(
  File pubspecFile,
  String pubspecContent,
  String packagePath,
) async {
  await pubspecFile.writeAsString(pubspecContent);
  await PubInteraction.runPubGet(packagePath, stdoutSession: StdoutSession());
}

String _pubGetCompatiblePubspec(
  String pubspecContent,
  Pubspec pubspec, {
  required bool relaxHostedDependencies,
}) {
  final editor = YamlEditor(pubspecContent);
  var changed = false;
  final sdkConstraint = pubspec.environment['sdk'];
  final currentSdkVersion = Version.parse(Platform.version.split(' ').first);
  if (sdkConstraint != null && !sdkConstraint.allows(currentSdkVersion)) {
    editor.update([
      'environment',
      'sdk',
    ], _compatibleSdkConstraint(sdkConstraint));
    changed = true;
  }

  if (relaxHostedDependencies) {
    for (final section in ['dependencies', 'dev_dependencies']) {
      final dependencies = section == 'dependencies'
          ? pubspec.dependencies
          : pubspec.devDependencies;
      for (final entry in dependencies.entries) {
        if (entry.value is HostedDependency) {
          editor.update([section, entry.key], 'any');
          changed = true;
        }
      }
    }
  }

  return changed ? editor.toString() : pubspecContent;
}

String _compatibleSdkConstraint(VersionConstraint sdkConstraint) {
  if (sdkConstraint is VersionRange && sdkConstraint.min != null) {
    return '>=${sdkConstraint.min} <4.0.0';
  }
  return '>=2.12.0 <4.0.0';
}

class PackageApiRetriever {
  final String packageName;
  final String packageVersion;
  final bool doConsiderNonSrcAsEntryPoints;

  PackageApiRetriever(
    this.packageName,
    this.packageVersion, {
    this.doConsiderNonSrcAsEntryPoints = false,
  });

  Future<PackageApi> retrieve() async {
    print('Downloading $packageName $packageVersion');
    final packageDirectory = await PubInteraction.installPackageToCache(
      packageName,
      packageVersion,
    );
    final tempDir = await Directory.systemTemp.createTemp();
    try {
      await _copyDirectory(packageDirectory, tempDir.path);
      final pubspecOverrides = File(
        p.join(tempDir.path, 'pubspec_overrides.yaml'),
      );
      if (await pubspecOverrides.exists()) {
        await pubspecOverrides.delete();
      }
      await PubInteraction.runPubGetIndirectly(
        tempDir.path,
        stdoutSession: StdoutSession(),
      );
      final analyzer = PackageApiAnalyzer(
        packagePath: tempDir.path,
        doConsiderNonSrcAsEntryPoints: doConsiderNonSrcAsEntryPoints,
      );
      print('Analyzing $packageName $packageVersion');
      return await analyzer.analyze();
    } finally {
      await tempDir.delete(recursive: true);
    }
  }
}

class GitPackageApiRetriever {
  final String gitUrl;
  final String gitRef;
  final String? relativePackagePath;
  final bool doConsiderNonSrcAsEntryPoints;

  GitPackageApiRetriever(
    this.gitUrl,
    this.gitRef, {
    this.relativePackagePath,
    this.doConsiderNonSrcAsEntryPoints = false,
  });

  Future<PackageApi> retrieve() async {
    print('Downloading $gitUrl $gitRef');
    //create temp directory
    final tempDir = await Directory.systemTemp.createTemp();
    final gitCloneResult = await Process.run('git', [
      'clone',
      gitUrl,
      tempDir.path,
    ]);
    if (gitCloneResult.exitCode != 0) {
      throw Exception('Unable to clone git repository $gitUrl');
    }
    final gitCheckoutResult = await Process.run('git', [
      'checkout',
      gitRef,
    ], workingDirectory: tempDir.path);
    if (gitCheckoutResult.exitCode != 0) {
      throw Exception('Unable to check out $gitRef of git repository $gitUrl');
    }

    String packagePath = tempDir.path;
    if (relativePackagePath != null) {
      packagePath = p.join(tempDir.path, relativePackagePath);
    }

    await DartInteraction.runDartOrFlutterCommand(
      packagePath,
      args: ['pub', 'get'],
    );

    final analyzer = PackageApiAnalyzer(
      packagePath: packagePath,
      doConsiderNonSrcAsEntryPoints: doConsiderNonSrcAsEntryPoints,
    );
    final logSuffix = (relativePackagePath != null)
        ? ' at $relativePackagePath'
        : '';
    print('Analyzing $gitUrl $gitRef$logSuffix');
    final result = await analyzer.analyze();
    await tempDir.delete(recursive: true);
    return result;
  }
}

expectPackageDependency(
  PackageApi packageApi,
  String packageName,
  String packageVersion,
) {
  final packageDependency = packageApi.packageDependencies
      .cast<PackageDependency?>()
      .firstWhere(
        (element) => element != null && element.packageName == packageName,
        orElse: () => null,
      );
  expect(
    packageDependency,
    isNotNull,
    reason: 'Package dependency $packageName not found',
  );
  expect(
    packageDependency!.packageVersion,
    packageVersion,
    reason: '$packageName doesn\'t have version $packageVersion',
  );
}

const integrationTestTimeout = Timeout(Duration(minutes: 5));

Future<void> _copyDirectory(String from, String to) async {
  await Directory(to).create(recursive: true);
  await for (final entity in Directory(from).list(recursive: true)) {
    final destination = p.join(to, p.relative(entity.path, from: from));
    if (entity is Directory) {
      await Directory(destination).create(recursive: true);
    } else if (entity is File) {
      await File(entity.path).copy(destination);
    } else if (entity is Link) {
      await Link(destination).create(await entity.target(), recursive: true);
    }
  }
}
