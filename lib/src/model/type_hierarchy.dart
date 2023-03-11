import 'package:freezed_annotation/freezed_annotation.dart';

part 'type_hierarchy.freezed.dart';

@freezed
class TypeIdentifier with _$TypeIdentifier {
  const TypeIdentifier._();

  bool get isOptional => name.endsWith('?');

  String get nameWithoutOptional =>
      name.endsWith('?') ? name.substring(0, name.length - 1) : name;

  const factory TypeIdentifier({
    /// the name of this type
    required String name,

    /// the full library name
    required String? fullLibraryName,
  }) = _TypeIdentifier;

  TypeIdentifier asNonOptional() => TypeIdentifier(
        name: nameWithoutOptional,
        fullLibraryName: fullLibraryName,
      );
}

/// represents the type hierarchy of the public API of a package
class TypeHierarchy {
  final Map<String, Set<TypeHierarchyItem>> _types = {};

  TypeHierarchy._();

  factory TypeHierarchy.empty() {
    return TypeHierarchy._();
  }

  void registerType(
    TypeIdentifier typeIdentifier,
    Set<TypeIdentifier> baseTypeIdentifiers,
  ) {
    if (!_types.containsKey(typeIdentifier.name)) {
      _types[typeIdentifier.name] = {};
    }
    _types[typeIdentifier.name]!.add(TypeHierarchyItem(
      typeIdentifier: typeIdentifier,
      baseTypeIdentifiers: baseTypeIdentifiers,
    ));
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

    if (typeIdentifierToAssign == targetTypeIdentifier) {
      return true;
    }

    return _isSubTypeOf(typeIdentifierToAssign, targetTypeIdentifier);
  }

  bool _isSubTypeOf(TypeIdentifier potentialSubTypeIdentifier,
      TypeIdentifier superTypeIdentifier) {
    // find potential sub type
    final items = _types[potentialSubTypeIdentifier.name];
    if (items == null) {
      return false;
    }

    if (items.length > 1) {
      // there are more than one type with the same name => we need to check the full library name
      items.removeWhere((i) =>
          i.typeIdentifier.fullLibraryName !=
          potentialSubTypeIdentifier.fullLibraryName);
    }
    // after removal of non-matching types: if there are no entries left or more than 1 entry is left => we can't tell and return false
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
class TypeHierarchyItem with _$TypeHierarchyItem {
  const TypeHierarchyItem._();

  const factory TypeHierarchyItem({
    /// the identifier of this type
    required TypeIdentifier typeIdentifier,

    /// the type identifiers of the super types of this type
    required Set<TypeIdentifier> baseTypeIdentifiers,
  }) = _TypeHierarchyItem;
}
