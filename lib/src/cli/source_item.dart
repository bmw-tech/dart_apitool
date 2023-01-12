import 'package:path/path.dart' as path;

/// representation of a package to copy
///
/// contains information needed to place package correctly
/// into temporary folder structure
class SourceItem {
  final String relativeDestinationDir;
  final String sourceDir;

  SourceItem({
    required this.sourceDir,
    this.relativeDestinationDir = '.',
  });

  factory SourceItem.forCommonPath({
    required String sourceDir,
    required String commonPath,
  }) {
    final commonPathComponents = path.split(commonPath);
    final sourceDirComponents = path.split(sourceDir);
    if (sourceDirComponents.length > commonPathComponents.length) {
      String relativeDestinationDir = path
          .joinAll(sourceDirComponents.sublist(commonPathComponents.length));
      return SourceItem(
        sourceDir: sourceDir,
        relativeDestinationDir: relativeDestinationDir,
      );
    }
    return SourceItem(sourceDir: sourceDir);
  }

  String destinationPath({required String forPrefix}) {
    return path.normalize(path.join(forPrefix, relativeDestinationDir));
  }

  @override
  String toString() {
    return '{sourceDir: $sourceDir, relativeDestinationDir: $relativeDestinationDir }';
  }
}
