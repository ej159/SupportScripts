#!/bin/sh

REPO=$1
TARGET=$2

Branch=$(git ls-remote $REPO | awk '
    BEGIN {
    	branch = "master"
    	target = "refs/heads/" ENVIRON["GITHUB_REF"]
    }
    $2==target {
    	branch = ENVIRON["GITHUB_REF"]
    }
    END {
    	print branch
    }')

git clone --branch $Branch $REPO $TARGET || exit $?
echo "checked out branch $Branch of $REPO"
