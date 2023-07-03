/// represents options for the [PackageApiDiffer]
class PackageApiDifferOptions {
  /// whether to ignore type parameter changes
  final bool ignoreTypeParameterNameChanges;

  /// whether to ignore sdk version changes
  final bool doCheckSdkVersion;

  /// whether the requiredness aspect of interfaces shall be ignored (to be less strict about version bump requirements)
  final bool doIgnoreRequiredness;

  /// creates a new PackageApiDifferOptions instance
  const PackageApiDifferOptions({
    this.ignoreTypeParameterNameChanges = true,
    this.doCheckSdkVersion = true,
    this.doIgnoreRequiredness = false,
  });
}
