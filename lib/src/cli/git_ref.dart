/// Represents a parsed git reference from a package ref string
///
/// Handles parsing of git references in the format:
/// - git://https://github.com/user/repo
/// - git://https://github.com/user/repo:branch
/// - git://https://github.com/user/repo/path/to/package:branch
/// - git://git@github.com:user/repo
/// - git://git@github.com:user/repo:tag
/// - git://git@github.com:user/repo/path/to/package:tag
class GitRef {
  /// The git URI (without the git:// prefix, without the path, and without the branch/tag/commit)
  final String uri;

  /// The path within the repository (optional, for monorepos)
  final String? path;

  /// The branch, tag, or commit reference (optional)
  final String? ref;

  GitRef._({
    required this.uri,
    this.path,
    this.ref,
  });

  /// Creates a GitRef from a package reference string
  /// Returns null if the string is not a valid git reference
  static GitRef? fromPackageRef(String packageRefString) {
    if (!packageRefString.startsWith('git://')) {
      return null;
    }

    // Remove the git:// prefix
    final withoutScheme = packageRefString.substring(6);

    // Handle git://https://... format
    if (withoutScheme.startsWith('https://')) {
      return _parseHttpsFormat(withoutScheme);
    }

    // Handle SSH format like git@github.com:user/repo or git@github.com:user/repo:branch
    if (withoutScheme.contains('@')) {
      return _parseSshFormat(withoutScheme);
    }

    // Fallback: treat the whole thing as a URI without ref
    return GitRef._(uri: withoutScheme);
  }

  static GitRef _parseHttpsFormat(String withoutScheme) {
    // Regex to parse HTTPS git URLs with optional path and ref
    // Pattern: https://domain/user/repo(.git)?(/path/to/package)?(:ref)?
    final httpsPattern = RegExp(
        r'^(https://[^/]+/[^/]+/[^/:]+(?:\.git)?)((?:/[^:]+)?)?(?::(.+))?$');

    final match = httpsPattern.firstMatch(withoutScheme);
    if (match == null) {
      // Fallback: treat the whole thing as a URI without ref
      return GitRef._(uri: withoutScheme);
    }

    final uri = match.group(1)!; // https://domain/user/repo(.git)?
    final pathPart = match.group(2); // /path/to/package or null
    final ref = match.group(3); // ref or null

    // Remove leading slash from path if present, and handle empty strings
    final path = pathPart?.isNotEmpty == true && pathPart!.startsWith('/')
        ? pathPart.substring(1)
        : pathPart?.isNotEmpty == true
            ? pathPart
            : null;

    return GitRef._(
      uri: uri,
      path: path,
      ref: ref,
    );
  }

  static GitRef _parseSshFormat(String withoutScheme) {
    // Regex to parse SSH git URLs with optional path and ref
    // Pattern: git@host:user/repo(.git)?(/path/to/package)?(:ref)?
    final sshPattern = RegExp(
        r'^([^@]+@[^:]+:[^/:]+/[^/:]+(?:\.git)?)((?:/[^:]+)?)?(?::(.+))?$');

    final match = sshPattern.firstMatch(withoutScheme);
    if (match == null) {
      // Fallback for simple cases without ref or path
      return GitRef._(uri: withoutScheme);
    }

    final uri = match.group(1)!; // git@host:user/repo(.git)?
    final pathPart = match.group(2); // /path/to/package or null
    final ref = match.group(3); // ref or null

    // Remove leading slash from path if present, and handle empty strings
    final path = pathPart?.isNotEmpty == true && pathPart!.startsWith('/')
        ? pathPart.substring(1)
        : pathPart?.isNotEmpty == true
            ? pathPart
            : null;

    return GitRef._(
      uri: uri,
      path: path,
      ref: ref,
    );
  }

  /// Creates a string representation for internal use (e.g., in SourceItem)
  String toInternalString() {
    final pathPart = path != null ? '/$path' : '';
    return 'GIT:$uri$pathPart${ref != null ? ':$ref' : ':HEAD'}';
  }

  /// Creates a GitRef from an internal string representation
  static GitRef fromInternalString(String internalString) {
    if (!internalString.startsWith('GIT:')) {
      throw ArgumentError('Invalid internal git ref string: $internalString');
    }

    final withoutPrefix = internalString.substring(4); // Remove 'GIT:'

    // Find the last colon to separate ref from URI+path
    final lastColonIndex = withoutPrefix.lastIndexOf(':');
    if (lastColonIndex == -1) {
      throw ArgumentError('Invalid internal git ref string: $internalString');
    }

    final uriWithPath = withoutPrefix.substring(0, lastColonIndex);
    final refPart = withoutPrefix.substring(lastColonIndex + 1);
    final actualRef = refPart == 'HEAD' ? null : refPart;

    // Parse URI and path using regex
    String uri;
    String? path;

    if (uriWithPath.startsWith('https://')) {
      final httpsPattern =
          RegExp(r'^(https://[^/]+/[^/]+/[^/]+(?:\.git)?)((?:/.+)?)$');
      final match = httpsPattern.firstMatch(uriWithPath);
      if (match != null) {
        uri = match.group(1)!;
        final pathPart = match.group(2);
        path = pathPart?.isNotEmpty == true && pathPart!.startsWith('/')
            ? pathPart.substring(1)
            : pathPart?.isNotEmpty == true
                ? pathPart
                : null;
      } else {
        uri = uriWithPath;
        path = null;
      }
    } else if (uriWithPath.contains('@')) {
      final sshPattern =
          RegExp(r'^([^@]+@[^:]+:[^/]+/[^/]+(?:\.git)?)((?:/.+)?)$');
      final match = sshPattern.firstMatch(uriWithPath);
      if (match != null) {
        uri = match.group(1)!;
        final pathPart = match.group(2);
        path = pathPart?.isNotEmpty == true && pathPart!.startsWith('/')
            ? pathPart.substring(1)
            : pathPart?.isNotEmpty == true
                ? pathPart
                : null;
      } else {
        uri = uriWithPath;
        path = null;
      }
    } else {
      uri = uriWithPath;
      path = null;
    }

    return GitRef._(uri: uri, path: path, ref: actualRef);
  }

  @override
  String toString() {
    final pathPart = path != null ? '/$path' : '';
    if (ref != null) {
      return '$uri$pathPart:$ref';
    }
    return '$uri$pathPart';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GitRef &&
        other.uri == uri &&
        other.path == path &&
        other.ref == ref;
  }

  @override
  int get hashCode => Object.hash(uri, path, ref);
}
