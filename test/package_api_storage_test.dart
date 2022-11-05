import 'dart:convert';

import 'package:dart_apitool/api_tool.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

void main() {
  group('PackageApi storage tests', () {
    test('Storage v3 gets exported correctly', () {
      final typedJson =
          PackageApiStorage.packageApitoStorageJson(testPackage2Api);
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

final testPackage1Api = PackageApi(
  packageName: 'storage_test_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: [
    InterfaceDeclaration(
      name: 'StorageTestClass',
      isDeprecated: false,
      typeParameterNames: const ['T'],
      superTypeNames: const ['SuperType'],
      executableDeclarations: [
        ExecutableDeclaration(
            returnTypeName: 'String',
            name: 'getString',
            isDeprecated: false,
            isStatic: false,
            parameters: [
              ExecutableParameterDeclaration(
                isRequired: true,
                isNamed: true,
                name: 'input',
                isDeprecated: false,
                typeName: 'T',
              ),
              ExecutableParameterDeclaration(
                isRequired: true,
                isNamed: true,
                name: 'mode',
                isDeprecated: false,
                typeName: 'GetStringMode',
              ),
            ],
            typeParameterNames: ['T'],
            type: ExecutableType.method),
      ],
      fieldDeclarations: [
        FieldDeclaration(
          typeName: 'bool',
          name: 'printDebug',
          isDeprecated: false,
          isStatic: false,
        ),
      ],
      isRequired: false,
    )
  ],
  executableDeclarations: const [],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
);

final package1JsonString = '''
{
    "version": 1,
    "packageApi": {
        "packageName": "storage_test_package",
        "packageVersion": "1.0.0",
        "packagePath": ".",
        "interfaceDeclarations": [
            {
                "name": "StorageTestClass",
                "isDeprecated": false,
                "typeParameterNames": [
                    "T"
                ],
                "superTypeNames": [
                    "SuperType"
                ],
                "executableDeclarations": [
                    {
                        "returnTypeName": "String",
                        "name": "getString",
                        "isDeprecated": false,
                        "isStatic": false,
                        "parameters": [
                            {
                                "isRequired": true,
                                "isNamed": true,
                                "name": "input",
                                "isDeprecated": false,
                                "typeName": "T"
                            },
                            {
                                "isRequired": true,
                                "isNamed": true,
                                "name": "mode",
                                "isDeprecated": false,
                                "typeName": "GetStringMode"
                            }
                        ],
                        "typeParameterNames": [
                            "T"
                        ],
                        "type": "method"
                    }
                ],
                "fieldDeclarations": [
                    {
                        "typeName": "bool",
                        "name": "printDebug",
                        "isDeprecated": false,
                        "isStatic": false
                    }
                ]
            }
        ],
        "executableDeclarations": [],
        "fieldDeclarations": []
    }
}
''';

final testPackage2Api = PackageApi(
  packageName: 'storage_test_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: [
    InterfaceDeclaration(
      name: 'StorageTestClass',
      isDeprecated: false,
      typeParameterNames: const ['T'],
      superTypeNames: const ['SuperType'],
      executableDeclarations: [
        ExecutableDeclaration(
          returnTypeName: 'String',
          name: 'getString',
          isDeprecated: false,
          isStatic: false,
          parameters: [
            ExecutableParameterDeclaration(
              isRequired: true,
              isNamed: true,
              name: 'input',
              isDeprecated: false,
              typeName: 'T',
            ),
            ExecutableParameterDeclaration(
              isRequired: true,
              isNamed: true,
              name: 'mode',
              isDeprecated: false,
              typeName: 'GetStringMode',
            ),
          ],
          typeParameterNames: ['T'],
          type: ExecutableType.method,
          entryPoints: {},
        ),
      ],
      fieldDeclarations: [
        FieldDeclaration(
          typeName: 'bool',
          name: 'printDebug',
          isDeprecated: false,
          isStatic: false,
          entryPoints: {},
        ),
      ],
      entryPoints: {},
      isRequired: false,
    ),
  ],
  executableDeclarations: const [],
  fieldDeclarations: const [],
  typeAliasDeclarations: [
    TypeAliasDeclaration(
      name: 'name',
      aliasedTypeName: 'aliasedTypeName',
      isDeprecated: false,
      entryPoints: {
        'entrypoint.dart',
      },
    )
  ],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
);

final package2JsonString = '''
{
    "version": 2,
    "packageApi": {
        "packageName": "storage_test_package",
        "packageVersion": "1.0.0",
        "packagePath": ".",
        "interfaceDeclarations": [
            {
                "name": "StorageTestClass",
                "isDeprecated": false,
                "typeParameterNames": [
                    "T"
                ],
                "superTypeNames": [
                    "SuperType"
                ],
                "executableDeclarations": [
                    {
                        "returnTypeName": "String",
                        "name": "getString",
                        "isDeprecated": false,
                        "isStatic": false,
                        "parameters": [
                            {
                                "isRequired": true,
                                "isNamed": true,
                                "name": "input",
                                "isDeprecated": false,
                                "typeName": "T"
                            },
                            {
                                "isRequired": true,
                                "isNamed": true,
                                "name": "mode",
                                "isDeprecated": false,
                                "typeName": "GetStringMode"
                            }
                        ],
                        "typeParameterNames": [
                            "T"
                        ],
                        "type": "method",
                        "entryPoints": [
                        ]
                    }
                ],
                "fieldDeclarations": [
                    {
                        "typeName": "bool",
                        "name": "printDebug",
                        "isDeprecated": false,
                        "isStatic": false,
                        "entryPoints": [
                        ]
                    }
                ],
                "entryPoints": [
                ]

            }
        ],
        "executableDeclarations": [],
        "fieldDeclarations": [],
        "typeAliasDeclarations": [
            {
                "name": "name",
                "aliasedTypeName": "aliasedTypeName",
                "isDeprecated": false,
                "entryPoints": [
                    "entrypoint.dart"
                ]
            }
        ],
        "semantics": []
    }
}
''';
