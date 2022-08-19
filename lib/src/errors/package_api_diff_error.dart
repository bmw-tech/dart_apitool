/// Error that gets thrown when an Error happens during diffing two [PackageApi]s
class PackageApiDiffError extends Error {
  final String message;

  PackageApiDiffError({required this.message});

  @override
  String toString() {
    return message;
  }
}
