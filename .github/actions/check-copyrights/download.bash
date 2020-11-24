#!/bin/bash
dir0=$(dirname $BASH_SOURCE)

if [ "x$SUPPORT_DIR" = "x" ]; then
	export SUPPORT_DIR=$(cd $dir0 && cd ../../.. || cd; pwd)
fi
ratver=$RAT_VERSION
apachebase=$RAT_MIRROR
raturl="${apachebase}creadur/apache-rat-${ratver}/apache-rat-${ratver}-bin.tar.gz"

if curl -s -I -D - "$raturl" 2>/dev/null | grep -q "application/x-gzip"; then
	curl -s --output - "$raturl" | (cd "$SUPPORT_DIR" && tar -zxf -)
	exit $?
else
	echo "Version of RAT ($ratver) is wrong or mirror is down" >&2
	echo "RAT URL: $raturl" >&2
	exit 1
fi
