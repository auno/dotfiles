# vim: set ts=2 sw=2 expandtab:

[[ "$HOST" = "skynet" ]] || return

#
# EXPORTS
#
#export GPG_TTY=`tty`

#
#  ALIAS
#

alias screen=screen-wrapper
alias telnet=ktelnet
alias s=stopalarm\ -s
alias gpg=gpg2

if [ "$DISPLAY" != "" ]; then
    xset -b
fi

# Lazy load JDK chooser into a shell session *as a function*
if [[ "$UID" != "0" && -s "$HOME/.local/opt/jdk-chooser/scripts/jdk" ]]; then
  jdk() {
    source "$HOME/.local/opt/jdk-chooser/scripts/jdk"
    jdk "$@"
  }
fi

# Lazy load RBEnv into a shell session *as a function*
if [[ "$UID" != "0" && -d "$HOME/.rbenv" ]]; then
  export PATH="$HOME/.rbenv/shims:$PATH"
  rbenv() {
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$($HOME/.rbenv/bin/rbenv init -)"
    rehash
    rbenv "$@"
  }
fi

# Lazy load SDKMAN into a shell session *as a function*
if [[ "$UID" != "0" && -d "$HOME/.sdkman" ]]; then
  sdk() {
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk "$@"
  }
fi
