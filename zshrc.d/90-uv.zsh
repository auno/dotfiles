export UV_TOOL_BIN_DIR="$HOME/.local/share/uv/tools.bin"

zshrc::add_to_path "$UV_TOOL_BIN_DIR"

if type uv > /dev/null; then
  ___load_uv_completions() {
    unset -f _uv
    unset -f _uvx
    unset -f ___load_uv_completions

    . <(uv generate-shell-completion zsh)
    . <(uvx --generate-shell-completion zsh)
  }

  _uv() {
    ___load_uv_completions
    _uv "$@"
  }

  _uvx() {
    ___load_uv_completions
    _uvx "$@"
  }

  compdef _uv uv
  compdef _uvx uvx
fi
