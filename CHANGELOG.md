# Changelog

## Version 0.15.1
- Add support for `pubspec_overrides.yaml`.

## Version 0.15.0
- Remove effect of `--dependency-check-mode` and add a deprecation warning (for why refer to https://github.com/bmw-tech/dart_apitool/issues/144)

## Version 0.14.1
- Fixes an issue with path dev-dependencies
- Fixes issues with isSealed handling (extracted JSON was wrong) thanks @hamsbrar

## Version 0.14.0
- improves change type detection for parameter type changes (widening types is now considered non-breaking)
- ignores enum constructors and elements marked with @override
- detects @sealed classes and doesn't consider them as required interfaces
- removes '[no]-merge-base-classes' option as this functionality is crucial now
- improved entry point tracking
- warning if a root level type is part of the public API but not exported
  - can be turned into an error with `--[no-]set-exit-on-missing-export`
- new option `--ignore-requiredness` to be less strict about interface changes (only advised for packages with controlled usage)

## Version 0.13.0
- fixes an issue with required interface detection on property and field usage
- default behavior of `--ignore-prerelease` is now `on`
- improved pre-release handling. Now dart_apitool plays well in scenarios where released pre-release versions are compared to the new stable release
- fall back to system Flutter executable if no matching Flutter executable can be found

## Version 0.12.1
- move package from devmil to bmw-tech 🚀

## Version 0.12.0
- extend handling of change types to include "breaking", "non-breaking-minor" and "non-breaking-patch" changes
- only output sub process output in a "window" if stdout is a terminal

## Version 0.11.1
- fixes parsing of local package references

## Version 0.11.0
- replaces `--check-versions` with `--version-check-mode`
- reduces the amount of directories to copy in a path-dependency-context
- prints sub process output
- `--remove-example` option (defaults to true) that deletes the "example" directory of the package to analyze (in the temporary directory) to avoid issues with the example project

## Version 0.10.2
- fixes an issue with cache location and Flutter 3.7.0

## Version 0.10.1 
- fixes an issue with projects having path dependencies to projects inside their folder structure

## Version 0.10.0
- adds include-path-dependencies parameters
- dependencies are ignored if one side of the diff is a path dependency

## Version 0.9.1
- use the relative path only for top level entities
- use a more stable way of getting the relative path

## Version 0.9.0
- Adds detection and consideration of @experimental flag
- Increases robustness regarding
  -  analysis_options: Those get now removed (in a temporary copy) to not limit the scope of dart_apitool
  -  Duplicate names: Detection of interfaces now considers the relative path of the library file to avoid crashes on duplicate names

## Version 0.8.0
- Improves handling of elements without root
- Changing required interfaces (even adding things) is now considered a breaking change
  interfaces are considered 'required' if they are abstract and used in a public method or field.
  This indicates that this interfaces is intended to be implemented by the user and therefore adding things also is breaking the API.
- Detect changes in package dependencies
- Adds codes for API diff reasons that point to an explanation [here](https://github.com/bmw-tech/dart_apitool/blob/main/readme/change_codes.md)

## Version 0.7.0
- *BREAKING*: renamed "Class" model elements to "Interface" to reflect the abstraction it represents
- Fixes Extension handling (are now treated as interfaces)
  
## Version 0.6.0
- *BREAKING*: removes capability to use stored models in diffs
- *BREAKING*: CommandMixin's "analyze" no longer does clean up preparation results. For this the newly introduced "cleanUp" method has to be called
- Fixes major issue with equal class names (or top-level variables, functions or type aliases) imported in different namespaces
- Improve diff tree output
- Analyzes and diffs platform constraints
- Analyzes and diffs SDK versions

## Version 0.5.1
- Fixes Analyzer problem when visiting elements multiple times

## Version 0.5.0
- PackageAPI semantics are now an enum
- Fixes issues with entry points for fields and executables (differ ignored them)
- API changes for the diff command are now printed as a proper tree

## Version 0.4.0
- adds type aliases to Package API model
- fixes missing entry points for root level fields and functions
- fixed typo in `PackageApiDiffResult`

## Version 0.3.2
- fixes base class merge (root level elements)

## Version 0.3.1
- fixes base class merge (override duplicates)

## Version 0.3.0
- *BREAKING*: by default base class elements get now merged with the derived class. This makes previously saved models incompatible.  
"dart_apitool" will detect that, but it is not possible to diff an old model with a new one. (can only happen if you saved the model, doesn't affect live analysis of pub or directory references).  
To deactivate that behavior you can use the `--no-merge-base-classes` option.
- fixes entry point handling
- fixes minimum version handling for versions with major == 0

## Version 0.2.1
- fixes getting own version in `pub global` context

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
