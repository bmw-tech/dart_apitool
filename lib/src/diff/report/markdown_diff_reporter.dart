import 'dart:io';

import 'package:dart_apitool/api_tool_cli.dart';

import 'diff_reporter.dart';

const changeCodesReadMe =
    "https://github.com/bmw-tech/dart_apitool/blob/main/readme/change_codes.md";

class MarkdownDiffReporter extends DiffReporter {
  @override
  final String reporterName = 'Markdown Reporter';
  final PackageRef oldPackageRef, newPackageRef;
  final File outputFile;

  MarkdownDiffReporter({
    required this.oldPackageRef,
    required this.newPackageRef,
    required this.outputFile,
  });

  @override
  Future<void> generateReport(PackageApiDiffResult diffResult) async {
    final markdownReport = StringBuffer();
    markdownReport
      ..writeln('# API Changes Report')
      ..writeln()
      ..writeln('## ℹ️ API-Tool Info')
      ..writeln('Comparing $oldPackageRef vs $newPackageRef  ')
      ..writeln(
          'This report was generated using [dart_apitool](https://github.com/bmw-tech/dart_apitool) v${await getOwnVersion()} by [BMW Tech](https://github.com/bmw-tech).  ')
      ..writeln(
          'This report was created on ${DateTime.now().toUtc().toLocal()} UTC.')
      ..writeln()
      ..writeln('## Report')
      ..writeln(
          'To learn more about the detected changes, visit [GitHub Change Codes]($changeCodesReadMe)')
      ..writeln();

    void printChanges(bool breaking) {
      markdownReport
        ..writeln(
            '### ${breaking ? '🚨 BREAKING CHANGES' : '🆕 Non-Breaking Changes'}')
        ..writeln();

      final changes = _printApiChangeNode(diffResult.rootNode, breaking);
      markdownReport.writeln(changes ??
          (breaking
              ? 'No breaking changes! 🎉'
              : 'No non-breaking changes! 🎉'));

      markdownReport.writeln();
    }

    // Print the diffs
    if (diffResult.hasChanges) {
      printChanges(true); // Breaking changes
      printChanges(false); // Non-breaking changes
    } else {
      markdownReport
        ..writeln('### No Changes Detected')
        ..writeln('No changes detected!');
    }

    // Write the Markdown report to a file
    await outputFile.writeAsString(markdownReport.toString());

    print('Markdown report generated at ${outputFile.path}');
  }

  String? _printApiChangeNode(ApiChangeTreeNode node, bool breaking) {
    Map<String, dynamic> nodeToTree(ApiChangeTreeNode n,
        {String? labelOverride}) {
      final relevantChanges = n.changes.where((c) => c.isBreaking == breaking);
      final childNodes = n.children.values
          .map((value) => nodeToTree(value))
          .where((element) => element.isNotEmpty);
      final allChildren = [...relevantChanges, ...childNodes];
      return allChildren.isEmpty
          ? {}
          : {
              'label': labelOverride ??
                  (n.nodeDeclaration == null
                      ? ''
                      : getDeclarationNodeHeadline(n.nodeDeclaration!)),
              'children': allChildren
            };
    }

    final nodes = nodeToTree(node, labelOverride: 'Changelist:');

    if (nodes.isEmpty) {
      return null;
    }

    String generateMarkdownTree(Map<String, dynamic> node,
        {int currentLevel = 0}) {
      final parentIndentation = '    ' * currentLevel;
      final childIndentation = '    ' * (currentLevel + 1);
      final buffer = StringBuffer();

      buffer.writeln('$parentIndentation * ${node['label']}');

      for (final change in node['children']) {
        if (change is Map<String, dynamic> && change.containsKey('children')) {
          buffer.write(
              generateMarkdownTree(change, currentLevel: currentLevel + 1));
        } else {
          final changeEntry =
              '$childIndentation * **${change.changeDescription}** [(${change.changeCode.code})]($changeCodesReadMe#${change.changeCode.code.toLowerCase()})${change.isBreaking ? '' : change.type.requiresMinorBump ? ' (minor)' : ' (patch)'}';
          buffer.writeln(changeEntry);
        }
      }
      return buffer.toString();
    }

    return generateMarkdownTree(nodes);
  }
}
