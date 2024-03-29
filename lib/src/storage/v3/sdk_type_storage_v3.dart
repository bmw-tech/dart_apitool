import '../../model/sdk_type.dart';

/// represents the type of the SDK
enum SdkTypeStorageV3 {
  /// Flutter SDK
  flutter,

  /// Dart SDK
  dart,

  /// Unknown SDK (mostly used by old storage models that didn't contain that information)
  unknown;

  /// returns the matching [SdkTypeStorageV3] from the model storage
  static SdkTypeStorageV3 fromSdkType(SdkType sdkType) {
    switch (sdkType) {
      case SdkType.flutter:
        return SdkTypeStorageV3.flutter;
      case SdkType.dart:
        return SdkTypeStorageV3.dart;
      case SdkType.unknown:
        return SdkTypeStorageV3.unknown;
    }
  }
}
