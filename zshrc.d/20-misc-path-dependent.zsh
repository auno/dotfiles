# vim: set ts=4 sw=4 expandtab:

if type bat > /dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

