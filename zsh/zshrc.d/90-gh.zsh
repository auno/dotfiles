# vim: set ts=2 sw=2 expandtab:

if type gh > /dev/null; then
  _gh() {
    unset _gh
    . <(gh completion --shell zsh)
    _gh "$@"
  }

  compdef _gh gh
fi
