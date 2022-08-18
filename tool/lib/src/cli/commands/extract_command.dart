import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:dart_apitool/src/storage/storage.dart';

import '../package_ref.dart';
import 'command_mixin.dart';

class ExtractCommand extends Command<int> with CommandMixin {
  @override
  String get description => 'Extracts the API from the given package ref.';

  @override
  String get name => 'extract';

  ExtractCommand() {
    argParser.addOption(
      'input',
      help: 'Input package ref. $packageRefExplanation',
      mandatory: true,
    );
    argParser.addOption(
      'output',
      help: 'Output file for the extracted Package API',
    );
  }

  @override
  Future<int> run() async {
    final packageRef = PackageRef(argResults!['input']);

    await prepare(packageRef);
    final packageApi = await analyze(packageRef);
    final jsonString =
        PackageApiStorage.packageApitoStorageJson(packageApi, pretty: true);
    final outFilePath = argResults!['output'] as String?;
    if (outFilePath != null) {
      final outFile = File(outFilePath);
      if (await outFile.exists()) {
        await outFile.delete();
      }
      await outFile.writeAsString(jsonString, mode: FileMode.write);
      stdout.writeln('Public API of "$packageRef" written to $outFilePath');
    } else {
      stdout.writeln(jsonString);
    }
    return 0;
  }
}
