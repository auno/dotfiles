# vim: set ts=2 sw=2 expandtab:

if type fzf > /dev/null; then
  if type fd > /dev/null; then
    export FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null"
    export FZF_CTRL_T_COMMAND="fd --strip-cwd-prefix --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null"
    export FZF_ALT_C_COMMAND="fd --strip-cwd-prefix --type d --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null"

    _fzf_compgen_path () {
      echo "$1"
      command fd --strip-cwd-prefix --hidden --exclude .git --exclude .hg --exclude .svn "$1" 2> /dev/null
    }

    _fzf_compgen_dir () {
      command fd --strip-cwd-prefix --type d --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null
    }
  fi

  ___ZSHRC_FZF_VERSION=$(
    (fzf --version | grep -Po '\d+\.\d+\.\d+') 2>/dev/null || echo '0.0.0'
  )

  if is-at-least 0.48.0 "$___ZSHRC_FZF_VERSION"; then
    . <(fzf --zsh) 
  else
    [[ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]] && source "/usr/share/doc/fzf/examples/key-bindings.zsh"
    [[ -f "/usr/share/doc/fzf/examples/completion.zsh" ]] && source "/usr/share/doc/fzf/examples/completion.zsh"
    [[ -n "$TERMUX__PREFIX" ]] && [[ -f "$TERMUX__PREFIX/share/fzf/key-bindings.zsh" ]] && source "$TERMUX__PREFIX/share/fzf/key-bindings.zsh"
    [[ -n "$TERMUX__PREFIX" ]] && [[ -f "$TERMUX__PREFIX/share/fzf/completion.zsh" ]] && source "$TERMUX__PREFIX/share/fzf/completion.zsh"
  fi

  fzf-select-man-page() {
    if [[ "$BUFFER" == "man" ]]; then
      args=$(
        set -o pipefail
        man -k . \
          | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man | col -bx | bat -l man -p --color always' \
          | tr -d '()' \
          | awk '{printf "%s ", $2} {print $1}'
      )

      if [[ "$?" -eq 0 ]]; then
        BUFFER="man $args"
      fi
    fi

    zle .$WIDGET "$@"
  }

  zle -N accept-line fzf-select-man-page
fi
