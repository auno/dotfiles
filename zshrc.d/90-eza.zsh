# vim: set ts=2 sw=2 expandtab:

if type eza > /dev/null; then
  if type fd > /dev/null; then
    _eza() {
      unset -f _eza
      ___EZA_VERSION=$( (eza --version | grep -Po '(?<=^v)\d+\.\d+\.\d+') 2>/dev/null )
      ___EZA_COMPLETIONS_PATH=$(fd --full-path "eza-${___EZA_VERSION}/completions/zsh/_eza" "$HOME/.cargo/")

      if [[ -n "${___EZA_COMPLETIONS_PATH}" ]] && [[ -f "${___EZA_COMPLETIONS_PATH}" ]]; then
        . "${___EZA_COMPLETIONS_PATH}"
        compdef __eza eza
      else
        ___EZA_COMPLETIONS_FAILED=1
      fi

      unset ___EZA_VERSION
      unset ___EZA_COMPLETIONS_PATH

      if [[ "${___EZA_COMPLETIONS_FAILED}" = "1" ]]; then
        unset ___EZA_COMPLETIONS_FAILED
        return 1
      fi
    }

    compdef _eza eza
  fi

  alias eza=eza\ --group-directories-first\ --no-quotes
fi
