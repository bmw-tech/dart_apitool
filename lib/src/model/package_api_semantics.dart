import 'package:freezed_annotation/freezed_annotation.dart';

/// defines the semantics used in a [PackageApi] model
enum PackageApiSemantics {
  /// base classes have been merged into the derived classes
  @JsonValue("mergeBaseClasses")
  mergeBaseClasses,
}
