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
    this.relativeDestinationDir = '.',
    required this.isInCache,
  });

  factory SourceItem.forCommonPath({
    required String sourceDir,
    required String commonPath,
  }) {
    if (path.isWithin(commonPath, sourceDir)) {
      final commonRelativePath = path.relative(sourceDir, from: commonPath);
      return SourceItem(
        sourceDir: sourceDir,
        relativeDestinationDir: commonRelativePath,
        isInCache: false,
      );
    }
    return SourceItem(
      sourceDir: sourceDir,
      isInCache: false,
    );
  }

  String destinationPath({required String forPrefix}) {
    return path.normalize(path.join(forPrefix, relativeDestinationDir));
  }

  @override
  String toString() {
    return '{sourceDir: $sourceDir, relativeDestinationDir: $relativeDestinationDir }';
  }
}
