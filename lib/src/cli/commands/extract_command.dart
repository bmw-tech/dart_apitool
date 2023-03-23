import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_apitool/src/storage/storage.dart';

import '../package_ref.dart';
import 'command_mixin.dart';

String _optionNameInput = 'input';
String _optionNameIncludePathDependencies = 'include-path-dependencies';
String _optionNameOutput = 'output';
String _optionNameNoAnalyzePlatformConstraints =
    'no-analyze-platform-constraints';
String _optionNameRemoveExample = 'remove-example';

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
      help: 'Removes examples from the package to analyze.',
      defaultsTo: true,
      negatable: true,
    );
  }

  @override
  Future<int> run() async {
    final packageRef = PackageRef(argResults![_optionNameInput]);
    final shouldCheckPathDependencies =
        argResults![_optionNameIncludePathDependencies] as bool;
    final noAnalyzePlatformConstraints =
        argResults![_optionNameNoAnalyzePlatformConstraints] as bool;
    final doRemoveExample = argResults![_optionNameRemoveExample] as bool;

    final preparedPackageRef = await prepare(
      packageRef,
      shouldCheckPathDependencies: shouldCheckPathDependencies,
    );
    final packageApi = await analyze(
      preparedPackageRef,
      doAnalyzePlatformConstraints: !noAnalyzePlatformConstraints,
      doRemoveExample: doRemoveExample,
    );
    await cleanUp(preparedPackageRef);
    final jsonString =
        PackageApiStorage.packageApitoStorageJson(packageApi, pretty: true);
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

    final declarationsWithoutEntryPoints =
        packageApi.getRootDeclarationsWithoutEntryPoints();
    if (declarationsWithoutEntryPoints.isNotEmpty) {
      stdout.writeln('The following declarations do not have an entry point:');
      for (final declaration in declarationsWithoutEntryPoints) {
        stdout.writeln('  ${declaration.name}');
      }
    }
    return 0;
  }
}
