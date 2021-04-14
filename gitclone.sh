#!/bin/sh
# This script is called from Jenkins builds

REPO=$1
TARGET=$2

Branch=$(git ls-remote $REPO 2>/dev/null | awk '
    BEGIN {
    	id = "x"
    	# The next line is a default default only
    	branch = "REMOTE_PARSE_FAILED"
    	target_branch = "refs/heads/" ENVIRON["TRAVIS_BRANCH"]
    	target_tag = "refs/tags/" ENVIRON["TRAVIS_BRANCH"]
    }
    $2=="HEAD" {
    	# Note that the remote HEAD ref comes first
    	id = $1
    }
    $1==id {
    	sub(/refs\/(heads|tags)\//, "", $2)
    	branch = $2
    	# May be overwritten by the rule below; this is OK
    }
    $2==target_branch || $2==target_tag {
    	branch = ENVIRON["TRAVIS_BRANCH"]
    	# Reset the ID to a non-hash so the rule to match it will not fire
    	id = "x"
    }
    END {
    	print branch
    }')

git clone --branch $Branch $REPO $TARGET || exit $?
echo "checked out branch $Branch of $REPO"
