import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:path/path.dart' as path;
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:tuple/tuple.dart';

import '../tooling/tooling.dart';

part 'type_hierarchy.freezed.dart';

/// represents a type identifier
/// consists of name and full library name
@freezed
sealed class TypeIdentifier with _$TypeIdentifier {
  const TypeIdentifier._();

  /// returns true if this type identifier contains the nullable flag
  bool get isNullable => isDynamic || typeName.endsWith('?');

  /// returns true if this type identifier is the dynamic type
  bool get isDynamic => typeName == 'dynamic';

  /// returns the name without the nullable flag
  String get nonNullableTypeName => typeName.endsWith('?')
      ? typeName.substring(0, typeName.length - 1)
      : typeName;

  /// returns the name with the nullable flag
  String get nullableTypeName {
    if (isDynamic) {
      return typeName;
    }
    return typeName.endsWith('?') ? typeName : '$typeName?';
  }

  /// returns a String containing the package name and the type name
  String get packageAndTypeName => '$packageName:$typeName';

  /// returns a String containing the package name and the type name without nullable flag
  String get nonNullablePackageAndTypeName =>
      '$packageName:$nonNullableTypeName';

  const factory TypeIdentifier({
    /// the name of this type
    required String typeName,

    /// the name of the package defining that type
    required String packageName,

    /// the library path inside the package defining that type
    required String packageRelativeLibraryPath,
  }) = _TypeIdentifier;

  @override
  String toString() {
    return '$packageName:$typeName ($packageRelativeLibraryPath)';
  }

  /// returns a copy of this type identifier without the nullable flag
  TypeIdentifier asNonNullable() => TypeIdentifier(
        typeName: nonNullableTypeName,
        packageName: packageName,
        packageRelativeLibraryPath: packageRelativeLibraryPath,
      );

  /// returns a copy of this type identifier with the nullable flag
  TypeIdentifier asNullable() => TypeIdentifier(
        typeName: nullableTypeName,
        packageName: packageName,
        packageRelativeLibraryPath: packageRelativeLibraryPath,
      );

  static final _libraryPathToPackageInfoCache =
      <String, Tuple2<String, String>>{};

  factory TypeIdentifier.fromNameAndLibraryPath({
    required String typeName,
    required String? libraryPath,
  }) {
    if (_libraryPathToPackageInfoCache.containsKey(libraryPath)) {
      final cachedPackageInfo = _libraryPathToPackageInfoCache[libraryPath];
      return TypeIdentifier(
        typeName: typeName,
        packageName: cachedPackageInfo!.item1,
        packageRelativeLibraryPath: cachedPackageInfo.item2,
      );
    }
    if (libraryPath == null) {
      return TypeIdentifier(
        typeName: typeName,
        packageName: '',
        packageRelativeLibraryPath: '',
      );
    }
    // search for the nearest pubspec
    final normalizedLibraryPath = path.normalize(path.dirname(libraryPath));
    final pubCacheDir = PubInteraction.pubCacheDir;
    final pathParts = path.split(normalizedLibraryPath);
    String? pubspecDirectoryPath;
    for (var i = pathParts.length - 1; i >= 0; i--) {
      final currentPath = path.joinAll(pathParts.sublist(0, i + 1));
      if (path.absolute(pubCacheDir) == path.absolute(currentPath)) {
        // safety measure #1: we don't want to leave the pub cache if libraryPath happens to be there
        break;
      }
      if (pathParts[i] == 'dart-sdk') {
        // safety measure #2: we don't want to leave the dart cache if libraryPath happens to be there
        break;
      }
      final currentPubspecPath = path.join(currentPath, 'pubspec.yaml');
      if (File(currentPubspecPath).existsSync()) {
        pubspecDirectoryPath = currentPath;
        break;
      }
    }
    if (pubspecDirectoryPath == null) {
      // we can't find a pubspec.yaml => we consider this to be a framework type
      final assumedPackageName = path.basenameWithoutExtension(libraryPath);
      _libraryPathToPackageInfoCache[libraryPath] = Tuple2(
        assumedPackageName,
        '',
      );
      return TypeIdentifier(
        typeName: typeName,
        packageName: assumedPackageName,
        packageRelativeLibraryPath: '',
      );
    }
    // get package name from pubspec
    final pubspecContent = File(path.join(pubspecDirectoryPath, 'pubspec.yaml'))
        .readAsStringSync();
    final pubspec = Pubspec.parse(pubspecContent);
    final packageName = pubspec.name;
    // get package relative library path
    final packageRelativeLibraryPath =
        path.relative(libraryPath, from: pubspecDirectoryPath);

    _libraryPathToPackageInfoCache[libraryPath] = Tuple2(
      packageName,
      packageRelativeLibraryPath,
    );

    return TypeIdentifier(
      typeName: typeName,
      packageName: packageName,
      packageRelativeLibraryPath: packageRelativeLibraryPath,
    );
  }
}

/// represents the type hierarchy of the public API of a package
class TypeHierarchy {
  final Map<String, Set<_TypeHierarchyItem>> _types = {};

  /// Built-in Dart type hierarchy relationships
  /// Maps type names to their supertypes
  static const Map<String, Set<String>> _builtInTypeHierarchy = {
    'int': {'num', 'Object'},
    'double': {'num', 'Object'},
    'num': {'Object'},
    'String': {'Object'},
    'bool': {'Object'},
    'List': {'Iterable', 'Object'},
    'Set': {'Iterable', 'Object'},
    'Map': {'Object'},
    'Iterable': {'Object'},
    'Future': {'Object'},
    'Stream': {'Object'},
    'Symbol': {'Object'},
    'Type': {'Object'},
    'Function': {'Object'},
    'Record': {'Object'},
  };

  TypeHierarchy._();

  /// creates an empty type hierarchy
  factory TypeHierarchy.empty() {
    return TypeHierarchy._();
  }

  /// registers the given [typeIdentifier] with the given [baseTypeIdentifiers]
  void registerType(
    TypeIdentifier typeIdentifier,
    Set<TypeIdentifier> baseTypeIdentifiers,
  ) {
    if (!_types.containsKey(typeIdentifier.packageAndTypeName)) {
      _types[typeIdentifier.packageAndTypeName] = {};
    }
    // the set type the new item gets added to makes sure that we don't add the same type twice
    // only if there are multiple occasions of types with the same name then we end up with multiple entries here (which is intended)
    _types[typeIdentifier.packageAndTypeName]!.add(
      _TypeHierarchyItem(
        typeIdentifier: typeIdentifier,
        baseTypeIdentifiers: baseTypeIdentifiers,
      ),
    );
  }

  /// checks if [newTypeIdentifier] is a compatible replacement for [oldTypeIdentifier]
  bool isCompatibleReplacement({
    required TypeIdentifier oldTypeIdentifier,
    required TypeIdentifier newTypeIdentifier,
    required bool isTypePassedIn,
  }) {
    if (isTypePassedIn) {
      // for types passed in: dynamic accepts anything so it's always compatible
      if (newTypeIdentifier.isDynamic) {
        return true;
      }
      // Special case: Object? and dynamic are interchangeable for input parameters
      if (oldTypeIdentifier.isDynamic &&
          newTypeIdentifier.typeName == 'Object?') {
        return true;
      }
      if (oldTypeIdentifier.typeName == 'Object?' &&
          newTypeIdentifier.isDynamic) {
        return true;
      }
    } else {
      // for types returned: narrowing (going to more specific types) is compatible
      // widening (going to more general types like dynamic) is NOT compatible
      // Exception: changing FROM dynamic to anything specific is narrowing and compatible
      if (oldTypeIdentifier.isDynamic && !newTypeIdentifier.isDynamic) {
        return true; // narrowing from dynamic to specific type is compatible
      }
    }
    // if we try to replace a nullable type with a non-nullable for types passed in then we can return early
    if (isTypePassedIn &&
        !newTypeIdentifier.isNullable &&
        oldTypeIdentifier.isNullable) {
      return false;
    }
    // if we try to replace a non-nullable type with a nullable for types passed out then we can return early
    if (!isTypePassedIn &&
        newTypeIdentifier.isNullable &&
        !oldTypeIdentifier.isNullable) {
      return false;
    }

    // and then compare the types without Nullable
    oldTypeIdentifier = oldTypeIdentifier.asNonNullable();
    newTypeIdentifier = newTypeIdentifier.asNonNullable();

    /// if the names and packages are equal we consider them to be equal
    if (oldTypeIdentifier.packageAndTypeName ==
        newTypeIdentifier.packageAndTypeName) {
      return true;
    }

    final newIsSubtypeOfOld =
        _isSubTypeOf(newTypeIdentifier, oldTypeIdentifier);
    final oldIsSubtypeOfNew =
        _isSubTypeOf(oldTypeIdentifier, newTypeIdentifier);

    // if we pass the type in then it can get wider
    // if we pass it out then it can get narrower
    return isTypePassedIn ? oldIsSubtypeOfNew : newIsSubtypeOfOld;
  }

  /// Checks if [potentialSubType] is a built-in subtype of [superType]
  bool _isBuiltInSubType(
    TypeIdentifier potentialSubType,
    TypeIdentifier superType,
  ) {
    // Handle dynamic type cases
    if (superType.isDynamic) {
      return true; // Everything is a subtype of dynamic
    }
    if (potentialSubType.isDynamic) {
      return false; // Dynamic is not a subtype of specific types
    }

    // Extract base type names (without generic parameters)
    final subTypeName =
        _extractBaseTypeName(potentialSubType.nonNullableTypeName);
    final superTypeName = _extractBaseTypeName(superType.nonNullableTypeName);

    // Check if both types are from the same package (built-in types should have empty package names)
    if (potentialSubType.packageName != superType.packageName) {
      return false;
    }

    // Check direct built-in type relationships
    final superTypes = _builtInTypeHierarchy[subTypeName];
    if (superTypes != null && superTypes.contains(superTypeName)) {
      return true;
    }

    // Check generic type covariance for common collection types
    if (_isGenericTypeCovariant(
        potentialSubType.nonNullableTypeName, superType.nonNullableTypeName)) {
      return true;
    }

    return false;
  }

  /// Extracts the base type name from a potentially generic type
  /// e.g., "`List<int>`" -> "List", "String" -> "String"
  String _extractBaseTypeName(String typeName) {
    final genericStart = typeName.indexOf('<');
    if (genericStart == -1) {
      return typeName;
    }
    return typeName.substring(0, genericStart);
  }

  /// Checks if generic types are covariant (e.g., `List<int>` is subtype of `List<num>`)
  bool _isGenericTypeCovariant(String subType, String superType) {
    final subTypeInfo = _parseGenericType(subType);
    final superTypeInfo = _parseGenericType(superType);

    // Both must be generic types with the same base type
    if (subTypeInfo == null || superTypeInfo == null) {
      return false;
    }

    if (subTypeInfo.baseType != superTypeInfo.baseType) {
      return false;
    }

    // Check if the base type supports covariance
    if (!_isCovariantGenericType(subTypeInfo.baseType)) {
      return false;
    }

    // For covariant types, check if all type arguments are subtypes
    if (subTypeInfo.typeArguments.length !=
        superTypeInfo.typeArguments.length) {
      return false;
    }

    for (int i = 0; i < subTypeInfo.typeArguments.length; i++) {
      final subArg = subTypeInfo.typeArguments[i];
      final superArg = superTypeInfo.typeArguments[i];

      // Special handling for Map: only the value type (second parameter) needs to be covariant
      // The key type (first parameter) should be invariant, but for return types we allow covariance
      if (subTypeInfo.baseType == 'Map' && i == 0) {
        // For Map key types, we allow exact match or covariance for return types
        if (subArg != superArg) {
          final subArgType = TypeIdentifier(
            typeName: subArg,
            packageName: '',
            packageRelativeLibraryPath: '',
          );
          final superArgType = TypeIdentifier(
            typeName: superArg,
            packageName: '',
            packageRelativeLibraryPath: '',
          );
          if (!_isTypeArgumentSubtype(subArgType, superArgType)) {
            return false;
          }
        }
        continue;
      }

      // For other type arguments, check covariance
      if (!_isTypeArgumentSubtype(
          TypeIdentifier(
            typeName: subArg,
            packageName: '',
            packageRelativeLibraryPath: '',
          ),
          TypeIdentifier(
            typeName: superArg,
            packageName: '',
            packageRelativeLibraryPath: '',
          ))) {
        return false;
      }
    }

    return true;
  }

  /// Checks if a type argument is a subtype of another type argument
  /// This handles special cases like dynamic and nullable types
  bool _isTypeArgumentSubtype(
      TypeIdentifier subType, TypeIdentifier superType) {
    // If super type is dynamic, any type is a subtype
    if (superType.isDynamic) {
      return true;
    }

    // If sub type is dynamic and super type is not, this is narrowing (allowed for return types)
    if (subType.isDynamic) {
      return false; // dynamic is not a subtype of specific types
    }

    // Handle nullable to non-nullable narrowing
    if (!subType.isNullable && superType.isNullable) {
      // Non-nullable is a subtype of nullable if the base types match
      return subType.nonNullableTypeName == superType.nonNullableTypeName;
    }

    // Use the existing built-in subtype checking
    return _isBuiltInSubType(subType, superType) ||
        subType.typeName == superType.typeName;
  }

  /// Checks if a generic type supports covariance
  bool _isCovariantGenericType(String baseType) {
    // These generic types are covariant in Dart
    // Note: Map is covariant in its value type (second type parameter)
    return const {'List', 'Set', 'Iterable', 'Future', 'Stream', 'Map'}
        .contains(baseType);
  }

  /// Parses a generic type into base type and type arguments
  _GenericTypeInfo? _parseGenericType(String typeName) {
    final genericStart = typeName.indexOf('<');
    if (genericStart == -1) {
      return null; // Not a generic type
    }

    final genericEnd = typeName.lastIndexOf('>');
    if (genericEnd == -1 || genericEnd <= genericStart) {
      return null; // Malformed generic type
    }

    final baseType = typeName.substring(0, genericStart);
    final typeArgsString = typeName.substring(genericStart + 1, genericEnd);

    // Simple parsing - split by comma (doesn't handle nested generics perfectly)
    final typeArguments = typeArgsString
        .split(',')
        .map((arg) => arg.trim())
        .where((arg) => arg.isNotEmpty)
        .toList();

    return _GenericTypeInfo(
      baseType: baseType,
      typeArguments: typeArguments,
    );
  }

  bool _isSubTypeOf(
    TypeIdentifier potentialSubTypeIdentifier,
    TypeIdentifier superTypeIdentifier,
  ) {
    // First check built-in type relationships
    if (_isBuiltInSubType(potentialSubTypeIdentifier, superTypeIdentifier)) {
      return true;
    }

    // if we can't find the type we try to use the nullable / non-nullable variant
    if (!_types.containsKey(potentialSubTypeIdentifier.packageAndTypeName)) {
      if (potentialSubTypeIdentifier.isNullable) {
        potentialSubTypeIdentifier = potentialSubTypeIdentifier.asNonNullable();
      } else {
        potentialSubTypeIdentifier = potentialSubTypeIdentifier.asNullable();
      }
    }
    // find potential sub type
    // we copy the set to avoid modifying the original set when removing items later
    final items = {
      ...(_types[potentialSubTypeIdentifier.packageAndTypeName] ?? {})
    };

    if (items.length > 1) {
      // there is more than one type with the same name in one package => we need to check the full library name
      // and remove all occurences that don't match
      items.removeWhere((i) =>
          i.typeIdentifier.packageRelativeLibraryPath !=
          potentialSubTypeIdentifier.packageRelativeLibraryPath);
    }

    // after removal of non-matching types: if there are no entries left or more than 1 entry is left => we can't tell and return false

    // this can happen if the potentialSubTypeIdentifier and superTypeIdentifier come from different analyze runs and the folder structure changed
    // between the runs
    if (items.isEmpty || items.length > 1) {
      return false;
    }
    final potentialSubType = items.single;

    // walk up the type hierarchy to check if we find [superTypeIdentifier]
    return potentialSubType.baseTypeIdentifiers.any((bti) {
      // compare the types null-flag independent by converting both sides to their nonNullable variants
      if (bti.nonNullablePackageAndTypeName ==
          superTypeIdentifier.nonNullablePackageAndTypeName) {
        return true;
      }

      return _isSubTypeOf(bti, superTypeIdentifier);
    });
  }
}

/// Helper class for parsing generic type information
class _GenericTypeInfo {
  final String baseType;
  final List<String> typeArguments;

  _GenericTypeInfo({
    required this.baseType,
    required this.typeArguments,
  });
}

/// represents a type in the type hierarchy
@freezed
sealed class _TypeHierarchyItem with _$TypeHierarchyItem {
  const _TypeHierarchyItem._();

  const factory _TypeHierarchyItem({
    /// the identifier of this type
    required TypeIdentifier typeIdentifier,

    /// the type identifiers of the super types of this type
    required Set<TypeIdentifier> baseTypeIdentifiers,
  }) = __TypeHierarchyItem;

  @override
  String toString() {
    return '$typeIdentifier [${baseTypeIdentifiers.join(', ')}]';
  }
}
