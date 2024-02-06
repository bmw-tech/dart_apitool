import 'dart:convert';

import 'package:dart_apitool/api_tool.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  group('PackageApi storage tests', () {
    test('Storage v3 gets exported correctly', () {
      final typedJson = PackageApiStorage.packageApitoStorageJson(
        testPackageApi,
      );
      final json = jsonDecode(typedJson);

      expect(json['version'], 3);
      final packageApiJson = json['packageApi'];
      expect(packageApiJson, isNotNull);
      expect(packageApiJson['packageName'], 'storage_test_package');
      expect(packageApiJson['packageVersion'], '1.0.0');
      expect(packageApiJson['packagePath'], '.');
      final interfaceDeclarationsJson = packageApiJson['interfaceDeclarations'];
      expect(interfaceDeclarationsJson, isNotNull);
      final interfaceDeclarationJson = interfaceDeclarationsJson.first;
      expect(interfaceDeclarationJson, isNotNull);
      expect(interfaceDeclarationJson['name'], 'StorageTestClass');
      expect(interfaceDeclarationJson['isDeprecated'], false);
      expect(interfaceDeclarationJson['isSealed'], false,
          reason: 'isSealed should be false for StorageTestClass');
      expect(interfaceDeclarationJson['typeParameterNames'], ['T']);
      expect(interfaceDeclarationJson['superTypeNames'], ['SuperType']);
      final classExecutableDeclarationsJson =
          interfaceDeclarationJson['executableDeclarations'];
      expect(classExecutableDeclarationsJson, isNotNull);
      final classExecutableDeclaration = classExecutableDeclarationsJson.first;
      expect(classExecutableDeclaration, isNotNull);
      expect(classExecutableDeclaration['returnTypeName'], 'String');
      expect(classExecutableDeclaration['name'], 'getString');
      expect(classExecutableDeclaration['isDeprecated'], false);
      expect(classExecutableDeclaration['isStatic'], false);
      expect(classExecutableDeclaration['typeParameterNames'], ['T']);
      expect(classExecutableDeclaration['type'], 'method');
      final executableParameterDeclarations =
          classExecutableDeclaration['parameters'];
      expect(executableParameterDeclarations, isNotNull);
      expect(executableParameterDeclarations.length, 2);
      final firstExecutableParameterDeclaration =
          executableParameterDeclarations[0];
      expect(firstExecutableParameterDeclaration, isNotNull);
      expect(firstExecutableParameterDeclaration['isRequired'], true);
      expect(firstExecutableParameterDeclaration['isNamed'], true);
      expect(firstExecutableParameterDeclaration['name'], 'input');
      expect(firstExecutableParameterDeclaration['isDeprecated'], false);
      expect(firstExecutableParameterDeclaration['typeName'], 'T');
      final secondExecutableParameterDeclaration =
          executableParameterDeclarations[1];
      expect(secondExecutableParameterDeclaration, isNotNull);
      expect(secondExecutableParameterDeclaration['isRequired'], true);
      expect(secondExecutableParameterDeclaration['isNamed'], true);
      expect(secondExecutableParameterDeclaration['name'], 'mode');
      expect(secondExecutableParameterDeclaration['isDeprecated'], false);
      expect(secondExecutableParameterDeclaration['typeName'], 'GetStringMode');
      final classFieldDeclarations =
          interfaceDeclarationJson['fieldDeclarations'];
      expect(classFieldDeclarations, isNotNull);
      final classFieldDeclaration = classFieldDeclarations.first;
      expect(classFieldDeclaration, isNotNull);
      expect(classFieldDeclaration['typeName'], 'bool');
      expect(classFieldDeclaration['name'], 'printDebug');
      expect(classFieldDeclaration['isDeprecated'], false);
      expect(classFieldDeclaration['isStatic'], false);
      final sealedInterfaceDeclarationJson = interfaceDeclarationsJson[1];
      expect(sealedInterfaceDeclarationJson, isNotNull);
      expect(sealedInterfaceDeclarationJson['name'], 'SealedStorageTestClass');
      expect(sealedInterfaceDeclarationJson['isSealed'], true,
          reason: 'isSealed should be true for SealedStorageTestClass');
      final typeAliasDeclarationsJson = packageApiJson['typeAliasDeclarations'];
      expect(typeAliasDeclarationsJson, isNotNull);
      final typeAliasDeclaration = typeAliasDeclarationsJson.first;
      expect(typeAliasDeclaration['name'], 'name');
      expect(typeAliasDeclaration['aliasedTypeName'], 'aliasedTypeName');
      expect(typeAliasDeclaration['isDeprecated'], false);
      expect(packageApiJson['sdkType'], isNotNull);
      expect(packageApiJson['minSdkVersion'], isNotNull);
    });
  });
}

final testPackageApi = PackageApi(
  packageName: 'storage_test_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: [
    InterfaceDeclaration(
      name: 'StorageTestClass',
      isDeprecated: false,
      isExperimental: false,
      isSealed: false,
      isAbstract: false,
      typeParameterNames: const ['T'],
      superTypeNames: const {'SuperType'},
      executableDeclarations: [
        ExecutableDeclaration(
          returnTypeName: 'String',
          returnTypeFullLibraryName: null,
          name: 'getString',
          isDeprecated: false,
          isExperimental: false,
          isStatic: false,
          parameters: [
            ExecutableParameterDeclaration(
              isRequired: true,
              isNamed: true,
              name: 'input',
              isDeprecated: false,
              isExperimental: false,
              typeName: 'T',
              typeFullLibraryName: null,
              relativePath: '',
            ),
            ExecutableParameterDeclaration(
              isRequired: true,
              isNamed: true,
              name: 'mode',
              isDeprecated: false,
              isExperimental: false,
              typeName: 'GetStringMode',
              typeFullLibraryName: null,
              relativePath: '',
            ),
          ],
          typeParameterNames: ['T'],
          type: ExecutableType.method,
          entryPoints: {},
          relativePath: '',
        ),
      ],
      fieldDeclarations: [
        FieldDeclaration(
          typeName: 'bool',
          name: 'printDebug',
          isDeprecated: false,
          isExperimental: false,
          isStatic: false,
          entryPoints: {},
          relativePath: '',
          isReadable: true,
          isWriteable: true,
        ),
      ],
      entryPoints: {},
      typeUsages: {},
      relativePath: '',
    ),
    InterfaceDeclaration(
      name: 'SealedStorageTestClass',
      isDeprecated: false,
      isExperimental: false,
      isSealed: true,
      isAbstract: false,
      typeParameterNames: const [],
      superTypeNames: const {'SuperType'},
      executableDeclarations: [],
      fieldDeclarations: [],
      typeUsages: {},
      relativePath: '',
      entryPoints: {},
    ),
  ],
  executableDeclarations: const [],
  fieldDeclarations: const [],
  typeAliasDeclarations: [
    TypeAliasDeclaration(
      name: 'name',
      aliasedTypeName: 'aliasedTypeName',
      isDeprecated: false,
      isExperimental: false,
      entryPoints: {
        'entrypoint.dart',
      },
      relativePath: '',
    )
  ],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
  typeHierarchy: TypeHierarchy.empty(),
);
