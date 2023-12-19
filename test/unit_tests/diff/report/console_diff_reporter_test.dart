import 'package:dart_apitool/api_tool.dart';
import 'package:dart_apitool/src/cli/commands/version_check.dart';
import 'package:dart_apitool/src/diff/report/console_diff_reporter.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  group('ConsoleDiffReporter', () {
    late ConsoleDiffReporter reporter;
    final anyVersionCheckResult = VersionCheckResult.success(
      oldVersion: Version(0, 0, 0),
      newVersion: Version(0, 0, 0),
      explanation: '',
    );

    setUp(() {
      reporter = ConsoleDiffReporter();
    });

    PackageApiDiffResult createEmptyDiffResult() {
      return PackageApiDiffResult();
    }

    void addBreakingChange(
      PackageApiDiffResult diffResult, {
      ApiChangeCode changeCode = ApiChangeCode.ci01,
    }) {
      diffResult.addApiChange(ApiChange(
        changeCode: changeCode,
        changeDescription: 'Test breaking change: ${changeCode.name}',
        contextTrace: [],
        isExperimental: false,
        type: ApiChangeType.remove,
      ));
    }

    void addNonBreakingChange(
      PackageApiDiffResult diffResult, {
      ApiChangeCode changeCode = ApiChangeCode.ci02,
    }) {
      diffResult.addApiChange(ApiChange(
        changeCode: changeCode,
        changeDescription: 'Test non-breaking change: ${changeCode.name}',
        contextTrace: [],
        isExperimental: false,
        type: ApiChangeType.addCompatiblePatch,
      ));
    }

    test('Can be instantiated', () {
      // the setup would have failed already
      expect(reporter, isA<ConsoleDiffReporter>());
    });

    test('Can handle empty diff report', () {
      final diffResult = createEmptyDiffResult();
      expect(() => reporter.generateReport(diffResult, anyVersionCheckResult),
          returnsNormally);
    });
    test('Can handle diff report with only one breaking change', () {
      final diffResult = createEmptyDiffResult();
      addBreakingChange(diffResult, changeCode: ApiChangeCode.ci01);
      expect(() => reporter.generateReport(diffResult, anyVersionCheckResult),
          returnsNormally);
    });
    test('Can handle diff report with multiple breaking changes', () {
      final diffResult = createEmptyDiffResult();
      addBreakingChange(diffResult, changeCode: ApiChangeCode.ci01);
      addBreakingChange(diffResult, changeCode: ApiChangeCode.ci04);
      expect(() => reporter.generateReport(diffResult, anyVersionCheckResult),
          returnsNormally);
    });
    test('Can handle diff report with only one non-breaking change', () {
      final diffResult = createEmptyDiffResult();
      addNonBreakingChange(diffResult, changeCode: ApiChangeCode.ci02);
      expect(() => reporter.generateReport(diffResult, anyVersionCheckResult),
          returnsNormally);
    });
    test('Can handle diff report with multiple non-breaking changes', () {
      final diffResult = createEmptyDiffResult();
      addNonBreakingChange(diffResult, changeCode: ApiChangeCode.ci02);
      addNonBreakingChange(diffResult, changeCode: ApiChangeCode.ci05);
      expect(() => reporter.generateReport(diffResult, anyVersionCheckResult),
          returnsNormally);
    });
    test('Can handle diff report with breaking and non-breaking changes', () {
      final diffResult = createEmptyDiffResult();
      addBreakingChange(diffResult, changeCode: ApiChangeCode.ci01);
      addNonBreakingChange(diffResult, changeCode: ApiChangeCode.ci02);
      addBreakingChange(diffResult, changeCode: ApiChangeCode.ci04);
      addNonBreakingChange(diffResult, changeCode: ApiChangeCode.ci05);
      expect(() => reporter.generateReport(diffResult, anyVersionCheckResult),
          returnsNormally);
    });
  });
}
