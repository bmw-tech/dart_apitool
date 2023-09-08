import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_apitool/api_tool.dart';
import 'package:dart_apitool/src/diff/report/diff_reporter.dart';
import 'package:dart_apitool/src/diff/report/json_diff_reporter.dart';

import '../../diff/report/console_diff_reporter.dart';
import '../../diff/report/markdown_diff_reporter.dart';
import '../package_ref.dart';
import 'command_mixin.dart';
import 'version_check.dart';

String _optionNameOld = 'old';
String _optionNameNew = 'new';
String _optionNameIncludePathDependencies = 'include-path-dependencies';
String _optionNameVersionCheckMode = 'version-check-mode';
String _optionNameIgnorePrerelease = 'ignore-prerelease';
String _optionNameNoAnalyzePlatformConstraints =
    'no-analyze-platform-constraints';
String _optionNameCheckSdkVersion = 'check-sdk-version';
String _optionNameDependencyCheckMode = 'dependency-check-mode';
String _optionNameRemoveExample = 'remove-example';
String _optionNameIgnoreRequiredness = 'ignore-requiredness';
String _optionReportFormat = 'report-format';
String _optionReportPath = 'report-file-path';

/// command for diffing two packages
class DiffCommand extends Command<int> with CommandMixin {
  @override
  final name = "diff";
  @override
  final description = "Creates a diff of 2 given packages.";

  DiffCommand() {
    argParser.addOption(
      _optionNameOld,
      mandatory: true,
      help: 'Old package reference. $packageRefExplanation',
    );
    argParser.addOption(
      _optionNameNew,
      mandatory: true,
      help: 'New package reference. $packageRefExplanation',
    );
    argParser.addFlag(
      _optionNameIncludePathDependencies,
      abbr: 'p',
      help: includePathDependenciesExplanation,
    );
    argParser.addOption(
      _optionNameVersionCheckMode,
      help: '''
Defines the mode the versions of the packages shall be compared. 
This affects the exit code of this program.
''',
      allowed: VersionCheckMode.values.map((e) => e.name).toList(),
      defaultsTo: VersionCheckMode.fully.name,
    );
    argParser.addFlag(
      _optionNameCheckSdkVersion,
      help: 'Determines if the SDK version should be checked.',
      defaultsTo: true,
      negatable: true,
    );
    argParser.addFlag(
      _optionNameIgnorePrerelease,
      help: '''
Determines if the pre-release aspect of the new version
shall be ignored when checking versions.
You may want to do this if you want to make sure
(in your CI) that the version - once ready - matches semver.
''',
      defaultsTo: true,
      negatable: true,
    );
    argParser.addFlag(
      _optionNameNoAnalyzePlatformConstraints,
      help: 'Disables analysis of platform constraints.',
      defaultsTo: false,
      negatable: false,
    );
    argParser.addOption(
      _optionNameDependencyCheckMode,
      help: 'DEPRECATED - this option as no effect any more',
      // ignore: deprecated_member_use_from_same_package
      allowed: DependencyCheckMode.values.map((e) => e.name).toList(),
      // ignore: deprecated_member_use_from_same_package
      defaultsTo: DependencyCheckMode.allowAdding.name,
    );
    argParser.addFlag(
      _optionNameRemoveExample,
      help: 'Removes examples from the package to analyze.',
      defaultsTo: true,
      negatable: true,
    );
    argParser.addFlag(
      _optionNameIgnoreRequiredness,
      help:
          'Whether to ignore the required aspect of interfaces (yielding less strict version bump requirements)',
      defaultsTo: false,
      negatable: true,
    );
    argParser.addOption(
      _optionReportFormat,
      help: 'Which output format should be used',
      defaultsTo: 'cli',
      allowed: ['cli', 'markdown', 'json'],
      mandatory: false,
    );
    argParser.addOption(
      _optionReportPath,
      help: 'Where to store the report file (no effect on cli option)',
      mandatory: false,
    );
  }

  @override
  Future<int> run() async {
    final oldPackageRef = PackageRef(argResults![_optionNameOld]);
    final newPackageRef = PackageRef(argResults![_optionNameNew]);
    final outputFormatter = argResults![_optionReportFormat];
    final outputFile = argResults![_optionReportPath];

    if (outputFormatter != 'cli' && outputFile == null) {
      throw 'You need to define an output file using the $_optionReportPath parameter when not using the cli option';
    }

    if (outputFormatter == 'cli' && outputFile != null) {
      stdout.writeln(
          'WARNING: $_optionReportPath has no effect because $_optionReportFormat is set to cli');
    }

    final versionCheckMode = VersionCheckMode.values.firstWhere(
        (element) => element.name == argResults![_optionNameVersionCheckMode]);
    final ignorePrerelease = argResults![_optionNameIgnorePrerelease] as bool;
    final doCheckSdkVersion = argResults![_optionNameCheckSdkVersion] as bool;
    final noAnalyzePlatformConstraints =
        argResults![_optionNameNoAnalyzePlatformConstraints] as bool;
    if (argResults?.arguments
            .any((a) => a == '--$_optionNameDependencyCheckMode') ??
        false) {
      stdout.writeln(
          'You are using the option "$_optionNameDependencyCheckMode" that has no effect any more and will be removed in a future release (and will lead to an exception if specified)');
    }
    final doRemoveExample = argResults![_optionNameRemoveExample] as bool;
    final doIgnoreRequiredness =
        argResults![_optionNameIgnoreRequiredness] as bool;

    final preparedOldPackageRef = await prepare(
      oldPackageRef,
    );
    final preparedNewPackageRef = await prepare(
      newPackageRef,
    );

    final oldPackageApi = await analyze(
      preparedOldPackageRef,
      doAnalyzePlatformConstraints: !noAnalyzePlatformConstraints,
      doRemoveExample: doRemoveExample,
    );
    final newPackageApi = await analyze(
      preparedNewPackageRef,
      doAnalyzePlatformConstraints: !noAnalyzePlatformConstraints,
      doRemoveExample: doRemoveExample,
    );

    await cleanUp(preparedOldPackageRef);
    await cleanUp(preparedNewPackageRef);

    final differ = PackageApiDiffer(
      options: PackageApiDifferOptions(
        doCheckSdkVersion: doCheckSdkVersion,
        doIgnoreRequiredness: doIgnoreRequiredness,
      ),
    );
    final diffResult =
        differ.diff(oldApi: oldPackageApi, newApi: newPackageApi);

    DiffReporter reporter = (() {
      switch (outputFormatter) {
        case 'cli':
          return ConsoleDiffReporter();
        case 'markdown':
          return MarkdownDiffReporter(
              oldPackageRef: oldPackageRef,
              newPackageRef: newPackageRef,
              outputFile: File(outputFile));
        case 'json':
          return JsonDiffReporter(
              oldPackageRef: oldPackageRef,
              newPackageRef: newPackageRef,
              outputFile: File(outputFile));
        default:
          throw 'Unknown format speicified $outputFormatter';
      }
    })();

    stdout.writeln('-- Generating report using: ${reporter.reporterName} --');
    await reporter.generateReport(diffResult);

    if (versionCheckMode != VersionCheckMode.none &&
        !VersionCheck.versionChangeMatchesChanges(
            diffResult: diffResult,
            oldPackageApi: oldPackageApi,
            newPackageApi: newPackageApi,
            ignorePrerelease: ignorePrerelease,
            versionCheckMode: versionCheckMode)) {
      return -1;
    }

    return 0;
  }
}
