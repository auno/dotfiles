# Lazy load NVM
if [[ "$UID" != "0" && -d "$HOME/.nvm" ]]; then
  nvm() {
    unset -f nvm

    export NVM_DIR="$HOME/.nvm"

    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    if [ -d "$HOME/.npm-packages/bin" ]; then
      export PATH="$HOME/.npm-packages/bin:$PATH"
    fi

    nvm "$@"
  }
fi
