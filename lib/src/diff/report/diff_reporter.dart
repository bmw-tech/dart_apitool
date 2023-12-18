import 'package:dart_apitool/src/cli/commands/version_check.dart';

import '../../../api_tool.dart';

abstract class DiffReporter {
  String get reporterName;

  Future<void> generateReport(
    PackageApiDiffResult diffResult,
    VersionCheckResult? versionCheckResult,
  );
}
