#!/bin/sh

REPO=$1
TARGET=$2
TRAVIS_BRANCH=$(echo ENVIRON["GITHUB_REF"] | cut -d'/' -f 3)

echo $TRAVIS_BRANCH

Branch=$(git ls-remote $REPO | awk '
    BEGIN {
    	branch = "master"
    	target = "refs/heads/" $TRAVIS_BRANCH"
    }
    $2==target {
    	branch = $TRAVIS_BRANCH
    }
    END {
    	print branch
    }')

echo $Branch
echo $TARGET
git clone --branch $Branch $REPO $TARGET || exit $?
echo "checked out branch $Branch of $REPO"
