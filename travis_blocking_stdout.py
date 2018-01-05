import fcntl
from os import O_NONBLOCK as NONBLOCK
from sys import stdout, stderr


def get_flags(channel):
    return fcntl.fcntl(channel, fcntl.F_GETFL)


def set_flags(channel, flags):
    fcntl.fcntl(channel, fcntl.F_SETFL, flags)


flags = get_flags(stdout)
if flags & NONBLOCK:
    set_flags(stdout, flags & ~NONBLOCK)
    stderr.writelines(["Reset STDOUT to blocking"])

flags = get_flags(stderr)
if flags & NONBLOCK:
    set_flags(stderr, flags & ~NONBLOCK)
    stderr.writelines(["Reset STDERR to blocking"])
