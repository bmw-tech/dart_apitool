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
class TypeIdentifier with _$TypeIdentifier {
  const TypeIdentifier._();

  /// returns true if this type identifier contains the nullable flag
  bool get isNullable => typeName.endsWith('?');

  /// returns true if this type identifier is the dynamic type
  bool get isDynamic => typeName == 'dynamic';

  /// returns the name without the nullable flag
  String get nonNullableTypeName => typeName.endsWith('?')
      ? typeName.substring(0, typeName.length - 1)
      : typeName;

  /// returns the name with the nullable flag
  String get nullableTypeName =>
      typeName.endsWith('?') ? typeName : '$typeName?';

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

  /// checks if [typeIdentifierToAssign] can be assigned to [targetTypeIdentifier]
  bool canBeAssigned(
    TypeIdentifier typeIdentifierToAssign,
    TypeIdentifier targetTypeIdentifier,
  ) {
    if (targetTypeIdentifier.isDynamic) {
      return true;
    }
    if (targetTypeIdentifier.typeName == 'Object?') {
      return true;
    }
    // if we try to assign a nullable type to a non-nullable then we can return early
    if (!targetTypeIdentifier.isNullable && typeIdentifierToAssign.isNullable) {
      return false;
    }

    // and then compare the types without Nullable
    targetTypeIdentifier = targetTypeIdentifier.asNonNullable();
    typeIdentifierToAssign = typeIdentifierToAssign.asNonNullable();

    /// if the names and packages are equal we consider them to be equal
    if (typeIdentifierToAssign.packageAndTypeName ==
        targetTypeIdentifier.packageAndTypeName) {
      return true;
    }

    return _isSubTypeOf(typeIdentifierToAssign, targetTypeIdentifier);
  }

  bool _isSubTypeOf(
    TypeIdentifier potentialSubTypeIdentifier,
    TypeIdentifier superTypeIdentifier,
  ) {
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

/// represents a type in the type hierarchy
@freezed
class _TypeHierarchyItem with _$TypeHierarchyItem {
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
