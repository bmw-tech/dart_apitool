import 'dart:io';
import 'package:path/path.dart' as p;
import '../utils/stdout_session.dart';

abstract class GitInteraction {
  /// Clones a git repository to the specified directory
  /// Returns the path to the package directory (which may be a subdirectory if path is specified)
  static Future<String> cloneRepositoryToDirectory(
    String gitUri,
    String targetDirectory,
    String? ref, // branch, tag, or commit
    String? path, // subdirectory path within the repository
    {
    StdoutSession? stdoutSession,
  }) async {
    final session = stdoutSession ?? StdoutSession();

    await session.writeln('Cloning git repository: $gitUri');

    // Always clone without specifying a branch first
    final cloneArgs = ['clone', gitUri, targetDirectory];

    final cloneResult = await Process.run('git', cloneArgs);
    if (cloneResult.exitCode != 0) {
      throw Exception('Failed to clone repository: ${cloneResult.stderr}');
    }

    // If ref is specified, checkout the specific ref (branch, tag, or commit)
    if (ref != null) {
      await session.writeln('Checking out ref: $ref');
      final checkoutResult = await Process.run(
        'git',
        ['checkout', ref],
        workingDirectory: targetDirectory,
      );
      if (checkoutResult.exitCode != 0) {
        throw Exception('Failed to checkout $ref: ${checkoutResult.stderr}');
      }
    }

    // Determine the final package directory
    final packageDirectory =
        path != null ? p.join(targetDirectory, path) : targetDirectory;

    // Verify that the package directory exists
    if (!await Directory(packageDirectory).exists()) {
      throw Exception('Package directory not found: $packageDirectory');
    }

    // Verify that it contains a pubspec.yaml
    final pubspecFile = File(p.join(packageDirectory, 'pubspec.yaml'));
    if (!await pubspecFile.exists()) {
      throw Exception(
          'No pubspec.yaml found in package directory: $packageDirectory');
    }

    await session.writeln('Successfully cloned to: $targetDirectory');
    if (path != null) {
      await session.writeln('Package directory: $packageDirectory');
    }

    return packageDirectory;
  }
}
