import 'package:pubspec_parse/pubspec_parse.dart';

import '../../model/model.dart';

abstract class PackageDependenciesHelper {
  static List<PackageDependency> getPackageDependencies(Pubspec pubspec) {
    final dependencies = <PackageDependency>[];
    // only consider hosted dependencies
    dependencies.addAll(
      pubspec.dependencies.entries
          .where((entry) =>
              entry.value is HostedDependency ||
              entry.value is PathDependency ||
              entry.value is GitDependency)
          .map(
        (entry) {
          final dependency = entry.value;
          if (dependency is HostedDependency) {
            return PackageDependency(
              packageName: entry.key,
              packageVersion: dependency.version.toString(),
            );
          } else {
            return PackageDependency(
                packageName: entry.key, packageVersion: null);
          }
        },
      ),
    );
    return dependencies;
  }
}
