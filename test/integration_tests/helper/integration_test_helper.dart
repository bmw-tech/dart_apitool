import 'package:dart_apitool/api_tool.dart';

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
