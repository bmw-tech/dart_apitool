import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:colorize/colorize.dart';
import 'package:console/console.dart';
import 'package:dart_apitool/api_tool.dart';
import 'package:path/path.dart';

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
String _optionNameOutputMode = 'output-mode';
String _optionNameSilent = 'silent';

/// command for diffing two packages
class DiffCommand extends Command<int> with CommandMixin {
  @override
  final name = "diff";
  @override
  final description = "Creates a diff of 2 given packages.";

  DiffCommand() {
    argParser
      ..addOption(
        _optionNameOld,
        mandatory: true,
        help: 'Old package reference. $packageRefExplanation',
      )
      ..addOption(
        _optionNameNew,
        mandatory: true,
        help: 'New package reference. $packageRefExplanation',
      )
      ..addFlag(
        _optionNameIncludePathDependencies,
        abbr: 'p',
        help: includePathDependenciesExplanation,
      )
      ..addOption(
        _optionNameVersionCheckMode,
        help: '''
Defines the mode the versions of the packages shall be compared. 
This affects the exit code of this program.
''',
        allowed: VersionCheckMode.values.map((e) => e.name).toList(),
        defaultsTo: VersionCheckMode.fully.name,
      )
      ..addFlag(
        _optionNameCheckSdkVersion,
        help: 'Determines if the SDK version should be checked.',
        defaultsTo: true,
        negatable: true,
      )
      ..addFlag(
        _optionNameIgnorePrerelease,
        help: '''
Determines if the pre-release aspect of the new version
shall be ignored when checking versions.
You may want to do this if you want to make sure
(in your CI) that the version - once ready - matches semver.
''',
        defaultsTo: true,
        negatable: true,
      )
      ..addFlag(
        _optionNameNoAnalyzePlatformConstraints,
        help: 'Disables analysis of platform constraints.',
        defaultsTo: false,
        negatable: false,
      )
      ..addOption(
        _optionNameDependencyCheckMode,
        help: 'DEPRECATED - this option as no effect any more',
        // ignore: deprecated_member_use_from_same_package
        allowed: DependencyCheckMode.values.map((e) => e.name).toList(),
        // ignore: deprecated_member_use_from_same_package
        defaultsTo: DependencyCheckMode.allowAdding.name,
      )
      ..addFlag(
        _optionNameRemoveExample,
        help: 'Removes examples from the package to analyze.',
        defaultsTo: true,
        negatable: true,
      )
      ..addFlag(
        _optionNameIgnoreRequiredness,
        help:
            'Whether to ignore the required aspect of interfaces (yielding less strict version bump requirements)',
        defaultsTo: false,
        negatable: true,
      )
      ..addOption(
        _optionNameOutputMode,
        help: 'Which output mode to choose.',
        defaultsTo: OutputMode.humanReadable.optionName,
      )
      ..addFlag(
        _optionNameSilent,
        help: 'Whether to suppress output.',
        defaultsTo: false,
        negatable: true,
      );
  }

  @override
  Future<int> run() async {
    final oldPackageRef = PackageRef(argResults![_optionNameOld]);
    final newPackageRef = PackageRef(argResults![_optionNameNew]);
    final silent = argResults![_optionNameSilent] as bool;
    final shouldCheckPathDependencies =
        argResults![_optionNameIncludePathDependencies] as bool;
    final versionCheckMode = VersionCheckMode.values.firstWhere(
        (element) => element.name == argResults![_optionNameVersionCheckMode]);
    final ignorePrerelease = argResults![_optionNameIgnorePrerelease] as bool;
    final doCheckSdkVersion = argResults![_optionNameCheckSdkVersion] as bool;
    final noAnalyzePlatformConstraints =
        argResults![_optionNameNoAnalyzePlatformConstraints] as bool;
    if ((argResults?.arguments
                .any((a) => a == '--$_optionNameDependencyCheckMode') ??
            false) &&
        !silent) {
      stdout.writeln(
          'You are using the option "$_optionNameDependencyCheckMode" that has no effect any more and will be removed in a future release (and will lead to an exception if specified)');
    }
    final doRemoveExample = argResults![_optionNameRemoveExample] as bool;
    final doIgnoreRequiredness =
        argResults![_optionNameIgnoreRequiredness] as bool;

    final preparedOldPackageRef = await prepare(
      oldPackageRef,
      shouldCheckPathDependencies: shouldCheckPathDependencies,
      silent: silent,
    );
    final preparedNewPackageRef = await prepare(
      newPackageRef,
      shouldCheckPathDependencies: shouldCheckPathDependencies,
      silent: silent,
    );

    final oldPackageApi = await analyze(
      preparedOldPackageRef,
      doAnalyzePlatformConstraints: !noAnalyzePlatformConstraints,
      doRemoveExample: doRemoveExample,
      silent: silent,
    );
    final newPackageApi = await analyze(
      preparedNewPackageRef,
      doAnalyzePlatformConstraints: !noAnalyzePlatformConstraints,
      doRemoveExample: doRemoveExample,
      silent: silent,
    );
    final outputMode = OutputMode.values.firstWhere((element) =>
        element.optionName == argResults![_optionNameOutputMode] as String);

    await cleanUp(preparedOldPackageRef, silent: silent);
    await cleanUp(preparedNewPackageRef, silent: silent);

    final differ = PackageApiDiffer(
      options: PackageApiDifferOptions(
        doCheckSdkVersion: doCheckSdkVersion,
        doIgnoreRequiredness: doIgnoreRequiredness,
      ),
    );
    final diffResult =
        differ.diff(oldApi: oldPackageApi, newApi: newPackageApi);

    if (!silent) stdout.writeln();

    // print the diffs
    printDiffResult(diffResult, outputMode);

    if (versionCheckMode != VersionCheckMode.none &&
        !VersionCheck.versionChangeMatchesChanges(
          diffResult: diffResult,
          oldPackageApi: oldPackageApi,
          newPackageApi: newPackageApi,
          ignorePrerelease: ignorePrerelease,
          versionCheckMode: versionCheckMode,
          silent: silent,
        )) {
      return -1;
    }

    return 0;
  }

  void printDiffResult(PackageApiDiffResult diffResult, OutputMode outputMode) {
    switch (outputMode) {
      case OutputMode.humanReadable:
        printHumanReadable(diffResult);
        break;
      case OutputMode.json:
        printJson(diffResult);
        break;
    }
  }

  void printHumanReadable(PackageApiDiffResult diffResult) {
    if (diffResult.hasChanges) {
      final breakingChanges = _printApiChangeNode(diffResult.rootNode, true);
      if (breakingChanges == null) {
        stdout.writeln('No breaking changes!');
      } else {
        stdout.write(breakingChanges);
      }
      final nonBreakingChanges =
          _printApiChangeNode(diffResult.rootNode, false);
      if (nonBreakingChanges == null) {
        stdout.writeln('No non-breaking changes!');
      } else {
        stdout.write(nonBreakingChanges);
      }
      stdout.writeln();
      stdout.writeln(
          'To learn more about the detected changes visit: https://github.com/bmw-tech/dart_apitool/blob/main/readme/change_codes.md');
    } else {
      stdout.writeln('No changes detected!');
    }
  }

  String _getDeclarationNodePrefix(Declaration declaration) {
    String? prefix;
    if (declaration is ExecutableDeclaration) {
      switch (declaration.type) {
        case ExecutableType.constructor:
          prefix = 'Constructor';
          break;
        case ExecutableType.method:
          prefix = 'Method';
          break;
      }
    } else if (declaration is FieldDeclaration) {
      prefix = 'Field';
    } else if (declaration is InterfaceDeclaration) {
      prefix = 'Class';
    }
    return prefix ?? '';
  }

  String? _printApiChangeNode(ApiChangeTreeNode node, bool breaking) {
    Map nodeToTree(ApiChangeTreeNode n, {String? labelOverride}) {
      final relevantChanges = n.changes.where((c) => c.isBreaking == breaking);
      final changeNodes = relevantChanges.map((c) =>
          '${Colorize(c.changeDescription).italic()} (${c.changeCode.code})${c.isBreaking ? '' : c.type.requiresMinorBump ? ' (minor)' : ' (patch)'}');
      final childNodes = n.children.values
          .map((value) => nodeToTree(value))
          .where((element) => element.isNotEmpty);
      final allChildren = [
        ...changeNodes,
        ...childNodes,
      ];
      if (allChildren.isEmpty) {
        return {};
      }
      return {
        'label': Colorize(labelOverride ??
                (n.nodeDeclaration == null
                    ? ''
                    : [
                        _getDeclarationNodePrefix(n.nodeDeclaration!),
                        n.nodeDeclaration!.name
                      ].join(' ')))
            .bold()
            .toString(),
        'nodes': allChildren,
      };
    }

    final nodes = nodeToTree(node,
        labelOverride: breaking ? 'BREAKING CHANGES' : 'Non-Breaking changes');

    if (nodes.isEmpty) {
      return null;
    }

    return createTree(nodes);
  }

  Map<String, dynamic> getJson(PackageApiDiffResult diffResult) {
    Map<String, dynamic> nodeToTree(ApiChangeTreeNode n, bool breaking) {
      final relevantChanges = n.changes.where((c) => c.isBreaking == breaking);
      final changeNodes = relevantChanges.map((c) => {
            'description': c.changeDescription,
            'code': c.changeCode.code,
            'breaking': c.isBreaking,
            'minor': c.type.requiresMinorBump,
          });
      final childNodes = n.children.values
          .map((value) => nodeToTree(value, breaking))
          .where((element) => element.isNotEmpty);
      final allChildren = [
        ...changeNodes,
        ...childNodes,
      ];
      if (allChildren.isEmpty) {
        return {};
      }
      return {
        if (n.nodeDeclaration != null)
          'label': {
            'declaration': _getDeclarationNodePrefix(n.nodeDeclaration!),
            'name': n.nodeDeclaration!.name
          },
        'nodes': allChildren,
      };
    }

    var object = {
      'breaking': nodeToTree(diffResult.rootNode, true),
      'nonbreaking': nodeToTree(diffResult.rootNode, false),
    };
    return object;
  }

  void printJson(PackageApiDiffResult diffResult) {
    JsonEncoder encoder = JsonEncoder.withIndent('  ');
    print(encoder.convert(getJson(diffResult)));
  }
}

enum OutputMode {
  humanReadable._('human-readable'),
  json._('json');

  final String optionName;

  const OutputMode._(this.optionName);
}
