# vim: set ts=2 sw=2 expandtab:

if type openshell > /dev/null; then
  _openshell() {
    unset -f _openshell
    . <(openshell completions zsh)
    "${_comps[openshell]}" "$@"
  }

  compdef _openshell openshell
fi
