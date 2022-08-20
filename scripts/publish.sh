#!/bin/bash
set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Publishing dart_apitool"

pushd $SCRIPT_DIR/..

echo "******* Prechecks *******"
echo "Check if everything is commited"
git diff --quiet
echo "get dependencies"
fvm dart pub get
echo "Analyze"
fvm dart analyze
echo "Tests"
fvm dart test
echo "Semver"
if [ -f last_version.txt ]; then
    LAST_VERSION=$(cat last_version.txt)
    echo "Last version: $LAST_VERSION";
    fvm dart bin/main.dart diff --old pub://dart_apitool/$LAST_VERSION --new .
else
    echo "no last_version.txt Skipping Semver checks"
fi

# publish
fvm dart pub publish
current_version=$(grep "version\: " ./pubspec.yaml | sed 's/version\: //g')
echo $current_version > last_version.txt

git add .
git commit -m"Version $current_version"
git tag $current_version

echo "Release is done. Now you have to increase the version in pubspec.yaml"

popd