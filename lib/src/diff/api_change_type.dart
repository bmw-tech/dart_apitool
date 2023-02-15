/// represents the type of API change
enum ApiChangeType {
  /// breaking change
  changeBreaking._(isBreaking: true, requiresMinorBump: true),

  /// non-breaking change that requires a minor bump
  changeCompatibleMinor._(isBreaking: false, requiresMinorBump: true),

  /// non-breaking change that only requires a patch bump
  changeCompatiblePatch._(isBreaking: false, requiresMinorBump: false),

  /// removal (breaking)
  remove._(isBreaking: true, requiresMinorBump: true),

  /// removal (non-breaking, rather rare)
  removeCompatibleMinor._(isBreaking: false, requiresMinorBump: true),

  /// removal (non-breaking, probably never used)
  removeCompatiblePatch._(isBreaking: false, requiresMinorBump: false),

  /// non-breaking addition that requires a minor bump
  addCompatibleMinor._(isBreaking: false, requiresMinorBump: true),

  /// non-breaking addition that only requires a patch bump
  addCompatiblePatch._(isBreaking: false, requiresMinorBump: false),

  /// breaking addition (like adding a required parameter)
  addBreaking._(isBreaking: true, requiresMinorBump: true);

  /// determines if the change is breaking
  final bool isBreaking;

  /// determines if the change requires a minor bump (if false then it requires a patch bump)
  final bool requiresMinorBump;

  const ApiChangeType._({
    required this.isBreaking,
    required this.requiresMinorBump,
  });
}
