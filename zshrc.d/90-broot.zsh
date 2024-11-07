# vim: set ts=2 sw=2 expandtab:

if type broot > /dev/null; then
  br() {
    unset -f br
    . <(broot --print-shell-function zsh)
    br "$@"
  }
fi
