import 'package:freezed_annotation/freezed_annotation.dart';

part 'type_hierarchy.freezed.dart';

/// represents a type identifier
/// consists of name and full library name
@freezed
class TypeIdentifier with _$TypeIdentifier {
  const TypeIdentifier._();

  /// returns true if this type identifier contains the optional flag
  bool get isOptional => name.endsWith('?');

  /// returns the name without the optional flag
  String get nameWithoutOptional =>
      name.endsWith('?') ? name.substring(0, name.length - 1) : name;

  const factory TypeIdentifier({
    /// the name of this type
    required String name,

    /// the full library name
    required String? fullLibraryName,
  }) = _TypeIdentifier;

  /// returns a copy of this type identifier without the optional flag
  TypeIdentifier asNonOptional() => TypeIdentifier(
        name: nameWithoutOptional,
        fullLibraryName: fullLibraryName,
      );
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
    if (!_types.containsKey(typeIdentifier.name)) {
      _types[typeIdentifier.name] = {};
    }
    // the set type the new item gets added to makes sure that we don't add the same type twice
    // only if there are multiple occasions of types with the same name then we end up with multiple entries here (which is intended)
    _types[typeIdentifier.name]!.add(
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
    // remove the optional flag as non-optionals can be assigned to optionals
    if (!typeIdentifierToAssign.isOptional && targetTypeIdentifier.isOptional) {
      targetTypeIdentifier = targetTypeIdentifier.asNonOptional();
    }

    /// if the names are equal we consider then to be equal
    if (typeIdentifierToAssign.name == targetTypeIdentifier.name) {
      return true;
    }

    return _isSubTypeOf(typeIdentifierToAssign, targetTypeIdentifier);
  }

  bool _isSubTypeOf(
    TypeIdentifier potentialSubTypeIdentifier,
    TypeIdentifier superTypeIdentifier,
  ) {
    // find potential sub type
    // we copy the set to avoid modifying the original set when removing items later
    final items = {...(_types[potentialSubTypeIdentifier.name] ?? {})};

    if (items.length > 1) {
      // there is more than one type with the same name => we need to check the full library name
      // and remove all occurences that don't match
      items.removeWhere((i) =>
          i.typeIdentifier.fullLibraryName !=
          potentialSubTypeIdentifier.fullLibraryName);
    }

    // after removal of non-matching types: if there are no entries left or more than 1 entry is left => we can't tell and return false

    // this can happen if the potentialSubTypeIdentifier and superTypeIdentifier come from different analyze runs and the folder structure changed
    // between the runs (this happens always if path dependencies are involved => in that case we are screwed as there is no way of knowing which type is the correct one)
    if (items.isEmpty || items.length > 1) {
      return false;
    }
    final potentialSubType = items.single;

    // walk up the type hierarchy to check if we find [superTypeIdentifier]
    return potentialSubType.baseTypeIdentifiers.any((bti) {
      if (bti.name == superTypeIdentifier.name) {
        return true;
      }

      return _isSubTypeOf(bti, superTypeIdentifier);
    });
  }
}

/// represents a type in the type hierarchy
@freezed
class _TypeHierarchyItem with _$_TypeHierarchyItem {
  const _TypeHierarchyItem._();

  const factory _TypeHierarchyItem({
    /// the identifier of this type
    required TypeIdentifier typeIdentifier,

    /// the type identifiers of the super types of this type
    required Set<TypeIdentifier> baseTypeIdentifiers,
  }) = __TypeHierarchyItem;
}
