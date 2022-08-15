import 'dart:io';

import 'package:dart_apitool/src/pub_interaction.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as path;

void main() {
  group('Pub Interaction', () {
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
  });
}
