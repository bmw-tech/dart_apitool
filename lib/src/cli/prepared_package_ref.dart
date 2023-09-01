import 'package:path/path.dart' as path;

import 'package_ref.dart';

/// represents a prepared package ref
/// this includes the actual [packageRef] and [tempDirectory] if the preparation had to create
/// a temporary directory
class PreparedPackageRef {
  final String packageName;
  final PackageRef packageRef;
  final String? tempDirectory;
  final String? packageRelativePath;

  String? get packageDirectory =>
      tempDirectory != null && packageRelativePath != null
          ? path.normalize(path.join(tempDirectory!, packageRelativePath))
          : tempDirectory;

  PreparedPackageRef({
    required this.packageName,
    required this.packageRef,
    this.tempDirectory,
    this.packageRelativePath,
  });
}
