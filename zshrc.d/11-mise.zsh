# vim: set ts=2 sw=2 expandtab:

if type mise > /dev/null; then
  zshrc::add_to_path "$HOME/.local/share/mise/shims"

  if [[ -f "$HOME/.mise-envs" ]]; then
    export MISE_ENV=$(cat "$HOME/.mise-envs" | paste -sd,)
  fi

  _mise() {
    unset _mise
    . <(mise completion zsh)
    _mise "$@"
  }

  compdef _mise mise
fi
