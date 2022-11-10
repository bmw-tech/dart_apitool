part of 'package_api_differ_test.dart';

final simpleClassA = InterfaceDeclaration(
  name: 'ClassA',
  isDeprecated: false,
  typeParameterNames: const [],
  superTypeNames: const [],
  executableDeclarations: const [
    ExecutableDeclaration(
      returnTypeName: 'ClassA',
      name: 'ClassA',
      isDeprecated: false,
      parameters: [],
      typeParameterNames: [],
      type: ExecutableType.constructor,
      isStatic: false,
    ),
  ],
  fieldDeclarations: const [],
  isRequired: false,
);
final simpleClassB = InterfaceDeclaration(
  name: 'ClassB',
  isDeprecated: false,
  typeParameterNames: const [],
  superTypeNames: const [],
  executableDeclarations: const [
    ExecutableDeclaration(
      returnTypeName: 'ClassB',
      name: 'ClassB',
      isDeprecated: false,
      parameters: [],
      typeParameterNames: [],
      type: ExecutableType.constructor,
      isStatic: false,
    ),
  ],
  fieldDeclarations: const [],
  isRequired: false,
);

final packageClassAApi = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: [
    simpleClassA,
  ],
  executableDeclarations: const [],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
// Package ClassA variations
final packageClassADeprecatedApi = packageClassAApi.copyWith(
  interfaceDeclarations: packageClassAApi.interfaceDeclarations
      .map((cd) => cd.copyWith(isDeprecated: true))
      .toList(),
);
final packageClassAWithTypeParameterTApi = packageClassAApi.copyWith(
  interfaceDeclarations: packageClassAApi.interfaceDeclarations
      .map((cd) => cd.copyWith(typeParameterNames: ['T']))
      .toList(),
);
final packageClassAWithTypeParameterRApi = packageClassAApi.copyWith(
  interfaceDeclarations: packageClassAApi.interfaceDeclarations
      .map((cd) => cd.copyWith(typeParameterNames: ['R']))
      .toList(),
);
final packageClassAApiEntryPointA = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: [
    simpleClassA.copyWith(
      entryPoints: {
        'a.dart',
      },
    ),
  ],
  executableDeclarations: const [],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
final packageClassAApiEntryPointB = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: [
    simpleClassA.copyWith(
      entryPoints: {
        'b.dart',
      },
    ),
  ],
  executableDeclarations: const [],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
final packageClassAApiEntryPointAB = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: [
    simpleClassA.copyWith(
      entryPoints: {
        'a.dart',
        'b.dart',
      },
    ),
  ],
  executableDeclarations: const [],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
// END Package ClassA variations

final packageClassAClassBApi = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: [
    simpleClassA,
    simpleClassB,
  ],
  executableDeclarations: const [],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);

final simpleExecutable1 = ExecutableDeclaration(
  returnTypeName: '',
  name: 'doSomething1',
  isDeprecated: false,
  parameters: const [
    ExecutableParameterDeclaration(
        isRequired: true,
        isNamed: true,
        name: 'firstParam',
        isDeprecated: false,
        typeName: 'String'),
  ],
  isStatic: false,
  typeParameterNames: const [],
  type: ExecutableType.method,
);

final simpleExecutable2 = ExecutableDeclaration(
  returnTypeName: '',
  name: 'doSomething2',
  isDeprecated: false,
  parameters: const [],
  typeParameterNames: const [],
  type: ExecutableType.method,
  isStatic: false,
);

final packageExecutable1Api = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: const [],
  executableDeclarations: [
    simpleExecutable1,
  ],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);

// Package Executable1 variations
final packageExecutable1WithTypeParameterTApi = packageExecutable1Api.copyWith(
  executableDeclarations: packageExecutable1Api.executableDeclarations
      .map((cd) => cd.copyWith(typeParameterNames: ['T']))
      .toList(),
);
final packageExecutable1WithTypeParameterRApi = packageExecutable1Api.copyWith(
  executableDeclarations: packageExecutable1Api.executableDeclarations
      .map((cd) => cd.copyWith(typeParameterNames: ['R']))
      .toList(),
);
final packageExecutable1ReturnTypeChangedApi = packageExecutable1Api.copyWith(
  executableDeclarations: packageExecutable1Api.executableDeclarations
      .map((exd) => exd.copyWith(returnTypeName: 'NewType'))
      .toList(),
);
final packageExecutable1StaticChangedApi = packageExecutable1Api.copyWith(
  executableDeclarations: packageExecutable1Api.executableDeclarations
      .map((exd) => exd.copyWith(isStatic: true))
      .toList(),
);
final packageExecutable1ParameterTypeChangedApi =
    packageExecutable1Api.copyWith(
  executableDeclarations: packageExecutable1Api.executableDeclarations.map(
    (exd) {
      bool parameterChanged = false;
      return exd.copyWith(
        parameters: exd.parameters.map(
          (param) {
            // only change the first param
            if (parameterChanged) {
              return param;
            }
            parameterChanged = true;
            return param.copyWith(
              typeName: 'NewType',
            );
          },
        ).toList(),
      );
    },
  ).toList(),
);
final packageExecutable1OptionalPositionalParameterAddedApi =
    packageExecutable1Api.copyWith(
  executableDeclarations: packageExecutable1Api.executableDeclarations.map(
    (exd) {
      return exd.copyWith(
        parameters: [
          ...exd.parameters,
          ExecutableParameterDeclaration(
            isRequired: false,
            isNamed: false,
            name: 'optionalPositional',
            isDeprecated: false,
            typeName: 'bool',
          ),
        ],
      );
    },
  ).toList(),
);
final packageExecutable1OptionalNamedParameterAddedApi =
    packageExecutable1Api.copyWith(
  executableDeclarations: packageExecutable1Api.executableDeclarations.map(
    (exd) {
      return exd.copyWith(
        parameters: [
          ...exd.parameters,
          ExecutableParameterDeclaration(
            isRequired: false,
            isNamed: true,
            name: 'optionalNamed',
            isDeprecated: false,
            typeName: 'bool',
          ),
        ],
      );
    },
  ).toList(),
);
final packageExecutable1RequiredPositionalParameterAddedApi =
    packageExecutable1Api.copyWith(
  executableDeclarations: packageExecutable1Api.executableDeclarations.map(
    (exd) {
      return exd.copyWith(
        parameters: [
          ...exd.parameters,
          ExecutableParameterDeclaration(
            isRequired: true,
            isNamed: false,
            name: 'requiredPositional',
            isDeprecated: false,
            typeName: 'bool',
          ),
        ],
      );
    },
  ).toList(),
);
final packageExecutable1RequiredNamedParameterAddedApi =
    packageExecutable1Api.copyWith(
  executableDeclarations: packageExecutable1Api.executableDeclarations.map(
    (exd) {
      return exd.copyWith(
        parameters: [
          ...exd.parameters,
          ExecutableParameterDeclaration(
            isRequired: true,
            isNamed: true,
            name: 'requiredNamed',
            isDeprecated: false,
            typeName: 'bool',
          ),
        ],
      );
    },
  ).toList(),
);
final packageExecutable1ApiEntryPointA = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: const [],
  executableDeclarations: [
    simpleExecutable1.copyWith(
      entryPoints: {
        'a.dart',
      },
    ),
  ],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
final packageExecutable1ApiEntryPointB = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: const [],
  executableDeclarations: [
    simpleExecutable1.copyWith(
      entryPoints: {
        'b.dart',
      },
    ),
  ],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
final packageExecutable1ApiEntryPointAB = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: const [],
  executableDeclarations: [
    simpleExecutable1.copyWith(
      entryPoints: {
        'a.dart',
        'b.dart',
      },
    ),
  ],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
// END Package Executable1 variations

final packageExecutable1Executable2Api = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: const [],
  executableDeclarations: [
    simpleExecutable1,
    simpleExecutable2,
  ],
  fieldDeclarations: const [],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);

final simpleFieldDeclarationA = FieldDeclaration(
  typeName: 'String',
  name: 'fieldA',
  isDeprecated: false,
  isStatic: false,
);
final simpleFieldDeclarationB = FieldDeclaration(
  typeName: 'bool',
  name: 'fieldB',
  isDeprecated: false,
  isStatic: false,
);

final packageFieldA = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: const [],
  executableDeclarations: const [],
  fieldDeclarations: [
    simpleFieldDeclarationA,
  ],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);

// Package FieldA variations
final packageFieldATypeChangedApi = packageFieldA.copyWith(
  fieldDeclarations: packageFieldA.fieldDeclarations
      .map((fd) => fd.copyWith(typeName: 'NewType'))
      .toList(),
);
final packageFieldAStaticChangedApi = packageFieldA.copyWith(
  fieldDeclarations: packageFieldA.fieldDeclarations
      .map((fd) => fd.copyWith(isStatic: true))
      .toList(),
);
final packageFieldAEntryPointA = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: const [],
  executableDeclarations: const [],
  fieldDeclarations: [
    simpleFieldDeclarationA.copyWith(
      entryPoints: {
        'a.dart',
      },
    ),
  ],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
final packageFieldAEntryPointB = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: const [],
  executableDeclarations: const [],
  fieldDeclarations: [
    simpleFieldDeclarationA.copyWith(
      entryPoints: {
        'b.dart',
      },
    ),
  ],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
final packageFieldAEntryPointAB = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: const [],
  executableDeclarations: const [],
  fieldDeclarations: [
    simpleFieldDeclarationA.copyWith(
      entryPoints: {
        'b.dart',
        'a.dart',
      },
    ),
  ],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
// END Package FieldA variations

final packageFieldAFieldB = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  packagePath: '.',
  interfaceDeclarations: const [],
  executableDeclarations: const [],
  fieldDeclarations: [
    simpleFieldDeclarationA,
    simpleFieldDeclarationB,
  ],
  typeAliasDeclarations: const [],
  sdkType: SdkType.unknown,
  minSdkVersion: Version.none,
  packageDependencies: [],
);
