#!/bin/sh

REPO=$1
TARGET=$2

echo "TRAVIS_BRANCH="$TRAVIS_BRANCH
echo "GITHUB_REF"=$GITHUB_REF
TRAVIS_BRANCH=$(echo $GITHUB_REF | cut -d'/' -f 3)
echo $TRAVIS_BRANCH
export TRAVIS_BRANCH
Branch=$(git ls-remote $REPO | awk '
    BEGIN {
    	branch = "master"
    	target = ENVIRON["GITHUB_REF"]
    }
    $2==target {
    	branch = ENVIRON["TRAVIS_BRANCH"]
    }
    END {
    	print branch
    }')

git clone --branch $Branch $REPO $TARGET || exit $?
echo "checked out branch $Branch of $REPO"
