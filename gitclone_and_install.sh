#!/bin/sh

# Oulls from github either the cureent branch or master
# Then installs it.
# Works for a github push action but not a pull_request
REPO=$1
GIT_PATH=https://github.com/SpiNNakerManchester/${REPO}.git

Branch=$(git ls-remote $GIT_PATH | awk '
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
git clone --branch $Branch $GIT_PATH || exit $?
echo "checked out branch $Branch of GIT_PATH"
cd ${REPO}
python setup.py install