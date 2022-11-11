import 'package:pubspec_parse/pubspec_parse.dart';

import '../../model/model.dart';

abstract class PackageDependenciesHelper {
  static List<PackageDependency> getPackageDependencies(Pubspec pubspec) {
    final dependencies = <PackageDependency>[];
    // only consider hosted dependencies
    dependencies.addAll(
      pubspec.dependencies.entries
          .where((entry) => entry.value is HostedDependency)
          .map(
        (entry) {
          final dependency = entry.value as HostedDependency;
          return PackageDependency(
            packageName: entry.key,
            packageVersion: dependency.version.toString(),
          );
        },
      ),
    );
    return dependencies;
  }
}
