#!/bin/sh

xmllint=xmllint
file=$1
xpath="string(//*[local-name()='algorithms']/attribute::*[local-name()='schemaLocation'])"
schema=`$xmllint --xpath "$xpath" $file | awk '{print $2}'`

export XML_CATALOG_FILES=`dirname $0`/xml-support/catalog.xml

if [ -n $schema ]; then
	echo Validating against schema $schema
	exec $xmllint --schema $schema --noout $file
else
	echo Schema-less check
	exec $xmllint --noout $file
fi
