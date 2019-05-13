#!/bin/sh

function git_sync {
	[ -d $1/.git ] && (
		echo "Synchronising $1..."
		cd $1
		for remote in `git remote`; do
			git fetch $remote && git remote prune $remote
		done
	)
}

if [ -n "$1" ] && [ "$1" = "-h" -o "$1" = "-help" -o "$1" = "--help" ]; then
	echo "Usage: $0 ?-help? ?BASEDIR?"
	echo ""
	echo "This script synchronises all git repositories within the given BASEDIR"
	echo "(or the current directory if that is not specified). A repository is"
	echo "synchronised if all of its remote branches are in the same state as the"
	echo "corresponding branch on each remote (typically called 'origin')."
	echo ""
	echo "The -help option (also -h and --help) prints this message."
	exit
fi
if [ -n "$1" ] && [ -d "$1" ]; then
	cd "$1"
fi
for dir in *; do
	git_sync ${dir}
done
