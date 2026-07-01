import 'dart:io';

import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;

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
