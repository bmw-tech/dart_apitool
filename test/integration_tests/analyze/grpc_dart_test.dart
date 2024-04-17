import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';

import '../helper/integration_test_helper.dart';

void main() {
  group('analyzer gets analyzed correctly', () {
    final packageGitUrl = 'https://github.com/grpc/grpc-dart.git';
    final packageGitRef = 'b05fafe77cffca15f56ca9bd33c5a51f6d2a7170';
    final retriever = GitPackageApiRetriever(
      packageGitUrl,
      packageGitRef,
    );
    late PackageApi packageApi;

    setUpAll(() async {
      packageApi = await retriever.retrieve();
    });

    test(
        "Detects 2 missing exports correctly (especially doesn't complain about 'ServerHandler')",
        () {
      final rootDeclarationsWithoutEntryPointsAndVisibleOutsideTests =
          packageApi.rootDeclarationsWithoutEntryPointsAndVisibleOutsideTests
              .toList();
      expect(
          rootDeclarationsWithoutEntryPointsAndVisibleOutsideTests.length, 2);
      expect(
          rootDeclarationsWithoutEntryPointsAndVisibleOutsideTests
              .any((decl) => decl.name == '\$1.Duration'),
          isTrue);
      expect(
          rootDeclarationsWithoutEntryPointsAndVisibleOutsideTests
              .any((decl) => decl.name == 'Any'),
          isTrue);
      expect(
          rootDeclarationsWithoutEntryPointsAndVisibleOutsideTests
              .any((decl) => decl.name == 'ServerHandler'),
          isFalse);
    });
  });
}
