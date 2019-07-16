#!/bin/bash

# For every committed file in the current git repository, report the filename,
# the hash, and the date of the *first* commit to that file. This isn't
# necessarily the age of the content of the file (due to file renaming) but it
# is the most readily available automatically-derived approximation to it.

for filename in $(git ls-files); do
    hash=$(git rev-list HEAD "$filename" | tail -n 1)
    date=$(git show -s --format="%ci" "$hash" --)
    printf "%-35s %s:\n  %s\n" "$filename" "$hash" "$date"
done
