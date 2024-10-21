import 'package:args/command_runner.dart';
import 'package:ci_util/src/check_lower_bound_dependencies_command.dart';

CommandRunner buildCommandRunner() {
  return CommandRunner('ci_util', 'CI utilities for dart_apitool')..addCommand(CheckLowerBoundDependenciesCommand());
}

void main(List<String> arguments) async {
  final runner = buildCommandRunner();
  await runner.run(arguments);
}
