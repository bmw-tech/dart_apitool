#!/bin/bash
set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Publishing dart_apitool"

pushd $SCRIPT_DIR/..

fvm dart scripts/release_util/bin/release_util.dart release

popd