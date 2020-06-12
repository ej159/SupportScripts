#!/bin/bash
dir0=$(dirname $BASH_SOURCE)
op="$1"
shift
ratver=0.13
### SELECT MIRROR!
# apachebase="http://www.mirrorservice.org/sites/ftp.apache.org/"
apachebase="http://mirror.ox.ac.uk/sites/rsync.apache.org/"
raturl="${apachebase}creadur/apache-rat-${ratver}/apache-rat-${ratver}-bin.tar.gz"
ant=${ANT-ant}
case $op in
	download)
		if curl -s -I -D - "$raturl" 2>/dev/null | grep -q 'application/x-gzip'; then
			curl -s --output - "$raturl" | (cd $dir0 && tar -zxf -)
		else
			echo "Version of RAT ($ratver) is wrong?"
			echo "RAT URL: $raturl"
		fi
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
