import 'dart:convert';
import 'dart:io';

import '../../../api_tool_cli.dart';
import 'diff_reporter.dart';

class JsonDiffReporter extends DiffReporter {
  @override
  final String reporterName = 'JSON Reporter';
  final PackageRef oldPackageRef, newPackageRef;
  final File outputFile;

  JsonDiffReporter({
    required this.oldPackageRef,
    required this.newPackageRef,
    required this.outputFile,
  });

  @override
  Future<void> generateReport(PackageApiDiffResult diffResult) async {
    final jsonReport = <String, dynamic>{
      'reportName': 'API Changes Report',
      'apiToolInfo': {
        'toolName': 'dart_apitool',
        'toolVersion': await getOwnVersion(),
        'toolAuthor': 'BMW Tech',
        'generatedAt': DateTime.now().toUtc().toLocal().toString(),
        'oldRef': oldPackageRef.ref,
        'newRef': newPackageRef.ref
      },
      'report': {},
    };

    void addChanges(bool breaking) {
      final changes = _printApiChangeNode(diffResult.rootNode, breaking);
      if (changes != null) {
        jsonReport['report']
            [breaking ? 'breakingChanges' : 'nonBreakingChanges'] = changes;
      }
    }

    // Add the API changes
    if (diffResult.hasChanges) {
      addChanges(true); // Breaking changes
      addChanges(false); // Non-breaking changes
    } else {
      jsonReport['report']['noChangesDetected'] = true;
    }

    // Write the JSON report to a file
    await outputFile.writeAsString(jsonEncode(jsonReport));

    print('JSON report generated at ${outputFile.path}');
  }

  Map<String, dynamic>? _printApiChangeNode(
      ApiChangeTreeNode node, bool breaking) {
    Map<String, dynamic> nodeToMap(ApiChangeTreeNode n,
        {String? labelOverride}) {
      final relevantChanges = n.changes.where((c) => c.isBreaking == breaking);
      final changeList = relevantChanges
          .map((c) => {
                'changeDescription': c.changeDescription,
                'changeCode': c.changeCode.code,
                'isBreaking': c.isBreaking,
                'type': c.type.requiresMinorBump ? 'minor' : 'patch',
              })
          .toList();
      final childNodes = n.children.values
          .map((value) => nodeToMap(value))
          .where((element) => element.isNotEmpty);
      final allChildren = [...changeList, ...childNodes];
      return allChildren.isEmpty
          ? {}
          : {
              'label': labelOverride ??
                  (n.nodeDeclaration == null
                      ? ''
                      : getDeclarationNodeHeadline(n.nodeDeclaration!)),
              'children': allChildren,
            };
    }

    final nodes = nodeToMap(node,
        labelOverride: breaking ? 'BREAKING CHANGES' : 'Non-Breaking changes');

    return nodes.isEmpty ? null : nodes;
  }
}
