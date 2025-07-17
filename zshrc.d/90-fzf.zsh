# vim: set ts=2 sw=2 expandtab:

if type fzf > /dev/null; then
  if type fd > /dev/null; then
    FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null"
    FZF_CTRL_T_COMMAND="fd --strip-cwd-prefix --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null"
    FZF_ALT_C_COMMAND="fd --strip-cwd-prefix --type d --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null"

    _fzf_compgen_path () {
      echo "$1"
      command fd --strip-cwd-prefix --hidden --exclude .git --exclude .hg --exclude .svn "$1" 2> /dev/null
    }

  _fzf_compgen_dir () {
    command fd --strip-cwd-prefix --type d --hidden --exclude .git --exclude .hg --exclude .svn 2> /dev/null
  }
  fi

  [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
  [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh

  man-fzf() {
    if [[ $# == 0 ]]; then
      args=$(
        man -k . \
          | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man | col -bx | bat -l man -p --color always' \
          | tr -d '()' \
          | awk '{printf "%s ", $2} {print $1}'
      )
      test -n "$args" || return
      "man" "${=args}"
    else
      "man" "$@"
    fi
  }

  alias man=man-fzf
fi
