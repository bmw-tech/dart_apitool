import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_apitool/src/storage/storage.dart';

import '../../model/model.dart';
import '../package_ref.dart';
import 'command_mixin.dart';

String _optionNameInput = 'input';
String _optionNameIncludePathDependencies = 'include-path-dependencies';
String _optionNameOutput = 'output';
String _optionNameNoAnalyzePlatformConstraints =
    'no-analyze-platform-constraints';
String _optionNameRemoveExample = 'remove-example';
String _optionNameSetExitCodeOnMissingExport = 'set-exit-on-missing-export';

/// command to extract the public API of a package.
/// This is used when, for example, the public API needs to be stored on disk
class ExtractCommand extends Command<int> with CommandMixin {
  @override
  String get description => 'Extracts the API from the given package ref.';

  @override
  String get name => 'extract';

  ExtractCommand() {
    argParser.addOption(
      _optionNameInput,
      help: 'Input package ref. $packageRefExplanation',
      mandatory: true,
    );
    argParser.addFlag(
      _optionNameIncludePathDependencies,
      abbr: 'p',
      help: includePathDependenciesExplanation,
    );
    argParser.addOption(
      _optionNameOutput,
      help: '''
Output file for the extracted Package API.
If not specified the extracted API will be printed to the console.
''',
    );
    argParser.addFlag(
      _optionNameNoAnalyzePlatformConstraints,
      help: 'Disables analysis of platform constraints.',
      defaultsTo: false,
      negatable: false,
    );
    argParser.addFlag(
      _optionNameRemoveExample,
      help:
          'DEPRECATED - Removes examples from the package to analyze. (has no effect any more)',
      defaultsTo: true,
      negatable: true,
    );
    argParser.addFlag(
      _optionNameSetExitCodeOnMissingExport,
      help:
          'Sets exit code to != 0 if missing exports are detected in the API.',
      defaultsTo: false,
      negatable: true,
    );
    init(argParser);
  }

  @override
  Future<int> run() async {
    final packageRef = PackageRef(argResults![_optionNameInput]);
    final noAnalyzePlatformConstraints =
        argResults![_optionNameNoAnalyzePlatformConstraints] as bool;
    final doSetExitCodeOnMissingExport =
        argResults![_optionNameSetExitCodeOnMissingExport] as bool;

    final preparedPackageRef = await prepare(
      argResults!,
      packageRef,
    );
    final packageApi = await analyze(
      argResults!,
      preparedPackageRef,
      doAnalyzePlatformConstraints: !noAnalyzePlatformConstraints,
    );
    await cleanUp(preparedPackageRef);

    final jsonString = PackageApiStorage.packageApitoStorageJson(
      packageApi,
      pretty: true,
    );
    final outFilePath = argResults![_optionNameOutput] as String?;
    if (outFilePath != null) {
      final outFile = File(outFilePath);
      if (await outFile.exists()) {
        await outFile.delete();
      }
      await outFile.writeAsString(jsonString, mode: FileMode.write);
      stdout.writeln('Public API of "$packageRef" written to $outFilePath');
    } else {
      stdout.writeln(jsonString);
    }

    final declarationsWithoutEntryPointsOutsideTests =
        packageApi.rootDeclarationsWithoutEntryPointsAndVisibleOutsideTests;

    if (declarationsWithoutEntryPointsOutsideTests.isNotEmpty) {
      if (outFilePath == null) {
        stdout.writeln(
            'The following declarations do not have an entry point (did you miss to export them?):');
        for (final declaration in declarationsWithoutEntryPointsOutsideTests) {
          stdout.writeln('  ${declaration.name}');
          if (declaration is InterfaceDeclaration) {
            final filteredUsages = declaration.typeUsages
                .where((tu) => !tu.isVisibleForTesting)
                .toList();
            if (filteredUsages.isNotEmpty) {
              stdout.writeln('    Usage(s):');
              for (final typeUsage in filteredUsages) {
                stdout.writeln('    - ${typeUsage.referringElementName}');
              }
            }
          }
        }
      }
      if (doSetExitCodeOnMissingExport) {
        return -1;
      }
    }
    return 0;
  }
}
