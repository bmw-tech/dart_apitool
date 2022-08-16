import 'dart:io';

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
    if (diffResult.hasChanges) {
      final breakingChanges = _printApiChangeNode(diffResult.rootNode, true);
      if (breakingChanges == null) {
        stdout.writeln('No breaking changes!');
      } else {
        stdout.writeln('BREAKING CHANGES:');
        stdout.write(breakingChanges);
      }
      final nonBreakingChanges =
          _printApiChangeNode(diffResult.rootNode, false);
      if (nonBreakingChanges == null) {
        stdout.writeln('No non-breaking changes!');
      } else {
        stdout.writeln('Non-Breaking changes');
        stdout.write(nonBreakingChanges);
      }
    } else {
      stdout.writeln('No changes detected!');
    }
  }

  String? _printApiChangeNode(ApiChangeTreeNode node, bool breaking,
      [int level = 0]) {
    final currentOutput = StringBuffer();
    bool headlinePrinted = false;

    String getIndent(int level) {
      if (level < 0) {
        return '';
      }
      return List<String>.filled(level * 4, ' ').join('');
    }

    void ensureHeadline() {
      if (headlinePrinted) {
        return;
      }
      if (node.nodeDeclaration != null) {
        currentOutput.write(getIndent(level));
        currentOutput.writeln(node.nodeDeclaration!.name);
      }
      headlinePrinted = true;
    }

    for (final child in node.children.values) {
      final childOutput = _printApiChangeNode(child, breaking, level + 1);
      if (childOutput != null) {
        ensureHeadline();
        currentOutput.write(childOutput);
      }
    }
    final filteredChanges =
        node.changes.where((change) => change.type.isBreaking == breaking);
    if (filteredChanges.isNotEmpty) {
      for (final change in filteredChanges) {
        ensureHeadline();
        currentOutput.write(getIndent(level));
        currentOutput.write('- ');
        currentOutput.writeln(change.changeDescription);
      }
    }
    return currentOutput.isEmpty ? null : currentOutput.toString();
  }
}
