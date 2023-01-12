import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:colorize/colorize.dart';
import 'package:console/console.dart';
import 'package:dart_apitool/api_tool.dart';
import 'package:pub_semver/pub_semver.dart';

import '../package_ref.dart';
import 'command_mixin.dart';

String _optionNameOld = 'old';
String _optionNameNew = 'new';
String _optionNameIncludePathDependencies = 'include-path-dependencies';
String _optionNameCheckVersions = 'check-versions';
String _optionNameIgnorePrerelease = 'ignore-prerelease';
String _optionNameNoMergeBaseClasses = 'no-merge-base-classes';
String _optionNameNoAnalyzePlatformConstraints =
    'no-analyze-platform-constraints';
String _optionNameCheckSdkVersion = 'check-sdk-version';
String _optionNameDependencyCheckMode = 'dependency-check-mode';

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
    argParser.addFlag(
      _optionNameCheckVersions,
      help: '''
Determines if the version of the new package should be checked.
Takes the changes of the diff and checks if the new version follows semver.
Influences tool return value.
''',
      defaultsTo: true,
      negatable: true,
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
Determines if the pre-release aspect of the version
shall be ignored when checking versions.
This only makes sense in combination with --$_optionNameCheckVersions.
You may want to do this if you want to make sure
(in your CI) that the version - once ready - matches semver.
''',
      defaultsTo: false,
      negatable: true,
    );
    argParser.addFlag(
      _optionNameNoMergeBaseClasses,
      help: 'Disables base class merging.',
      defaultsTo: false,
      negatable: false,
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
  }

  @override
  Future<int> run() async {
    final oldPackageRef = PackageRef(argResults![_optionNameOld]);
    final newPackageRef = PackageRef(argResults![_optionNameNew]);
    final shouldCheckPathDependencies =
        argResults![_optionNameIncludePathDependencies] as bool;
    final checkVersions = argResults![_optionNameCheckVersions] as bool;
    final ignorePrerelease = argResults![_optionNameIgnorePrerelease] as bool;
    final doCheckSdkVersion = argResults![_optionNameCheckSdkVersion] as bool;
    final noMergeBaseClasses =
        argResults![_optionNameNoMergeBaseClasses] as bool;
    final noAnalyzePlatformConstraints =
        argResults![_optionNameNoAnalyzePlatformConstraints] as bool;
    final dependencyCheckMode = DependencyCheckMode.values.firstWhere(
        (element) =>
            element.name == argResults![_optionNameDependencyCheckMode]);

    final preparedOldPackageRef = await prepare(oldPackageRef,
        shouldCheckPathDependencies: shouldCheckPathDependencies);
    final preparedNewPackageRef = await prepare(newPackageRef,
        shouldCheckPathDependencies: shouldCheckPathDependencies);

    final oldPackageApi = await analyze(
      preparedOldPackageRef,
      doMergeBaseClasses: !noMergeBaseClasses,
      doAnalyzePlatformConstraints: !noAnalyzePlatformConstraints,
    );
    final newPackageApi = await analyze(
      preparedNewPackageRef,
      doMergeBaseClasses: !noMergeBaseClasses,
      doAnalyzePlatformConstraints: !noAnalyzePlatformConstraints,
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
          'To learn more about the detected changes visit: https://github.com/devmil/dart_apitool/blob/main/readme/change_codes.md');
    } else {
      stdout.writeln('No changes detected!');
    }

    if (checkVersions &&
        !_versionChangeMatchesChanges(
            diffResult: diffResult,
            oldPackageApi: oldPackageApi,
            newPackageApi: newPackageApi,
            ignorePrerelease: ignorePrerelease)) {
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
          '${Colorize(c.changeDescription).italic()} (${c.changeCode.code})');
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

  bool _versionChangeMatchesChanges({
    required PackageApiDiffResult diffResult,
    required PackageApi oldPackageApi,
    required PackageApi newPackageApi,
    required bool ignorePrerelease,
  }) {
    stdout.writeln('');
    stdout.writeln('Checking Package version');
    stdout.writeln('');
    if (oldPackageApi.packageVersion == null) {
      throw PackageApiDiffError(
          message: 'Old package doesn\'t contain a version]');
    }
    if (newPackageApi.packageVersion == null) {
      throw PackageApiDiffError(
          message: 'New package doesn\'t contain a version]');
    }
    final oldVersion = Version.parse(oldPackageApi.packageVersion!);
    final newVersion = Version.parse(newPackageApi.packageVersion!);

    bool containsAnyChanges = diffResult.hasChanges;
    bool containsBreakingChanges =
        diffResult.apiChanges.any((change) => change.isBreaking);

    if (ignorePrerelease) {
      // if we want to ignore pre-release then we just remove the prerelease part of the Version
      stdout.writeln('ignoring prerelease');
      newVersion.preRelease.clear();
    }

    if (newVersion.isPreRelease) {
      // pre-release. We don't look at differentiation between breaking and non-breaking changes
      stdout.writeln(
          'We got a pre release. We only check if there are any changes');
      if (containsAnyChanges && oldVersion >= newVersion) {
        stdout.writeln(
            'Got "${Colorize(newVersion.toString()).bold()}" expected > "${Colorize(oldVersion.toString()).bold()}" (pre-release but changes)');
        return false;
      }
      stdout.writeln(Colorize('New version is OK!').green());
      final explaination = containsAnyChanges
          ? 'which is > "${Colorize(oldVersion.toString()).bold()}" (pre-release but changes)'
          : 'and no changes';
      stdout.writeln(
          'Got "${Colorize(newVersion.toString()).bold()}" $explaination');
      return true;
    }

    Version expectedMinVersion = oldVersion.nextPatch;
    String versionExplanation = 'no changes';
    if (containsBreakingChanges) {
      expectedMinVersion = oldVersion.nextBreaking;
      versionExplanation = 'breaking changes';
    } else if (containsAnyChanges) {
      // Only for major > 0: expect the minor version to be incremented if any changes in the public API happen
      if (oldVersion.major > 0) {
        expectedMinVersion = oldVersion.nextMinor;
      }
      versionExplanation = 'non-breaking changes';
    }

    stdout.writeln('Old version: "$oldVersion"');
    stdout.writeln(
        'Expecting minimum version: "$expectedMinVersion" ($versionExplanation)');
    if (newVersion < expectedMinVersion) {
      stdout.writeln(Colorize('New Version is too low!').red());
      stdout.writeln(
          'Got "${Colorize(newVersion.toString()).bold()}" expected >= "${Colorize(expectedMinVersion.toString()).bold()}"');
      return false;
    } else {
      stdout.writeln(Colorize('New version is OK!').green());
      stdout.writeln(
          'Got "${Colorize(newVersion.toString()).bold()}" which is >= "${Colorize(expectedMinVersion.toString()).bold()}"');
      return true;
    }
  }
}
