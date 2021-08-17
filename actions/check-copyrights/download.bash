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

curl --retry 5 -s -I -L -D - "$raturl" 2>/dev/null | grep -q "200 OK" || {
  echo "::error::Version of RAT ($RAT_VERSION) is wrong or mirror is down (URL: $raturl)"
  exit 1
}

curl -s -L --output - "$raturl" | tar -zxf -
exit $?
