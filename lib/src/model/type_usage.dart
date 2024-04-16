import 'package:freezed_annotation/freezed_annotation.dart';

import 'type_usage_kind.dart';

part 'type_usage.freezed.dart';

/// represents the usage of a type
@freezed
class TypeUsage with _$TypeUsage {
  const TypeUsage._();

  const factory TypeUsage({
    /// kind of usage
    required TypeUsageKind kind,

    /// the name of the referring element
    required String referringElementName,

    /// defines if the usage happened in a visibleForTesting context
    required bool isVisibleForTesting,
  }) = _TypeUsage;
}
