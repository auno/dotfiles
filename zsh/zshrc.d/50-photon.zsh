# vim: set ts=2 sw=2 expandtab:

[[ "$HOST" = "photon" ]] || return

source $HOME/.gentoo/java-env

#
# EXPORTS
#
export XMMS_PATH=unix:///tmp/xmms-ipc-auno
export MPD_HOST=127.0.0.1
export MPD_PORT=6600

#
#  ALIAS
#
alias ls=ls\ --color=auto\ -h
alias screen=screen-wrapper
alias telnet=ktelnet
alias x2=xmms2
alias topproc="ps axo comm,pmem,rss,vsz --sort -vsz | head -n 11"
svndiff () { svn diff "${@}" | colordiff | less -R }

#
#  KEYCHAIN
#
keychain --quiet ~/.ssh/id_rsa
. ~/.keychain/$HOST-sh
