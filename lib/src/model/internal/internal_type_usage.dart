import 'package:analyzer/dart/element/element.dart';
import 'package:dart_apitool/src/model/internal/internal_declaration_utils.dart';

import '../model.dart';

/// internal representation of a type usage that extracts a qualified name of the referring element
class InternalTypeUsage {
  TypeUsageKind kind;

  String referringElementName;

  bool isVisibleForTesting;

  InternalTypeUsage._({
    required this.kind,
    required this.referringElementName,
    required this.isVisibleForTesting,
  });

  /// creates an internal representation of a type usage
  /// from the given [kind] and [element]
  InternalTypeUsage.fromElement(
      {required TypeUsageKind kind, required Element element})
      : this._(
          kind: kind,
          referringElementName:
              InternalDeclarationUtils.getFullQualifiedNameFor(element),
          isVisibleForTesting:
              InternalDeclarationUtils.hasVisibleForTesting(element),
        );
}
