#!/bin/sh

REPO=$1
TARGET=$2
echo "GITHUB_REF"=$GITHUB_REF
Branch=$(git ls-remote $REPO | awk '
    BEGIN {
    	branch = "master"
    	target = ENVIRON["GITHUB_REF"]
    }
    $2==target {
    	branch = ENVIRON["GITHUB_REF"]
    }
    END {
    	print branch
    }')
Branch=${Branch#refs/heads/}
git clone --branch $Branch $REPO $TARGET || exit $?
echo "checked out branch $Branch of $REPO"
