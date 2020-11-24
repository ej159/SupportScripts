#!/bin/bash
dir0=$(dirname $BASH_SOURCE)
if [ "x$SUPPORT_DIR" = "x" ]; then
	export SUPPORT_DIR=$(cd $dir0 && cd ../../.. || cd; pwd)
fi
[ -f "$SUPPORT_DIR/rat.xml" ] || {
	echo "Could not find rat.xml in support directory!" >&2
	exit 1
}
[ -f "$SUPPORT_DIR/rat.excludes" ] || {
	echo "Could not find rat.excludes in support directory!" >&2
	exit 1
}
exec ant -e -q -f "$SUPPORT_DIR/rat.xml" -lib "$SUPPORT_DIR/apache-rat-$RAT_VERSION" rat
