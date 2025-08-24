# vim: set ts=2 sw=2 expandtab:

if type eza > /dev/null; then
  if [[ -f "$___ZSHRC_COMPLETIONS_DIR/_eza" ]]; then
    compdef -a _eza eza
  fi

  alias eza=eza\ --group-directories-first\ --no-quotes
  alias tree=eza\ --tree
fi
