/// represents the type of API change
enum ApiChangeType {
  /// breaking change
  changeBreaking(isBreaking: true),

  /// non-breaking change
  changeCompatible(isBreaking: false),

  /// removal (breaking)
  remove(isBreaking: true),

  /// removal (non-breaking, rather rare)
  removeCompatible(isBreaking: false),

  /// non-breaking addition
  addCompatible(isBreaking: false),

  /// breaking addition (like adding a required parameter)
  addBreaking(isBreaking: true);

  final bool isBreaking;

  const ApiChangeType({required this.isBreaking});
}
