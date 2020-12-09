#!/bin/bash

if [ -z "$SUPPORT_DIR" -o ! -d "$SUPPORT_DIR" ]; then
	echo "::error::Undetermined support directory! ($SUPPORT_DIR)"
	exit 1
fi
cd "$SUPPORT_DIR" || exit 2

dir=apache-rat-${RAT_VERSION}
raturl="${RAT_MIRROR}creadur/$dir/$dir-bin.tar.gz"

if [ -d $dir ]; then
	echo "::debug::Already downloaded; skipping..."
	exit 0
fi

curl -s -I -D - "$raturl" 2>/dev/null | grep -q "application/x-gzip" || {
	echo "::error::Version of RAT ($RAT_VERSION) is wrong or mirror is down (URL: $raturl)"
	exit 1
}

curl -s --output - "$raturl" | tar -zxf -
exit $?
