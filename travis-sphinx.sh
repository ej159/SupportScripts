#!/bin/sh

cd doc/source
name=$1
shift
echo travis_fold:start:$name
sphinx-build "$@"
code=$?
echo travis_fold:end:$name
exit $code
