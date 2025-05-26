import 'dart:io';

import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

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
      analyzerRootPath: packageDirectory,
      doConsiderNonSrcAsEntryPoints: doConsiderNonSrcAsEntryPoints,
    );
    print('Analyzing $packageName $packageVersion');
    return await analyzer.analyze();
  }
}

class GitPackageApiRetriever {
  final String gitUrl;
  final String gitRef;
  final bool doConsiderNonSrcAsEntryPoints;

  GitPackageApiRetriever(
    this.gitUrl,
    this.gitRef, {
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

    final analyzer = PackageApiAnalyzer(
      packagePath: tempDir.path,
      analyzerRootPath: tempDir.path,
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
