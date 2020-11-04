#!/bin/sh

REPO=$1
TARGET=$2

echo "BRANCH_NAME:" $BRANCH_NAME
Branch=$(git ls-remote $REPO | awk '
    BEGIN {
    	branch = "master"
    	target = "refs/heads/" ENVIRON["BRANCH_NAME"]
    }
    $2==target {
    	branch = ENVIRON["BRANCH_NAME"]
    }
    END {
    	print branch
    }')

git clone --branch $Branch $REPO $TARGET || exit $?
echo "checked out branch $Branch of $REPO"
