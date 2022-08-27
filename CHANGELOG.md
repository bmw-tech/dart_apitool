# Changelog

## Version 0.2.0
- Command cleanup
- Calls `dart pub` or `flutter pub` depending on the package dependencies
- Refactor Dart and Pub Interaction helpers
- Entry points are now analyzed and diffed as well (List of publicly available import destinations that this element can be reached with)

## Version 0.1.2
- Adds `--ignore-prerelease` to diff command

## Version 0.1.1
- Fixes pre-release handling (old version was checked)

## Version 0.1.0
- Fixes pre-release handling: in case of a pre-release version there is no differentiation between breaking and non-breaking changes
- Fixes some issues with the analyzer and pub package references
- loosened strictness on pre-release versions

## Version 0.0.1-dev.1
- Initial version