/// version check mode to apply
enum VersionCheckMode {
  /// no version check
  none,

  /// complete version check (breaking and non-breaking changes)
  fully,

  /// only breaking changes
  onlyBreakingChanges,
}
