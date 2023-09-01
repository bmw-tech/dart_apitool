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
    bool silent = false,
  }) {
    write(silent, '');
    write(silent, 'Checking Package version');
    write(silent, '');
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
      write(silent, 'Skipping version check completely');
      return true;
    }
    if (versionCheckMode == VersionCheckMode.onlyBreakingChanges &&
        !containsBreakingChanges) {
      write(silent,
          'Skipping version check because there are no breaking changes');
      return true;
    }

    if (ignorePrerelease) {
      // if we want to ignore pre-release then we just remove the prerelease part of the Version
      write(silent, 'ignoring prerelease');
      newVersion.preRelease.clear();
    }

    if (oldVersion.isPreRelease) {
      // if the old version is a prerelease version then we test if the new version is the same without the prerelease part
      final oldVersionWithoutPreRelease = Version.parse(oldVersion.toString());
      oldVersionWithoutPreRelease.preRelease.clear();
      if (oldVersionWithoutPreRelease <= newVersion) {
        write(silent,
            'Skipping version check because the old version is a pre-release and the new version is the same or higher without the pre-release part');
        return true;
      }
    }

    if (newVersion.isPreRelease) {
      // pre-release. We don't look at differentiation between breaking and non-breaking changes
      write(silent,
          'We got a pre release. We only check if there are any changes');
      if (containsAnyChanges && oldVersion >= newVersion) {
        write(silent,
            'Got "${Colorize(newVersion.toString()).bold()}" expected > "${Colorize(oldVersion.toString()).bold()}" (pre-release but changes)');
        return false;
      }
      write(silent, Colorize('New version is OK!').green());
      final explaination = containsAnyChanges
          ? 'which is > "${Colorize(oldVersion.toString()).bold()}" (pre-release but changes)'
          : 'and no changes';
      write(silent,
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

    write(silent, 'Old version: "$oldVersion"');
    write(silent,
        'Expecting minimum version: "$expectedMinVersion" ($versionExplanation)');
    if (newVersion < expectedMinVersion) {
      write(silent, Colorize('New Version is too low!').red());
      write(silent,
          'Got "${Colorize(newVersion.toString()).bold()}" expected >= "${Colorize(expectedMinVersion.toString()).bold()}"');
      return false;
    } else {
      write(silent, Colorize('New version is OK!').green());
      write(silent,
          'Got "${Colorize(newVersion.toString()).bold()}" which is >= "${Colorize(expectedMinVersion.toString()).bold()}"');
      return true;
    }
  }

  static void write(bool silent, Object? s) {
    if (!silent) {
      stdout.writeln(s);
    }
  }
}
