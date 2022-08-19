import 'dart:io';

class PackageRef {
  final String ref;

  PackageRef(this.ref);

  bool get isPackageApiFile {
    return File(ref).existsSync();
  }

  bool get isDirectoryPath {
    return Directory(ref).existsSync();
  }

  bool get isPubRef {
    final uri = Uri.parse(ref);
    return uri.hasScheme && uri.scheme == 'pub';
  }

  String? get pubPackage {
    if (!isPubRef) {
      return null;
    }
    final uri = Uri.parse(ref);
    return uri.host;
  }

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
