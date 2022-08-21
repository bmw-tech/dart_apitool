# Examples for dart-apitool

## Installation
```bash
dart pub global activate dart_apitool
```

## Examples

### Check pub version against current source ignoring the pre-release tag
The current source contains a pre-release tag that gets ignored in this check (the current version gets treated as if it wouldn't have the pre-release part).
This is done in CI to check the state of the current version once it will be officially released
```bash
dart-apitool diff --old pub://dart_apitool/0.1.2 --new . --ignore-prerelease on
```

### Extract public API and use it (later) to check
**extract**
```bash
dart-apitool extract --input . --output publicApi.json
```
**check**
```bash
dart-apitool diff --old publicApi.json --new . --ignore-prerelease on
```

### Compare two copies
```bash
dart-apitool diff --old [path to old version] --new . --ignore-prerelease on
```
