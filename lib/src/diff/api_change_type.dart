/// represents the type of API change
enum ApiChangeType {
  /// breaking change
  changeBreaking(isBreaking: true, requiresMinorBump: true),

  /// non-breaking change that requires a minor bump
  changeCompatibleMinor(isBreaking: false, requiresMinorBump: true),

  /// non-breaking change that only requires a patch bump
  changeCompatiblePatch(isBreaking: false, requiresMinorBump: false),

  /// removal (breaking)
  remove(isBreaking: true, requiresMinorBump: true),

  /// removal (non-breaking, rather rare)
  removeCompatibleMinor(isBreaking: false, requiresMinorBump: true),

  /// removal (non-breaking, probably never used)
  removeCompatiblePatch(isBreaking: false, requiresMinorBump: false),

  /// non-breaking addition that requires a minor bump
  addCompatibleMinor(isBreaking: false, requiresMinorBump: true),

  /// non-breaking addition that only requires a patch bump
  addCompatiblePatch(isBreaking: false, requiresMinorBump: false),

  /// breaking addition (like adding a required parameter)
  addBreaking(isBreaking: true, requiresMinorBump: true);

  /// determines if the change is breaking
  final bool isBreaking;

  /// determines if the change requires a minor bump (if false then it requires a patch bump)
  final bool requiresMinorBump;

  const ApiChangeType(
      {required this.isBreaking, required this.requiresMinorBump});
}
