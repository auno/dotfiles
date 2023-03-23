# vim: set ts=4 sw=4 expandtab:

[[ "$OS" = "linux" ]] || return

#
# EXPORTS
#
export GPG_TTY=`tty`
export DOCKER_BUILDKIT=1
