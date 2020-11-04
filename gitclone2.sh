#!/bin/sh

REPO=$1
TARGET=$2

Branch=$(git ls-remote $REPO | awk '
    BEGIN {
    	branch = "master"
    	target = "refs/heads/" ENVIRON["GITHUB_BRANCH"]
    }
    $2==target {
    	branch = ENVIRON["GITHUB_BRANCH"]
    }
    END {
    	print branch
    }')

git clone --branch $Branch $REPO $TARGET || exit $?
echo "checked out branch $Branch of $REPO"
