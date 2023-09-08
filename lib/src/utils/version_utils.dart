import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:yaml/yaml.dart';

Future<String> getOwnVersion() async {
  String? result;
  final mainFilePath = Platform.script.toFilePath();
  final pubspecFile =
      File(p.join(p.dirname(mainFilePath), '..', 'pubspec.yaml'));
  if (await pubspecFile.exists()) {
    final yamlContent = await pubspecFile.readAsString();
    final pubSpec = Pubspec.parse(yamlContent);
    result = pubSpec.version?.canonicalizedVersion;
  }
  if (result == null) {
    // if we are in a pub global environment we have to read our version from the pubspec.lock file
    final pubspecLockFile =
        File(p.join(p.dirname(mainFilePath), '..', 'pubspec.lock'));
    if (await pubspecLockFile.exists()) {
      final pubspecLockContent = await pubspecLockFile.readAsString();
      final pubspecLockDom = loadYaml(pubspecLockContent);
      result = pubspecLockDom['packages']['dart_apitool']['version'];
    }
  }
  if (result == null) {
    return 'UNKNOWN VERSION';
  }
  return result;
}
