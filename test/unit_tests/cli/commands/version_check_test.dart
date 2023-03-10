import 'package:dart_apitool/api_tool.dart';
import 'package:dart_apitool/src/cli/commands/version_check.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  PackageApi createTestPackageApi({
    required String packageVersion,
    SdkType sdkType = SdkType.flutter,
  }) {
    return PackageApi(
      packageName: 'test_package',
      packageVersion: packageVersion,
      packagePath: 'test_package',
      interfaceDeclarations: [],
      executableDeclarations: [],
      fieldDeclarations: [],
      typeAliasDeclarations: [],
      sdkType: sdkType,
      packageDependencies: [],
      minSdkVersion: Version.parse('2.10.5'),
      typeHierarchy: TypeHierarchy(types: {}),
    );
  }

  PackageApiDiffResult createDiffResult(
      {List<ApiChangeType> changeTypes = const []}) {
    final result = PackageApiDiffResult();
    for (final ct in changeTypes) {
      result.apiChanges.add(ApiChange(
        type: ct,
        changeCode: ApiChangeCode.cd01,
        changeDescription: '',
        contextTrace: [],
        isExperimental: false,
      ));
    }
    return result;
  }

  group('Version Check', () {
    test('is fine with breaking change and major version change', () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult: createDiffResult(changeTypes: [ApiChangeType.addBreaking]),
        oldPackageApi: createTestPackageApi(packageVersion: '1.0.0'),
        newPackageApi: createTestPackageApi(packageVersion: '2.0.0'),
        ignorePrerelease: true,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isTrue);
    });
    test('is NOT fine with breaking change and minor version change', () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult: createDiffResult(changeTypes: [ApiChangeType.addBreaking]),
        oldPackageApi: createTestPackageApi(packageVersion: '1.0.0'),
        newPackageApi: createTestPackageApi(packageVersion: '1.1.0'),
        ignorePrerelease: true,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isFalse);
    });
    test('is fine with non-breaking change and minor version change', () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult:
            createDiffResult(changeTypes: [ApiChangeType.addCompatibleMinor]),
        oldPackageApi: createTestPackageApi(packageVersion: '1.0.0'),
        newPackageApi: createTestPackageApi(packageVersion: '1.1.0'),
        ignorePrerelease: true,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isTrue);
    });
    test('is NOT fine with non-breaking change and patch version change', () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult:
            createDiffResult(changeTypes: [ApiChangeType.addCompatibleMinor]),
        oldPackageApi: createTestPackageApi(packageVersion: '1.0.0'),
        newPackageApi: createTestPackageApi(packageVersion: '1.0.1'),
        ignorePrerelease: true,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isFalse);
    });
    test('is fine with non-breaking (patch) change and patch version change',
        () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult:
            createDiffResult(changeTypes: [ApiChangeType.addCompatiblePatch]),
        oldPackageApi: createTestPackageApi(packageVersion: '1.0.0'),
        newPackageApi: createTestPackageApi(packageVersion: '1.0.1'),
        ignorePrerelease: true,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isTrue);
    });
    test('is fine with non-breaking (patch) change and minor version change',
        () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult:
            createDiffResult(changeTypes: [ApiChangeType.addCompatiblePatch]),
        oldPackageApi: createTestPackageApi(packageVersion: '1.0.0'),
        newPackageApi: createTestPackageApi(packageVersion: '1.1.0'),
        ignorePrerelease: true,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isTrue);
    });
    test('is fine with non-breaking (patch) change and major version change',
        () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult:
            createDiffResult(changeTypes: [ApiChangeType.addCompatiblePatch]),
        oldPackageApi: createTestPackageApi(packageVersion: '1.0.0'),
        newPackageApi: createTestPackageApi(packageVersion: '2.0.0'),
        ignorePrerelease: true,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isTrue);
    });
    test(
        'is fine with breaking change and only prerelease tag in version change',
        () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult: createDiffResult(changeTypes: [ApiChangeType.addBreaking]),
        oldPackageApi: createTestPackageApi(packageVersion: '2.0.0-dev01'),
        newPackageApi: createTestPackageApi(packageVersion: '2.0.1'),
        ignorePrerelease: true,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isTrue);
    });
    test('ignores prerelease tag if ignorePrerelease is set', () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult: createDiffResult(changeTypes: [ApiChangeType.addBreaking]),
        oldPackageApi: createTestPackageApi(packageVersion: '2.0.0'),
        newPackageApi: createTestPackageApi(packageVersion: '2.1.0-dev01'),
        ignorePrerelease: true,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isFalse);
    });
    test('if old and new version have prerelease set, nothing matters', () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult: createDiffResult(changeTypes: [ApiChangeType.addBreaking]),
        oldPackageApi: createTestPackageApi(packageVersion: '2.0.0-dev00'),
        newPackageApi: createTestPackageApi(packageVersion: '2.1.0-dev01'),
        ignorePrerelease: false,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isTrue);
    });
    test(
        'if old and new version have prerelease set, the base version still has to be the same or higher for the new package',
        () {
      bool versionChangeCheckResult = VersionCheck.versionChangeMatchesChanges(
        diffResult: createDiffResult(changeTypes: [ApiChangeType.addBreaking]),
        oldPackageApi: createTestPackageApi(packageVersion: '2.1.0-dev00'),
        newPackageApi: createTestPackageApi(packageVersion: '2.0.0-dev01'),
        ignorePrerelease: false,
        versionCheckMode: VersionCheckMode.fully,
      );
      expect(versionChangeCheckResult, isFalse);
    });
  });
}
