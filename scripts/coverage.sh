#!/bin/bash
set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Generating coverage"

pushd $SCRIPT_DIR/..

rm -rf coverage || true

fvm dart pub global activate coverage
fvm dart pub global run coverage:test_with_coverage

popd