#!/bin/sh

file=$1
xpath="string(//*[local-name()='algorithms']/attribute::*[local-name()='schemaLocation'])"
schema=`xmllint --xpath "$xpath" $file | awk '{print $2}'`

if [ -n "$schema" ]; then
	echo "Validating $file against schema $schema"
	exec xmllint --schema "$schema" --noout "$file"
else
	echo "Checking $file for well-formedness"
	exec xmllint --noout "$file"
fi
