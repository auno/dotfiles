# vim: set ts=2 sw=2 expandtab:

zshrc::add_to_path "$HOME/.cargo/bin"

_rustup() {
  unset -f _rustup
  . <(rustup completions zsh)
  _rustup "$@"
}

compdef _rustup rustup

_cargo() {
  unset -f _cargo
  . <(rustup completions zsh cargo)
  _cargo "$@"
}

compdef _cargo cargo
