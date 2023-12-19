import 'dart:io';

import 'package:pub_semver/pub_semver.dart';

import '../../../api_tool.dart';

class VersionCheckResult {
  final bool success;
  final Version oldVersion;
  final Version newVersion;
  final Version? neededVersion;
  final String explanation;

  VersionCheckResult.success({
    required this.oldVersion,
    required this.newVersion,
    Version? neededVersion,
    required this.explanation,
  })  : success = true,
        neededVersion = neededVersion ?? newVersion;

  VersionCheckResult.failure({
    required this.oldVersion,
    required this.newVersion,
    required this.neededVersion,
    required this.explanation,
  }) : success = false;
}

/// helper class to check if the version change matches the changes
abstract class VersionCheck {
  /// checks if the version change between [oldPackageApi] and [newPackageApi] matches the changes in [diffResult]
  static VersionCheckResult check({
    required PackageApiDiffResult diffResult,
    required PackageApi oldPackageApi,
    required PackageApi newPackageApi,
    required bool ignorePrerelease,
    required VersionCheckMode versionCheckMode,
  }) {
    stdout.writeln('Checking Package version');
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
      return VersionCheckResult.success(
        oldVersion: oldVersion,
        newVersion: newVersion,
        explanation:
            'Skipping version check completely as the version check mode is $versionCheckMode',
      );
    }
    if (versionCheckMode == VersionCheckMode.onlyBreakingChanges &&
        !containsBreakingChanges) {
      return VersionCheckResult.success(
        oldVersion: oldVersion,
        newVersion: newVersion,
        explanation:
            'Skipping version check because there are no breaking changes',
      );
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
        return VersionCheckResult.success(
          oldVersion: oldVersion,
          newVersion: newVersion,
          explanation:
              'Skipping version check because the old version is a pre-release and the new version is the same or higher without the pre-release part',
        );
      }
    }

    if (newVersion.isPreRelease) {
      // pre-release. We don't look at differentiation between breaking and non-breaking changes
      final prefix =
          'We got a pre release. We only check if there are any changes.';
      if (containsAnyChanges && oldVersion >= newVersion) {
        return VersionCheckResult.failure(
          oldVersion: oldVersion,
          newVersion: newVersion,
          neededVersion: null,
          explanation:
              '$prefix Got "$newVersion" expected > "$oldVersion" (pre-release but changes)',
        );
      }
      final explanation = containsAnyChanges
          ? 'which is > "$oldVersion" (pre-release but changes)'
          : 'and no changes';
      return VersionCheckResult.success(
          oldVersion: oldVersion,
          newVersion: newVersion,
          explanation: '$prefix Got "$newVersion" $explanation');
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

    if (newVersion < expectedMinVersion) {
      return VersionCheckResult.failure(
        oldVersion: oldVersion,
        newVersion: newVersion,
        neededVersion: expectedMinVersion,
        explanation:
            'Got "$newVersion" expected >= "$expectedMinVersion" ($versionExplanation)',
      );
    } else {
      return VersionCheckResult.success(
        oldVersion: oldVersion,
        newVersion: newVersion,
        neededVersion: expectedMinVersion,
        explanation:
            'Got "$newVersion" which is >= "$expectedMinVersion" ($versionExplanation)',
      );
    }
  }
}
