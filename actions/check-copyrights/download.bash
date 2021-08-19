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

curl --retry 5 -I -L -D - "$raturl" |& tee -a curl_out.log | grep -q "^HTTP.*200.*$" || {
  echo "::error::Version of RAT ($RAT_VERSION) is wrong or mirror is down (URL: $raturl)"
  cat curl_out.log
  exit 1
}

curl --retry 5 -s -L --output - "$raturl" | tar -zxf -
exit $?
