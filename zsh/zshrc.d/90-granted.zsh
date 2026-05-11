# vim: set ts=2 sw=2 expandtab:

if type assume > /dev/null; then
  assume() {
    unset -f assume

    if [[ "$(whence -p assume)" == */mise/* ]]; then
      __ZSHRC_ASSUME="$(mise x -- which assume)"
    else
      __ZSHRC_ASSUME="$(command -v assume)"
    fi

    functions[assume]=$(
      echo "export GRANTED_ALIAS_CONFIGURED=\"true\""
      < "$__ZSHRC_ASSUME"
    )
    unset __ZSHRC_ASSUME

    assume "$@"
  }
fi
