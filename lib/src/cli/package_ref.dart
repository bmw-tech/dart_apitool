import 'dart:io';

/// representation of a package reference
///
/// a [PackageRef] can be:
/// - a directory path pointing to the sources of a package
/// - a file path pointing to a file containing an API model (extracted from an earlier run)
/// - a reference to pub (like pub://dart_apitool/0.1.2)
class PackageRef {
  /// the actual string of this reference
  final String ref;

  PackageRef(this.ref);

  /// determines if this reference referecences a package API model file
  bool get isPackageApiFile {
    try {
      return File(ref).existsSync();
    } catch (_) {
      return false;
    }
  }

  /// determines if this reference references a package directory
  bool get isDirectoryPath {
    try {
      return Directory(ref).existsSync();
    } catch (_) {
      return false;
    }
  }

  /// determines if this reference references a pub packaage
  bool get isPubRef {
    final uri = Uri.parse(ref);
    return uri.hasScheme && uri.scheme == 'pub';
  }

  /// (only valid if [isPubRef]) gets the package name from the pub ref
  String? get pubPackage {
    if (!isPubRef) {
      return null;
    }
    final uri = Uri.parse(ref);
    return uri.host;
  }

  /// (only valid if [isPubRef]) gets the package version from the pub ref
  String? get pubVersion {
    if (!isPubRef) {
      return null;
    }
    final uri = Uri.parse(ref);
    return uri.path.replaceAll('/', '');
  }

  @override
  String toString() {
    var kind = 'Unknown';
    if (isDirectoryPath) {
      kind = 'Directory';
    } else if (isPackageApiFile) {
      kind = 'Extracted Package API';
    } else if (isPubRef) {
      kind = 'Pub ref';
    }
    return '$ref ($kind)';
  }
}
