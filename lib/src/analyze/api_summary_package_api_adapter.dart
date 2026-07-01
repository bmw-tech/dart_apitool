import 'dart:io';

import 'package:api_summary/api_summary.dart' as api_summary;
import 'package:dart_apitool/api_tool.dart';
import 'package:path/path.dart' as path;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

import 'constraints/android_platform_constraints_helper.dart';
import 'constraints/ios_platform_contraints_helper.dart';
import 'dependencies/package_dependencies_helper.dart';

part 'api_summary_package_api_adapter/api_summary_configuration.dart';
part 'api_summary_package_api_adapter/model_adapter.dart';
part 'api_summary_package_api_adapter/model_support.dart';
part 'api_summary_package_api_adapter/type_rendering.dart';

const _dartOperatorNames = <String>{
  '+',
  '-',
  '*',
  '/',
  '%',
  '~/',
  '&',
  '|',
  '^',
  '<<',
  '>>',
  '>>>',
  '[]',
  '[]=',
  '~',
  '==',
  '>',
  '<',
  '>=',
  '<=',
};

/// Builds a [PackageApi] from `api_summary` output.
///
/// The adapter keeps `api_summary` as the single source of analyzer data and
/// only translates it into dart_apitool's existing diff/storage model.
final class ApiSummaryPackageApiAdapter {
  /// Path to the package root that contains `pubspec.yaml`.
  final String packagePath;

  /// Whether Android and iOS package constraints should be included.
  final bool doAnalyzePlatformConstraints;

  /// Whether every public file outside `lib/src` is treated as an entrypoint.
  final bool doConsiderNonSrcAsEntryPoints;

  /// Semantic flags attached to the resulting [PackageApi].
  final Set<PackageApiSemantics> semantics;

  /// Creates an adapter for one package analysis run.
  const ApiSummaryPackageApiAdapter({
    required this.packagePath,
    required this.doAnalyzePlatformConstraints,
    required this.doConsiderNonSrcAsEntryPoints,
    required this.semantics,
  });

  /// Analyzes [packagePath] and returns the dart_apitool API model.
  Future<PackageApi> analyze() async {
    final normalizedProjectPath = path.normalize(path.absolute(packagePath));
    final yamlContent = await File(
      path.join(normalizedProjectPath, 'pubspec.yaml'),
    ).readAsString();
    final pubSpec = Pubspec.parse(yamlContent);

    final summary = await api_summary.apiSummary(
      normalizedProjectPath,
      packageName: pubSpec.name,
      customizer: const _ReferencedPackageDeclarationsCustomizer(),
    );

    final adaptedSummary = _ApiSummaryModelAdapter(
      packageName: pubSpec.name,
      packagePath: normalizedProjectPath,
      doConsiderNonSrcAsEntryPoints: doConsiderNonSrcAsEntryPoints,
    ).adapt(summary);

    final androidPlatformConstraints = doAnalyzePlatformConstraints
        ? await AndroidPlatformConstraintsHelper.getAndroidPlatformConstraints(
            packagePath: normalizedProjectPath,
          )
        : null;
    final iosPlatformConstraints = doAnalyzePlatformConstraints
        ? await IOSPlatformConstraintsHelper.getIOSPlatformConstraints(
            packagePath: normalizedProjectPath,
          )
        : null;

    final sdkVersion = pubSpec.environment['sdk'];
    Version? minSdkVersion;
    if (sdkVersion is VersionRange) {
      minSdkVersion = sdkVersion.min;
    } else if (sdkVersion is Version) {
      minSdkVersion = sdkVersion;
    }
    final isFlutter = PackageTooling.isFlutterPackage(pubSpec);
    final packageDependencies =
        PackageDependenciesHelper.getPackageDependencies(pubSpec);

    return PackageApi(
      packageName: pubSpec.name,
      packageVersion: pubSpec.version?.toString(),
      packagePath: normalizedProjectPath,
      interfaceDeclarations: adaptedSummary.interfaceDeclarations,
      executableDeclarations: adaptedSummary.executableDeclarations,
      fieldDeclarations: adaptedSummary.fieldDeclarations,
      typeAliasDeclarations: adaptedSummary.typeAliasDeclarations,
      semantics: semantics,
      androidPlatformConstraints: androidPlatformConstraints,
      iosPlatformConstraints: iosPlatformConstraints,
      sdkType: isFlutter ? SdkType.flutter : SdkType.dart,
      minSdkVersion: minSdkVersion ?? Version.none,
      packageDependencies: packageDependencies,
      typeHierarchy: adaptedSummary.typeHierarchy,
    );
  }
}
