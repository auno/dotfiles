# vim: set ts=2 sw=2 expandtab:

___ZSHRC_COMPLETIONS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh-completions.d"

if [[ -d "$___ZSHRC_COMPLETIONS_DIR" ]] && [[ ":$FPATH:" != *":$___ZSHRC_COMPLETIONS_DIR:"* ]]; then
  FPATH="$___ZSHRC_COMPLETIONS_DIR:$FPATH"
fi
