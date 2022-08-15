part of 'package_api_differ_test.dart';

final simpleClassA = ClassDeclaration(
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
        type: ExecutableType.constructor),
  ],
  fieldDeclarations: const [],
);
final simpleClassB = ClassDeclaration(
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
        type: ExecutableType.constructor),
  ],
  fieldDeclarations: const [],
);

final packageClassAApi = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  projectPath: '.',
  classDeclarations: [
    simpleClassA,
  ],
  executableDeclarations: const [],
  fieldDeclarations: const [],
);
// Package ClassA variations
final packageClassADeprecatedApi = packageClassAApi.copyWith(
  classDeclarations: packageClassAApi.classDeclarations
      .map((cd) => cd.copyWith(isDeprecated: true))
      .toList(),
);
final packageClassAWithTypeParameterTApi = packageClassAApi.copyWith(
  classDeclarations: packageClassAApi.classDeclarations
      .map((cd) => cd.copyWith(typeParameterNames: ['T']))
      .toList(),
);
final packageClassAWithTypeParameterRApi = packageClassAApi.copyWith(
  classDeclarations: packageClassAApi.classDeclarations
      .map((cd) => cd.copyWith(typeParameterNames: ['R']))
      .toList(),
);
// END Package ClassA variations

final packageClassAClassBApi = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  projectPath: '.',
  classDeclarations: [
    simpleClassA,
    simpleClassB,
  ],
  executableDeclarations: const [],
  fieldDeclarations: const [],
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
);

final packageExecutable1Api = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  projectPath: '.',
  classDeclarations: const [],
  executableDeclarations: [
    simpleExecutable1,
  ],
  fieldDeclarations: const [],
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
// END Package Executable1 variations

final packageExecutable1Executable2Api = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  projectPath: '.',
  classDeclarations: const [],
  executableDeclarations: [
    simpleExecutable1,
    simpleExecutable2,
  ],
  fieldDeclarations: const [],
);

final simpleFieldDeclarationA = FieldDeclaration(
  typeName: 'String',
  name: 'fieldA',
  isDeprecated: false,
);
final simpleFieldDeclarationB = FieldDeclaration(
  typeName: 'bool',
  name: 'fieldB',
  isDeprecated: false,
);

final packageFieldA = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  projectPath: '.',
  classDeclarations: const [],
  executableDeclarations: const [],
  fieldDeclarations: [
    simpleFieldDeclarationA,
  ],
);

// Package FieldA variations
final packageFieldATypeChangedApi = packageFieldA.copyWith(
  fieldDeclarations: packageFieldA.fieldDeclarations
      .map((fd) => fd.copyWith(typeName: 'NewType'))
      .toList(),
);
// END Package FieldA variations

final packageFieldAFieldB = PackageApi(
  packageName: 'simple_package',
  packageVersion: '1.0.0',
  projectPath: '.',
  classDeclarations: const [],
  executableDeclarations: const [],
  fieldDeclarations: [
    simpleFieldDeclarationA,
    simpleFieldDeclarationB,
  ],
);
