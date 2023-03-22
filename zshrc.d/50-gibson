# vim: set ts=2 sw=2 expandtab:

[[ "$HOST" = "gibson" || "$HOST" = "zero" ]] || return

#
# EXPORTS
#
#export GPG_TTY=`tty`

#
#  ALIAS
#
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

# Lazy load asdf into a shell session *as a function*
if [[ "$UID" != "0" && -d "$HOME/.asdf" ]]; then
  asdf() {
    export SDKMAN_DIR="$HOME/.asdf"
    [[ -s "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh"
    [[ -s "$HOME/.asdf/completions/asdf.bash" ]] && source "$HOME/.asdf/completions/asdf.bash"
    unset -f asdf
    asdf $@
  }
fi

# Add Rust to PATH if available
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Lazy load broot into a shell session *as a function*
if [[ "$UID" != "0" && -f "$HOME/.config/broot/launcher/bash/br" ]]; then
  br() {
    source /home/auno/.config/broot/launcher/bash/br
    br $@
  }
fi

if type aws_completer > /dev/null; then
  complete -C "$(which aws_completer)" aws
fi
