#!/bin/bash
dir0=$(dirname $BASH_SOURCE)
op="$1"
shift
ratver=0.13
raturl="http://www.mirrorservice.org/sites/ftp.apache.org/creadur/apache-rat-${ratver}/apache-rat-${ratver}-bin.tar.gz"
ant=${ANT-ant}
case $op in
	download)
		curl --output - "$raturl" | (cd $dir0 && tar -zxf -)
		;;
	run)
		# java -jar "${dir0}/apache-rat-${ratver}/apache-rat-${ratver}.jar" ${1+"$@"}
		eval $ant "-e -q -f $dir0/rat.xml -lib $dir0/apache-rat-$ratver rat"
		;;
	*)
		echo "unknown op \"$op\": must be download or run" >&2
		exit 1
		;;
esac
exit $?
