import 'package:pubspec_parse/pubspec_parse.dart';

/// Utilities for package-level decisions shared by CLI, tooling, and analysis.
abstract class PackageTooling {
  /// Returns true if [pubSpec] describes a Flutter package.
  static bool isFlutterPackage(Pubspec pubSpec) {
    return pubSpec.flutter != null ||
        pubSpec.dependencies.containsKey('flutter');
  }
}
