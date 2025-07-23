import 'dart:io';

import 'git_ref.dart';

/// representation of a package reference
///
/// a [PackageRef] can be:
/// - a directory path pointing to the sources of a package
/// - a reference to pub (like pub://dart_apitool/0.1.2)
class PackageRef {
  /// the actual string of this reference
  final String ref;

  PackageRef(this.ref);

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

  /// determines if this reference references a git repository
  /// Formats:
  /// - git://some_ssh_git_ref
  /// - git://some_ssh_git_ref:`<branch, tag or commit>`
  /// - git://https://some_http_git_ref
  /// - git://https://some_http_git_ref:`<branch, tag or commit>`
  bool get isGitRef {
    return ref.startsWith('git://');
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
    final path = uri.path.replaceAll('/', '');
    if (path.isEmpty) {
      return null;
    }
    return path;
  }

  /// (only valid if [isGitRef]) gets the parsed git reference
  GitRef? get gitRef {
    if (!isGitRef) {
      return null;
    }
    return GitRef.fromPackageRef(ref);
  }

  /// (only valid if [isGitRef]) gets the git URI from the git ref
  /// Removes the git:// scheme and extracts the actual git URL
  String? get gitUri {
    return gitRef?.uri;
  }

  /// (only valid if [isGitRef]) gets the branch, tag, or commit from the git ref
  String? get gitRefString {
    return gitRef?.ref;
  }

  @override
  String toString() {
    var kind = 'Unknown';
    if (isDirectoryPath) {
      kind = 'Directory';
    } else if (isPubRef) {
      kind = 'Pub ref';
    } else if (isGitRef) {
      kind = 'Git ref';
    }
    return '$ref ($kind)';
  }
}
