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
    final analyzer = PackageApiAnalyzer(
      packagePath: packageDirectory,
      doConsiderNonSrcAsEntryPoints: doConsiderNonSrcAsEntryPoints,
    );
    print('Analyzing $packageName $packageVersion');
    return await analyzer.analyze();
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
    final gitCloneResult =
        await Process.run('git', ['clone', gitUrl, tempDir.path]);
    if (gitCloneResult.exitCode != 0) {
      throw Exception('Unable to clone git repository $gitUrl');
    }
    final gitCheckoutResult = await Process.run('git', ['checkout', gitRef],
        workingDirectory: tempDir.path);
    if (gitCheckoutResult.exitCode != 0) {
      throw Exception('Unable to check out $gitRef of git repository $gitUrl');
    }

    String packagePath = tempDir.path;
    if (relativePackagePath != null) {
      packagePath = p.join(tempDir.path, relativePackagePath);
    }

    final analyzer = PackageApiAnalyzer(
      packagePath: packagePath,
      doConsiderNonSrcAsEntryPoints: doConsiderNonSrcAsEntryPoints,
    );
    print('Analyzing $gitUrl $gitRef');
    final result = await analyzer.analyze();
    await tempDir.delete(recursive: true);
    return result;
  }
}

expectPackageDependency(
    PackageApi packageApi, String packageName, String packageVersion) {
  final packageDependency =
      packageApi.packageDependencies.cast<PackageDependency?>().firstWhere(
            (element) => element != null && element.packageName == packageName,
            orElse: () => null,
          );
  expect(packageDependency, isNotNull,
      reason: 'Package dependency $packageName not found');
  expect(packageDependency!.packageVersion, packageVersion,
      reason: '$packageName doesn\'t have version $packageVersion');
}

const integrationTestTimeout = Timeout(Duration(minutes: 5));
