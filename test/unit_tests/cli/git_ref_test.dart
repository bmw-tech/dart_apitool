import 'package:test/test.dart';
import 'package:dart_apitool/src/cli/git_ref.dart';

void main() {
  group('GitRef', () {
    group('fromPackageRef', () {
      test('should return null for non-git references', () {
        expect(GitRef.fromPackageRef('pub://package_name'), isNull);
        expect(GitRef.fromPackageRef('/local/path'), isNull);
        expect(GitRef.fromPackageRef('https://github.com/user/repo'), isNull);
      });

      group('HTTPS format', () {
        test('should parse basic HTTPS git reference without branch', () {
          final gitRef =
              GitRef.fromPackageRef('git://https://github.com/user/repo');
          expect(gitRef, isNotNull);
          expect(gitRef!.uri, equals('https://github.com/user/repo'));
          expect(gitRef.path, isNull);
          expect(gitRef.ref, isNull);
        });

        test('should parse HTTPS git reference with branch', () {
          final gitRef =
              GitRef.fromPackageRef('git://https://github.com/user/repo:main');
          expect(gitRef, isNotNull);
          expect(gitRef!.uri, equals('https://github.com/user/repo'));
          expect(gitRef.path, isNull);
          expect(gitRef.ref, equals('main'));
        });

        test('should parse HTTPS git reference with .git suffix', () {
          final gitRef = GitRef.fromPackageRef(
              'git://https://github.com/google/protobuf.dart.git:commit');
          expect(gitRef, isNotNull);
          expect(gitRef!.uri,
              equals('https://github.com/google/protobuf.dart.git'));
          expect(gitRef.path, isNull);
          expect(gitRef.ref, equals('commit'));
        });

        test('should parse HTTPS git reference with .git suffix and path', () {
          final gitRef = GitRef.fromPackageRef(
              'git://https://github.com/google/protobuf.dart.git/protobuf:commit');
          expect(gitRef, isNotNull);
          expect(gitRef!.uri,
              equals('https://github.com/google/protobuf.dart.git'));
          expect(gitRef.path, equals('protobuf'));
          expect(gitRef.ref, equals('commit'));
        });

        test('should parse HTTPS git reference with path without .git', () {
          final gitRef = GitRef.fromPackageRef(
              'git://https://github.com/user/repo/path/to/package:main');
          expect(gitRef, isNotNull);
          expect(gitRef!.uri, equals('https://github.com/user/repo'));
          expect(gitRef.path, equals('path/to/package'));
          expect(gitRef.ref, equals('main'));
        });

        test('should parse long commit hash', () {
          final gitRef = GitRef.fromPackageRef(
              'git://https://github.com/google/protobuf.dart.git:4916e6f7d34443869c27d997749d4362870fd7ce');
          expect(gitRef, isNotNull);
          expect(gitRef!.uri,
              equals('https://github.com/google/protobuf.dart.git'));
          expect(gitRef.path, isNull);
          expect(
              gitRef.ref, equals('4916e6f7d34443869c27d997749d4362870fd7ce'));
        });
      });

      group('SSH format', () {
        test('should parse basic SSH git reference without branch', () {
          final gitRef =
              GitRef.fromPackageRef('git://git@github.com:user/repo');
          expect(gitRef, isNotNull);
          expect(gitRef!.uri, equals('git@github.com:user/repo'));
          expect(gitRef.path, isNull);
          expect(gitRef.ref, isNull);
        });

        test('should parse SSH git reference with branch', () {
          final gitRef =
              GitRef.fromPackageRef('git://git@github.com:user/repo:main');
          expect(gitRef, isNotNull);
          expect(gitRef!.uri, equals('git@github.com:user/repo'));
          expect(gitRef.path, isNull);
          expect(gitRef.ref, equals('main'));
        });

        test('should parse SSH git reference with path', () {
          final gitRef = GitRef.fromPackageRef(
              'git://git@github.com:user/repo/path/to/package:v1.0.0');
          expect(gitRef, isNotNull);
          expect(gitRef!.uri, equals('git@github.com:user/repo'));
          expect(gitRef.path, equals('path/to/package'));
          expect(gitRef.ref, equals('v1.0.0'));
        });
      });
    });

    group('toString', () {
      test('should create string representation without ref', () {
        final gitRef =
            GitRef.fromPackageRef('git://https://github.com/user/repo');
        expect(gitRef.toString(), equals('https://github.com/user/repo'));
      });

      test('should create string representation with ref', () {
        final gitRef =
            GitRef.fromPackageRef('git://https://github.com/user/repo:main');
        expect(gitRef.toString(), equals('https://github.com/user/repo:main'));
      });

      test('should create string representation with path and ref', () {
        final gitRef = GitRef.fromPackageRef(
            'git://https://github.com/user/repo/path/to/package:main');
        expect(gitRef.toString(),
            equals('https://github.com/user/repo/path/to/package:main'));
      });
    });

    group('toInternalString', () {
      test('should create internal string representation without ref', () {
        final gitRef =
            GitRef.fromPackageRef('git://https://github.com/user/repo');
        expect(gitRef!.toInternalString(),
            equals('GIT:https://github.com/user/repo:HEAD'));
      });

      test('should create internal string representation with ref', () {
        final gitRef =
            GitRef.fromPackageRef('git://https://github.com/user/repo:main');
        expect(gitRef!.toInternalString(),
            equals('GIT:https://github.com/user/repo:main'));
      });

      test('should create internal string representation with path and ref',
          () {
        final gitRef = GitRef.fromPackageRef(
            'git://https://github.com/user/repo/path/to/package:main');
        expect(gitRef!.toInternalString(),
            equals('GIT:https://github.com/user/repo/path/to/package:main'));
      });
    });

    group('fromInternalString', () {
      test('should parse internal string representation', () {
        final gitRef =
            GitRef.fromInternalString('GIT:https://github.com/user/repo:main');
        expect(gitRef.uri, equals('https://github.com/user/repo'));
        expect(gitRef.path, isNull);
        expect(gitRef.ref, equals('main'));
      });

      test('should parse internal string representation with HEAD', () {
        final gitRef =
            GitRef.fromInternalString('GIT:https://github.com/user/repo:HEAD');
        expect(gitRef.uri, equals('https://github.com/user/repo'));
        expect(gitRef.path, isNull);
        expect(gitRef.ref, isNull);
      });

      test('should parse internal string representation with path', () {
        final gitRef = GitRef.fromInternalString(
            'GIT:https://github.com/user/repo/path/to/package:main');
        expect(gitRef.uri, equals('https://github.com/user/repo'));
        expect(gitRef.path, equals('path/to/package'));
        expect(gitRef.ref, equals('main'));
      });

      test('should throw on invalid internal string', () {
        expect(() => GitRef.fromInternalString('invalid'), throwsArgumentError);
        expect(() => GitRef.fromInternalString('GIT:invalid'),
            throwsArgumentError);
      });
    });

    group('round-trip conversion', () {
      test('should maintain equality through toString and fromPackageRef', () {
        final testCases = [
          'git://https://github.com/user/repo',
          'git://https://github.com/user/repo:main',
          'git://https://github.com/user/repo/path/to/package:main',
          'git://git@github.com:user/repo:main',
          'git://git@github.com:user/repo/path/to/package:v1.0.0',
          'git://https://github.com/google/protobuf.dart.git:4916e6f7d34443869c27d997749d4362870fd7ce',
          'git://https://github.com/google/protobuf.dart.git/protobuf:commit',
        ];

        for (final testCase in testCases) {
          final gitRef = GitRef.fromPackageRef(testCase);
          expect(gitRef, isNotNull, reason: 'Failed to parse: $testCase');

          final roundTrip = GitRef.fromPackageRef('git://${gitRef.toString()}');
          expect(roundTrip, equals(gitRef),
              reason: 'Round-trip failed for: $testCase');
        }
      });

      test(
          'should maintain equality through toInternalString and fromInternalString',
          () {
        final testCases = [
          'git://https://github.com/user/repo',
          'git://https://github.com/user/repo:main',
          'git://https://github.com/user/repo/path/to/package:main',
          'git://git@github.com:user/repo:main',
          'git://git@github.com:user/repo/path/to/package:v1.0.0',
        ];

        for (final testCase in testCases) {
          final gitRef = GitRef.fromPackageRef(testCase);
          expect(gitRef, isNotNull, reason: 'Failed to parse: $testCase');

          final internalString = gitRef!.toInternalString();
          final roundTrip = GitRef.fromInternalString(internalString);
          expect(roundTrip, equals(gitRef),
              reason: 'Internal round-trip failed for: $testCase');
        }
      });
    });
  });
}
