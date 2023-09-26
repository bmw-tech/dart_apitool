import '../../../api_tool.dart';

abstract class DiffReporter {
  String get reporterName;

  Future<void> generateReport(PackageApiDiffResult diffResult);
}
