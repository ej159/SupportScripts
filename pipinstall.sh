#!/bin/sh

REPO=$1

Branch=$(git ls-remote $REPO | awk '
    BEGIN {
    	branch = "master"
    	target = "refs/heads/" ENVIRON["TRAVIS_BRANCH"]
    }
    $2==target {
    	branch = ENVIRON["TRAVIS_BRANCH"]
    }
    END {
    	print branch
    }')

pip install --upgrade git+$REPO@$Branch
