import 'package:path/path.dart' as path;

/// representation of a package to copy
///
/// contains information needed to place package correctly
/// into temporary folder structure
class SourceItem {
  final String relativeDestinationDir;
  final String sourceDir;
  final bool isInCache;

  SourceItem({
    required this.sourceDir,
    required this.isInCache,
    this.relativeDestinationDir = '.',
  });

  String destinationPath({required String forPrefix}) {
    return path.normalize(path.join(forPrefix, relativeDestinationDir));
  }

  @override
  String toString() {
    return '{sourceDir: $sourceDir, relativeDestinationDir: $relativeDestinationDir }';
  }
}
