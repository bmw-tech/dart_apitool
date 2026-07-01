import 'dart:io';
import 'package:dart_apitool/api_tool.dart';
import 'package:path/path.dart' as path;

import 'api_summary_package_api_adapter.dart';

/// this class analyzes the public package API of a given package ([packagePath])
class PackageApiAnalyzer {
  /// path to the package to analyze
  final String packagePath;
  final bool doAnalyzePlatformConstraints;
  final bool doConsiderNonSrcAsEntryPoints;

  /// the semantics of package API models this analyzer produces.
  /// this set defines what packages can be compared with each other and is the result of the combination of parameters this analyzer was constructed with.
  final semantics = <PackageApiSemantics>{};

  /// constructor
  /// [doAnalyzePlatformConstraints] defines if the platform constraints of the package shall be analyzed.
  /// [doConsiderNonSrcAsEntryPoints] defines if all files that are not in the lib/src subdirectory are considered as entry points. Otherwise only files directly in the lib subdirectory are considered as entry points.
  PackageApiAnalyzer({
    required this.packagePath,
    this.doAnalyzePlatformConstraints = true,
    this.doConsiderNonSrcAsEntryPoints = false,
  }) {
    if (doAnalyzePlatformConstraints) {
      semantics.add(PackageApiSemantics.containsPlatformConstraints);
    }
    _checkProjectPathValidity();
  }

  /// analyzes the configured package and returns a model of its public API
  Future<PackageApi> analyze() {
    return ApiSummaryPackageApiAdapter(
      packagePath: packagePath,
      doAnalyzePlatformConstraints: doAnalyzePlatformConstraints,
      doConsiderNonSrcAsEntryPoints: doConsiderNonSrcAsEntryPoints,
      semantics: semantics,
    ).analyze();
  }

  void _checkProjectPathValidity() {
    final normalizedPath = path.normalize(path.absolute(packagePath));
    if (!Directory(normalizedPath).existsSync()) {
      throw ArgumentError.value(
        packagePath,
        'packagePath',
        'The package path does not exist.',
      );
    }
    final pubspecFile = File(path.join(normalizedPath, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) {
      throw ArgumentError.value(
        packagePath,
        'packagePath',
        'The package path does not contain a pubspec.yaml.',
      );
    }
  }
}
