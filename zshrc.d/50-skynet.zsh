# vim: set ts=4 sw=4 expandtab:

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
    jdk $@
  }
fi

# Lazy load RBEnv into a shell session *as a function*
if [[ "$UID" != "0" && -d "$HOME/.rbenv" ]]; then
  export PATH="$HOME/.rbenv/shims:$PATH"
  rbenv() {
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$($HOME/.rbenv/bin/rbenv init -)"
    rehash
    rbenv $@
  }
fi

# Lazy load NVM
load_nvm() {
  unset -f nvm
  unset -f node
  unset -f npm

  export NVM_DIR="$HOME/.nvm"

  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  if [ -d "$HOME/.npm-packages/bin" ]; then
    export PATH="$HOME/.npm-packages/bin:$PATH"
  fi
}

if [[ "$UID" != "0" && -d "$HOME/.nvm" ]]; then
  nvm() {
    load_nvm
    nvm $@
  }

  node() {
    load_nvm
    node $@
  }

  npm() {
    load_nvm
    npm $@
  }

fi

# Lazy load SDKMAN into a shell session *as a function*
if [[ "$UID" != "0" && -d "$HOME/.sdkman" ]]; then
  sdk() {
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk $@
  }
fi
