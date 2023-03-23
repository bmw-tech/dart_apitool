import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:colorize/colorize.dart';
import 'package:console/console.dart';
import 'package:dart_apitool/api_tool.dart';

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
This only makes sense in combination with --$_optionNameDependencyCheckMode != ${VersionCheckMode.none.name}.
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
      help: 'Defines the mode package dependency changes are handled.',
      allowed: DependencyCheckMode.values.map((e) => e.name).toList(),
      defaultsTo: DependencyCheckMode.strict.name,
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
    final oldPackageRef = PackageRef(argResults![_optionNameOld]);
    final newPackageRef = PackageRef(argResults![_optionNameNew]);
    final shouldCheckPathDependencies =
        argResults![_optionNameIncludePathDependencies] as bool;
    final versionCheckMode = VersionCheckMode.values.firstWhere(
        (element) => element.name == argResults![_optionNameVersionCheckMode]);
    final ignorePrerelease = argResults![_optionNameIgnorePrerelease] as bool;
    final doCheckSdkVersion = argResults![_optionNameCheckSdkVersion] as bool;
    final noAnalyzePlatformConstraints =
        argResults![_optionNameNoAnalyzePlatformConstraints] as bool;
    final dependencyCheckMode = DependencyCheckMode.values.firstWhere(
        (element) =>
            element.name == argResults![_optionNameDependencyCheckMode]);
    final doRemoveExample = argResults![_optionNameRemoveExample] as bool;

    final preparedOldPackageRef = await prepare(
      oldPackageRef,
      shouldCheckPathDependencies: shouldCheckPathDependencies,
    );
    final preparedNewPackageRef = await prepare(
      newPackageRef,
      shouldCheckPathDependencies: shouldCheckPathDependencies,
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
        dependencyCheckMode: dependencyCheckMode,
      ),
    );
    final diffResult =
        differ.diff(oldApi: oldPackageApi, newApi: newPackageApi);

    stdout.writeln();

    // print the diffs
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

  String _getDeclarationNodeHeadline(Declaration declaration) {
    var prefix = '';
    if (declaration is ExecutableDeclaration) {
      switch (declaration.type) {
        case ExecutableType.constructor:
          prefix = 'Constructor ';
          break;
        case ExecutableType.method:
          prefix = 'Method ';
          break;
      }
    } else if (declaration is FieldDeclaration) {
      prefix = 'Field ';
    } else if (declaration is InterfaceDeclaration) {
      prefix = 'Class ';
    }
    return prefix + declaration.name;
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
                    : _getDeclarationNodeHeadline(n.nodeDeclaration!)))
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
}
