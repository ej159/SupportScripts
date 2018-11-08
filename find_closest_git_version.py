from __future__ import print_function
from collections import defaultdict
import subprocess
import re
import sys
import os


def print_version(major, minor, patch):
    """ Print the version
    """
    print("{}.{}.{}".format(major, minor, patch))


# Get the arguments
repository = sys.argv[1]
version = sys.argv[2]

# Check if the version is a semantic version
version_match = re.match("(\d+)\.(\d+)\.(\d+)", version)
if not version_match:

    # If not a semantic version, check if the branch or tag exists
    FNULL = open(os.devnull, 'w')
    result = subprocess.call(["git", "ls-remote", repository, version],
                             stdout=FNULL, stderr=subprocess.STDOUT)
    if result == 0:
        print(version)
        sys.exit(0)

    # If it doesn't exist, return master
    print("master")
    sys.exit(0)

# If a semantic version, split in to parts
v_major = int(version_match.group(1))
v_minor = int(version_match.group(2))
v_patch = int(version_match.group(3))

# Run git ls-remote to get the list of branches and tags
git_process = subprocess.check_output(["git", "ls-remote", repository])

# Extract versions that are semantic
pattern = re.compile("^[^\s]+\s+refs/(heads|tags)/(\d+)\.(\d+)\.(\d+)$")
versions = defaultdict(set)
for line in git_process.split("\n"):
    matcher = pattern.match(line)
    if matcher:
        major = int(matcher.group(2))
        minor = int(matcher.group(3))
        patch = int(matcher.group(4))
        versions[major].add((minor, patch))

# If the major version doesn't exist, assume master
if v_major not in versions:
    print("master")
    sys.exit(0)

# If the version exists exactly, return it
matching = versions[v_major]
if (v_minor, v_patch) in matching:
    print_version(v_major, v_minor, v_patch)
    sys.exit(0)

# Look through the versions that are minor and patch of the major
incomplete_match = None
for (minor, patch) in sorted(matching):

    # If the version is the same or higher, take it
    if (minor == v_minor and patch >= v_patch) or (minor > v_minor):
        print_version(v_major, minor, patch)
        sys.exit(0)

    # If the version is the same, but the patch is not higher, store for later
    elif minor == v_minor:
        incomplete_match = (minor, patch)

# If the only match was a minor without a patch, use it
if incomplete_match is not None:
    minor, patch = incomplete_match
    print_version(v_major, minor, patch)
    sys.exit(0)

# If no match, use master
print("master")
