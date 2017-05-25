#!/bin/bash

# You need to add this to your .travis.yml
#
#  addons:
#    apt:
#      packages:
#        - vera++
#
#  script:
#    - path-to/this-dir/in-repo/run-vera.sh path/to/C-source-tree

vroot=`dirname $0`/vera++
root="$1"
shift
pattern='*.[ch]'
find $root -name "$pattern" | \
	vera++ --root $vroot --profile spinnaker.tcl --error ${1+"$@"}
exit $?
