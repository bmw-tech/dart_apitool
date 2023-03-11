import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/utils.dart';

part 'type_hierarchy.freezed.dart';

/// represents the type hierarchy of the public API of a package
@freezed
class TypeHierarchy with _$TypeHierarchy {
  const TypeHierarchy._();

  const factory TypeHierarchy({
    /// the type hierarchy items
    required Map<String, TypeHierarchyItem> types,
  }) = _TypeHierarchy;

  /// checks if [typeIdentifierToAssign] can be assigned to [targetTypeIdentifier]
  bool canBeAssigned(
      String typeIdentifierToAssign, String targetTypeIdentifier) {
    // remove the optional flag as non-optionals can be assigned to optionals
    if (!typeIdentifierToAssign.endsWith('?') &&
        targetTypeIdentifier.endsWith('?')) {
      targetTypeIdentifier =
          targetTypeIdentifier.substring(0, targetTypeIdentifier.length - 1);
    }

    if (typeIdentifierToAssign == targetTypeIdentifier) {
      return true;
    }

    return _isSubTypeOf(typeIdentifierToAssign, targetTypeIdentifier);
  }

  bool _isSubTypeOf(
      String potentialSubTypeIdentifier, String superTypeIdentifier) {
    final potentialSubType = types[potentialSubTypeIdentifier];
    if (potentialSubType == null) {
      // we don't know more about the potential sub type => we assume it is not a sub type
      return false;
    }

    // walk up the type hierarchy to check if we find [superTypeIdentifier]
    return potentialSubType.baseTypeIdentifiers.any((bti) {
      if (bti == superTypeIdentifier) {
        return true;
      }

      return _isSubTypeOf(bti, superTypeIdentifier);
    });
  }
}

/// represents a type in the type hierarchy
@freezed
class TypeHierarchyItem with _$TypeHierarchyItem {
  const TypeHierarchyItem._();

  /// the unique name of that type (library path + name)
  String getUniqueName(String projectRootPath) =>
      NamingUtils.computeUniqueTypeNameFromNames(
        projectRootPath: projectRootPath,
        fullLibraryName: fullLibraryName,
        name: name,
      );

  const factory TypeHierarchyItem({
    /// the name of this type
    required String name,

    /// the namespace of this type. This gets populated if the type got imported with a prefix
    required String namespace,

    /// the full library name
    required String? fullLibraryName,

    /// the type identifiers of the super types of this type
    required Set<String> baseTypeIdentifiers,
  }) = _TypeHierarchyItem;
}
