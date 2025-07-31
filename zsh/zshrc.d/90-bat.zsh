# vim: set ts=2 sw=2 expandtab:

BAT=bat

if ! type $BAT > /dev/null; then
  if type batcat > /dev/null; then
    alias bat=batcat
    BAT=batcat
  fi
fi

if type $BAT > /dev/null; then
  export MANPAGER="sh -c 'col -bx | $BAT -l man -p'"
  export MANROFFOPT="-c"
  alias cat="bat --plain --paging=never"
  alias -g -- "--help"="--help | bat -plhelp"

  _bat() {
    unset -f _bat
    . <(bat --completion zsh)
    compdef _bat_main bat
    _bat_main "$@"
  }

  compdef _bat bat
fi

