# vim: set ts=2 sw=2 expandtab:

if type mise > /dev/null; then
  zshrc::prepend_to_path "$HOME/.local/share/mise/shims"

  MISE=$(command -v mise)

  mise() {
    (
      # `--cd "$HOME"` makes sure env is not affected by any config in $CWD
      . <("$MISE" env --cd "$HOME" | grep 'export MISE_')
      "$MISE" "$@"
    )
  }

  _mise() {
    unset _mise
    . <(mise completion zsh)
    _mise "$@"
  }

  compdef _mise mise
fi
