# vim: set ts=2 sw=2 expandtab:

if ! type fd > /dev/null; then
  if type fdfind > /dev/null; then
    alias fd=fdfind
  fi
fi

if type fd > /dev/null; then
  _fd() {
    unset -f _fd
    . <(fd --gen-completions zsh)
    _fd "$@"
  }

  compdef _fd fd
fi
