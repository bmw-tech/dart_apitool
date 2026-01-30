import 'dart:io';

import 'package:dart_apitool/api_tool.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('Pub Interaction', () {
    // Cleanup for standard test
    setUp(() async {
      await PubInteraction.removePackageFromCache('every_test', '1.0.0');
    });
    tearDown(() async {
      await PubInteraction.removePackageFromCache('every_test', '1.0.0');
    });

    test('Install package to cache works', () async {
      final packagePath =
          await PubInteraction.installPackageToCache('every_test', '1.0.0');
      expect(packagePath, isNotNull);
      expect(Directory(packagePath).existsSync(), isTrue,
          reason:
              'Check if installed package is at the expected location ($packagePath)');
      expect(File(path.join(packagePath, 'pubspec.yaml')).existsSync(), isTrue,
          reason:
              'Check if the package path contains a pubspec.yaml which is an indication for a legit package.');
    });

    test(
        'Install package to cache works for pre-release versions containing a hyphen',
        () async {
      const packageName = 'genkit_firebase_ai';
      const version = '0.0.1-dev.1';

      await PubInteraction.removePackageFromCache(packageName, version);
      try {
        await PubInteraction.installPackageToCache(packageName, version);

        final packages =
            PubInteraction.getAllPackageVersionsForPackageInCache(packageName);
        expect(packages, isNotEmpty);
      } finally {
        await PubInteraction.removePackageFromCache(packageName, version);
      }
    });
  });
}
