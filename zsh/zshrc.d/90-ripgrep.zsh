# vim: set ts=2 sw=2 expandtab:

if ! type rg > /dev/null; then
  if type ripgrep > /dev/null; then
    alias rg=ripgrep
  fi
fi

if type rg > /dev/null; then
  _rg() {
    unset _rg
    . <(rg --generate complete-zsh)
    _rg "$@"
  }

  compdef _rg rg
fi
