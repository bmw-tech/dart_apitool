part of '../api_summary_package_api_adapter.dart';

final class _ReferencedPackageDeclarationsCustomizer
    extends api_summary.ApiSummaryCustomizer {
  const _ReferencedPackageDeclarationsCustomizer();

  @override
  bool get includeReferencedTypes => true;

  @override
  bool get includeImplicitNonPublicMembers => true;
}
