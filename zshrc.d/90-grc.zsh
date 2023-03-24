# vim: set ts=2 sw=2 expandtab:

# Automatically enable grc for all recognized commands if available
if type grc > /dev/null; then
  GRC_DIRS=("~/.grc/" "/usr/share/grc/" "/usr/local/share/grc/")

  for cmd in $(ls -1 $GRC_DIRS 2>/dev/null | grep '^conf\.' | sed -r 's/^conf\.//' | sort -u); do
    if alias "$cmd" > /dev/null; then
      if [[ "$(whence "$cmd")" == "$cmd "* ]]; then
        alias "$cmd"="grc $(whence "$cmd")"
      fi
    elif type -p "$cmd" > /dev/null; then
      alias "$cmd"="grc $cmd"
    fi
  done
fi
