import 'dependency_check_mode.dart';

/// represents options for the [PackageApiDiffer]
class PackageApiDifferOptions {
  /// whether to ignore type parameter changes
  final bool ignoreTypeParameterNameChanges;

  /// whether to ignore sdk version changes
  final bool doCheckSdkVersion;

  /// how to check for dependency changes
  final DependencyCheckMode dependencyCheckMode;

  /// whether the requiredness aspect of interfaces shall be ignored (to be less strict about version bump requirements)
  final bool doIgnoreRequiredness;

  /// creates a new PackageApiDifferOptions instance
  const PackageApiDifferOptions({
    this.ignoreTypeParameterNameChanges = true,
    this.doCheckSdkVersion = true,
    this.dependencyCheckMode = DependencyCheckMode.strict,
    this.doIgnoreRequiredness = false,
  });
}
