import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

class PackageApiRetriever {
  final String packageName;
  final String packageVersion;

  PackageApiRetriever(this.packageName, this.packageVersion);

  Future<PackageApi> retrieve() async {
    print('Downloading $packageName $packageVersion');
    final packageDirectory = await PubInteraction.installPackageToCache(
      packageName,
      packageVersion,
    );
    final analyzer = PackageApiAnalyzer(packagePath: packageDirectory);
    print('Analyzing $packageName $packageVersion');
    return await analyzer.analyze();
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
