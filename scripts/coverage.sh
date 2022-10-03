#!/bin/bash
set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Generating coverage"

pushd $SCRIPT_DIR/..

rm -rf coverage || true

fvm dart pub global activate coverage
fvm dart pub global run coverage:test_with_coverage

# replace the absolute path with a relative path
ABSOLUTE_PATH=$(pwd)
sed -i '' "s|$ABSOLUTE_PATH|.|g" coverage/lcov.info

popd