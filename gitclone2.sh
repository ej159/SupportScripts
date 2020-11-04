#!/bin/sh
# This script works when called from a github action on PUSH not for PULL_REQUEST

REPO=$1

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
git clone --branch $Branch $REPO || exit $?
echo "checked out branch $Branch of $REPO
