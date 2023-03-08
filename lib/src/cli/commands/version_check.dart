import 'dart:io';

import 'package:colorize/colorize.dart';
import 'package:pub_semver/pub_semver.dart';

import '../../../api_tool.dart';

/// helper class to check if the version change matches the changes
abstract class VersionCheck {
  /// checks if the version change between [oldPackageApi] and [newPackageApi] matches the changes in [diffResult]
  static bool versionChangeMatchesChanges({
    required PackageApiDiffResult diffResult,
    required PackageApi oldPackageApi,
    required PackageApi newPackageApi,
    required bool ignorePrerelease,
    required VersionCheckMode versionCheckMode,
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
    bool onlyPatchChanges =
        diffResult.apiChanges.any((change) => !change.type.requiresMinorBump);

    if (versionCheckMode == VersionCheckMode.none) {
      stdout.writeln('Skipping version check completely');
      return true;
    }
    if (versionCheckMode == VersionCheckMode.onlyBreakingChanges &&
        !containsBreakingChanges) {
      stdout.writeln(
          'Skipping version check because there are no breaking changes');
      return true;
    }

    if (ignorePrerelease) {
      // if we want to ignore pre-release then we just remove the prerelease part of the Version
      stdout.writeln('ignoring prerelease');
      newVersion.preRelease.clear();
    }

    if (oldVersion.isPreRelease) {
      // if the old version is a prerelease version then we test if the new version is the same without the prerelease part
      final oldVersionWithoutPreRelease = Version.parse(oldVersion.toString());
      oldVersionWithoutPreRelease.preRelease.clear();
      if (oldVersionWithoutPreRelease <= newVersion) {
        stdout.writeln(
            'Skipping version check because the old version is a pre-release and the new version is the same or higher without the pre-release part');
        return true;
      }
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

    Version expectedMinVersion =
        containsAnyChanges ? oldVersion.nextPatch : oldVersion;
    String versionExplanation = 'no changes';
    if (containsBreakingChanges) {
      expectedMinVersion = oldVersion.nextBreaking;
      versionExplanation = 'breaking changes';
    } else if (containsAnyChanges) {
      if (!onlyPatchChanges) {
        // Only for major > 0: expect the minor version to be incremented if any changes in the public API happen
        if (oldVersion.major > 0) {
          expectedMinVersion = oldVersion.nextMinor;
        }
        versionExplanation = 'non-breaking changes';
      } else {
        versionExplanation = 'non-breaking changes --> patch';
      }
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
