# vim: set ts=2 sw=2 expandtab:

[[ "$OS" = "linux" ]] || return

#
# EXPORTS
#
export GPG_TTY=`tty`
export DOCKER_BUILDKIT=1
