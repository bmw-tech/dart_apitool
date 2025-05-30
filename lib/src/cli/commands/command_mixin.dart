import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_apitool/api_tool.dart';
import 'package:path/path.dart' as p;
import 'package:pubspec_parse/pubspec_parse.dart';

import '../cli.dart';

/// mixin for all dart-apitool commands that provides common information and functionality
mixin CommandMixin {
  final packageRefExplanation = '''
Package reference can be one of:
- directory path pointing to a package on disk
  (e.g. /path/to/package)
- any package from pub
  (e.g. pub://package_name/version)
''';

  final includePathDependenciesExplanation = '''
OBSOLETE: Has no effect anymore.
 ''';

  static final String _flagNameForceUseFlutter = 'force-use-flutter';
  static final String _helpTextForceUseFlutter =
      'If present forces dart_apitool to use Flutter\n(instead of Dart if the project is Dart only)';

  void init(ArgParser argParser) {
    argParser.addFlag(
      _flagNameForceUseFlutter,
      help: _helpTextForceUseFlutter,
      defaultsTo: false,
      negatable: false,
    );
  }

  /// prepares given [ref]. This will create a dummy package that references the given [ref].
  /// If you use [analyze] with this result then it will take care to clean up
  /// everything (e.g. removing temp directory)
  Future<DummyRefPackage> prepare(
    ArgResults argResults,
    PackageRef ref,
  ) async {
    final forceUseFlutterTool =
        (argResults[_flagNameForceUseFlutter] as bool?) ?? false;

    final stdoutSession = StdoutSession();

    await stdoutSession.writeln('Preparing $ref');

    String refLines = '  ${ref.pubPackage}: ${ref.pubVersion ?? 'any'}';
    if (ref.isDirectoryPath) {
      await stdoutSession.writeln('  - Directory path');
      String sourceDir = ref.ref;
      if (sourceDir.endsWith(p.separator)) {
        sourceDir =
            sourceDir.substring(0, sourceDir.length - p.separator.length);
      }
      final packagePubspec = Pubspec.parse(
          await File(p.join(sourceDir, 'pubspec.yaml')).readAsString());
      final packageName = packagePubspec.name;
      refLines = '''
  $packageName:
    path: ${p.absolute(sourceDir)}
''';
    } else {
      await stdoutSession.writeln('  - Pub reference');
    }

    // 1. create temp directory
    final tempDirectory = await Directory.systemTemp.createTemp();

    // 2. create dummy dart project referencing [ref]
    final dummyPubspec = File(p.join(tempDirectory.path, 'pubspec.yaml'));
    dummyPubspec.createSync(recursive: true);
    dummyPubspec.writeAsStringSync('''
name: dummy_ref_package

version: 0.0.1

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
$refLines
''');

    // 3. run pub get
    await PubInteraction.runPubGet(
      tempDirectory.path,
      stdoutSession: stdoutSession,
      forceUseFlutterTool: forceUseFlutterTool,
    );

    String packagPath = ref.ref;
    if (ref.isPubRef) {
      packagPath = PubInteraction.getPackagePathInCache(
        ref.pubPackage!,
        ref.pubVersion,
      );
    }

    return DummyRefPackage(
      referencedPackagePath: packagPath,
      tempDirectoryPath: tempDirectory.path,
    );
  }

  /// Analyzes the given prepared Package [ref].
  /// [doMergeBaseClasses] defines if base classes should be merged into derived ones. This allows to remove private base classes from the list of interface declarations.
  /// [doAnalyzePlatformConstraints] defines if the platform constraints of the package shall be analyzed.
  Future<PackageApi> analyze(
    ArgResults argResults,
    DummyRefPackage preparedRef, {
    bool doAnalyzePlatformConstraints = true,
    bool doRemoveExample = true,
  }) async {
    final stdoutSession = StdoutSession();

    final packagePath = preparedRef.referencedPackagePath;
    final analyzerRootPath = preparedRef.tempDirectoryPath;

    await stdoutSession.writeln('Analyzing $packagePath');
    final analyzer = PackageApiAnalyzer(
      packagePath: packagePath,
      analyzerRootPath: analyzerRootPath,
      doAnalyzePlatformConstraints: doAnalyzePlatformConstraints,
    );
    return await analyzer.analyze();
  }

  /// If the prepared package contains anything that has to be cleaned up
  /// (like created temp directories) then [cleanUp] takes care of that
  Future cleanUp(DummyRefPackage preparedPackageRef) {
    stdout.writeln('Cleaning up');
    return Directory(preparedPackageRef.tempDirectoryPath)
        .delete(recursive: true);
  }
}
