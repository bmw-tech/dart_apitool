import 'package_ref.dart';

/// represents a prepared package ref
/// this includes the actual [packageRef] and [tempDirectory] if the preparation had to create
/// a temporary directory
class PreparedPackageRef {
  final PackageRef packageRef;
  final String? tempDirectory;

  PreparedPackageRef({
    required this.packageRef,
    this.tempDirectory,
  });
}
