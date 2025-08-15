# vim: set ts=2 sw=2 expandtab:

[[ "$HOST" = "auno01" ]] || return

#
# EXPORTS
#
export http_proxy="http://www-proxy.se.oracle.com:80"
export https_proxy="http://www-proxy.se.oracle.com:80"
export P4CONFIG=.p4config
export TERM=xterm-256color
export PATH=$PATH:/home/appeal/bin:/home/auno/.local/opt/android-sdk-linux/tools:$HOME/.gem/ruby/1.8/bin
export P4DIFF="colordiff -u"

#
# ALIAS
#

#
# MISC
#
xset -b

# Load RVM into a shell session *as a function*
if [ "$UID" != "0" ]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi
