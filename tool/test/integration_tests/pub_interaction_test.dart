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
      expect(Directory(packagePath).existsSync(), isTrue);
      expect(File(path.join(packagePath, 'pubspec.yaml')).existsSync(), isTrue);
    });
  });
}
