import 'package:args/command_runner.dart';
import 'package:release_util/release_util.dart';

void main(List<String> arguments) async {
  final runner = CommandRunner(
      'dart bin/release_util.dart', 'Releases a new version of dart_apitool')
    ..addCommand(ReleaseCommand());
  await runner.run(arguments);
}
