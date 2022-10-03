/// represents the type of the SDK
enum SdkType {
  /// Flutter SDK
  flutter,

  /// Dart SDK
  dart,

  /// Unknown SDK (mostly used by old storage models that didn't contain that information)
  unknown,
}
