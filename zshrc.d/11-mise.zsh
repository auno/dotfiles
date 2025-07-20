# vim: set ts=2 sw=2 expandtab:

if type mise > /dev/null; then
  zshrc::add_to_path "$HOME/.local/share/mise/shims"

  _mise() {
    unset _mise
    . <(mise completion zsh)
    _mise "$@"
  }

  compdef _mise mise
fi
