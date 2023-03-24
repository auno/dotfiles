# vim: set ts=2 sw=2 expandtab:

if type bat > /dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

