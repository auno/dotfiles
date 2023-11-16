# vim: set ts=2 sw=2 expandtab:

if ! type fd > /dev/null; then
  if type fdfind > /dev/null; then
    alias fd=fdfind
  fi
fi
