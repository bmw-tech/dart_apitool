import 'package:args/command_runner.dart';
import 'package:dart_apitool/api_tool.dart';

import '../package_ref.dart';
import 'command_mixin.dart';

class DiffCommand extends Command with CommandMixin {
  @override
  final name = "diff";
  @override
  final description = "Creates a diff of 2 given packages.";

  DiffCommand() {
    argParser.addOption(
      'old',
      mandatory: true,
      help: 'Old package reference. $packageRefExplanation',
    );
    argParser.addOption(
      'new',
      mandatory: true,
      help: 'New package reference. $packageRefExplanation',
    );
  }

  @override
  Future run() async {
    final oldPackageRef = PackageRef(argResults!['old']);
    final newPackageRef = PackageRef(argResults!['new']);

    await prepare(oldPackageRef);
    await prepare(newPackageRef);

    final oldPackageApi = await analyze(oldPackageRef);
    final newPackageApi = await analyze(newPackageRef);

    final differ = PackageApiDiffer();
    final diffResult =
        differ.diff(oldApi: oldPackageApi, newApi: newPackageApi);

    // for now just print the diffs
    if (diffResult.apiChanges.isNotEmpty) {
      final breakingChanges =
          diffResult.apiChanges.where((change) => change.type.isBreaking);
      final nonBreakingChanges =
          diffResult.apiChanges.where((change) => !change.type.isBreaking);
      if (breakingChanges.isEmpty) {
        print('No breaking changes!');
      } else {
        print('Breaking changes');
        for (var dr in breakingChanges) {
          print('- ${dr.changeDescription}');
        }
      }
      if (nonBreakingChanges.isEmpty) {
        print('No non-breaking changes');
      } else {
        print('Non-breaking changes');
        for (var dr in nonBreakingChanges) {
          print('- ${dr.changeDescription}');
        }
      }
    } else {
      print('No changes detected!');
    }
  }
}
