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
    ExecutablParameterDeclaration(
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
