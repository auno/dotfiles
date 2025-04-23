if type gh > /dev/null; then
  _gh() {
    . <(gh completion --shell zsh)
    _gh "$@"
  }

  compdef _gh gh
fi
