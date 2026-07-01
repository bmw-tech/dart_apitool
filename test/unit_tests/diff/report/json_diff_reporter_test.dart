import 'dart:convert';
import 'dart:io';

import 'package:dart_apitool/api_tool_cli.dart';
import 'package:dart_apitool/src/cli/commands/version_check.dart';
import 'package:dart_apitool/src/diff/report/json_diff_reporter.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import 'package:mocktail/mocktail.dart';

class MockFile extends Mock implements File {}

void main() {
  group('JsonDiffReporter', () {
    late JsonDiffReporter reporter;
    final anyVersionCheckResult = VersionCheckResult.success(
      oldVersion: Version(1, 0, 0),
      newVersion: Version(2, 0, 0),
      explanation: '',
    );
    final oldPackageRef = PackageRef('pub://package/1.0.0');
    final newPackageRef = PackageRef('pub://package/2.0.0');
    late MockFile mockFile;
    late StringBuffer collectedFileContent;

    setUp(() {
      collectedFileContent = StringBuffer();
      mockFile = MockFile();
      reporter = JsonDiffReporter(
        oldPackageRef: oldPackageRef,
        newPackageRef: newPackageRef,
        outputFile: mockFile,
      );
      when(() => mockFile.writeAsString(any())).thenAnswer((invocation) async {
        collectedFileContent.write(invocation.positionalArguments.first);
        return mockFile;
      });
      when(() => mockFile.path).thenReturn('mocked_file_path.json');
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
      ApiChangeType changeType = ApiChangeType.addCompatiblePatch,
    }) {
      diffResult.addApiChange(ApiChange(
        changeCode: changeCode,
        changeDescription: 'Test non-breaking change: ${changeCode.name}',
        contextTrace: [],
        isExperimental: false,
        type: changeType,
      ));
    }

    test('Can be instantiated', () {
      // the setup would have failed already
      expect(reporter, isA<JsonDiffReporter>());
    });

    test('Can handle empty diff report', () async {
      final diffResult = createEmptyDiffResult();
      await reporter.generateReport(diffResult, anyVersionCheckResult);
      final jsonReport = jsonDecode(collectedFileContent.toString());
      expect(jsonReport['report']['noChangesDetected'], isTrue);
    });
    test('Can handle diff report with only one breaking change', () async {
      final diffResult = createEmptyDiffResult();
      addBreakingChange(diffResult, changeCode: ApiChangeCode.ci01);
      await reporter.generateReport(diffResult, anyVersionCheckResult);
      final jsonReport = jsonDecode(collectedFileContent.toString());
      expect(jsonReport['report']['breakingChanges'], isNotNull);
      expect(jsonReport['report']['breakingChanges']['children'].length, 1);
      expect(
          jsonReport['report']['breakingChanges']['children']
              .single['changeCode'],
          ApiChangeCode.ci01.code);
      expect(jsonReport['report']['breakingChanges']['children'].single['type'],
          'major');
    });
    test('Can handle diff report with multiple breaking changes', () async {
      final diffResult = createEmptyDiffResult();
      addBreakingChange(diffResult, changeCode: ApiChangeCode.ci01);
      addBreakingChange(diffResult, changeCode: ApiChangeCode.ci04);
      await reporter.generateReport(diffResult, anyVersionCheckResult);
      final jsonReport = jsonDecode(collectedFileContent.toString());
      expect(jsonReport['report']['breakingChanges'], isNotNull);
      expect(jsonReport['report']['breakingChanges']['children'].length, 2);
      expect(
          jsonReport['report']['breakingChanges']['children'][0]['changeCode'],
          ApiChangeCode.ci01.code);
      expect(
          jsonReport['report']['breakingChanges']['children'][1]['changeCode'],
          ApiChangeCode.ci04.code);
    });
    test('Can handle diff report with only one non-breaking change', () async {
      final diffResult = createEmptyDiffResult();
      addNonBreakingChange(diffResult, changeCode: ApiChangeCode.ci02);
      await reporter.generateReport(diffResult, anyVersionCheckResult);
      final jsonReport = jsonDecode(collectedFileContent.toString());
      expect(jsonReport['report']['nonBreakingChanges'], isNotNull);
      expect(jsonReport['report']['nonBreakingChanges']['children'].length, 1);
      expect(
          jsonReport['report']['nonBreakingChanges']['children']
              .single['changeCode'],
          ApiChangeCode.ci02.code);
      expect(
          jsonReport['report']['nonBreakingChanges']['children'].single['type'],
          'patch');
    });
    test('Can handle diff report with multiple non-breaking changes', () async {
      final diffResult = createEmptyDiffResult();
      addNonBreakingChange(diffResult, changeCode: ApiChangeCode.ci02);
      addNonBreakingChange(diffResult,
          changeCode: ApiChangeCode.ci05,
          changeType: ApiChangeType.addCompatibleMinor);
      await reporter.generateReport(diffResult, anyVersionCheckResult);
      final jsonReport = jsonDecode(collectedFileContent.toString());
      expect(jsonReport['report']['nonBreakingChanges'], isNotNull);
      expect(jsonReport['report']['nonBreakingChanges']['children'].length, 2);
      expect(
          jsonReport['report']['nonBreakingChanges']['children'][0]
              ['changeCode'],
          ApiChangeCode.ci02.code);
      expect(
          jsonReport['report']['nonBreakingChanges']['children'][1]
              ['changeCode'],
          ApiChangeCode.ci05.code);
      expect(jsonReport['report']['nonBreakingChanges']['children'][0]['type'],
          'patch');
      expect(jsonReport['report']['nonBreakingChanges']['children'][1]['type'],
          'minor');
    });
    test('Can handle diff report with breaking and non-breaking changes',
        () async {
      final diffResult = createEmptyDiffResult();
      addBreakingChange(diffResult, changeCode: ApiChangeCode.ci01);
      addNonBreakingChange(diffResult, changeCode: ApiChangeCode.ci02);
      addBreakingChange(diffResult, changeCode: ApiChangeCode.ci04);
      addNonBreakingChange(diffResult, changeCode: ApiChangeCode.ci05);

      await reporter.generateReport(diffResult, anyVersionCheckResult);
      final jsonReport = jsonDecode(collectedFileContent.toString());
      expect(jsonReport['report']['breakingChanges'], isNotNull);
      expect(jsonReport['report']['breakingChanges']['children'].length, 2);
      expect(
          jsonReport['report']['breakingChanges']['children'][0]['changeCode'],
          ApiChangeCode.ci01.code);
      expect(
          jsonReport['report']['breakingChanges']['children'][1]['changeCode'],
          ApiChangeCode.ci04.code);
      expect(jsonReport['report']['nonBreakingChanges'], isNotNull);
      expect(jsonReport['report']['nonBreakingChanges']['children'].length, 2);
      expect(
          jsonReport['report']['nonBreakingChanges']['children'][0]
              ['changeCode'],
          ApiChangeCode.ci02.code);
      expect(
          jsonReport['report']['nonBreakingChanges']['children'][1]
              ['changeCode'],
          ApiChangeCode.ci05.code);
    });
  });
}
