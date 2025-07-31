# vim: set ts=2 sw=2 expandtab:

# Automatically enable grc for all recognized commands if available
if type grc > /dev/null && [[ -f "/etc/grc.zsh" ]]; then
  . /etc/grc.zsh
fi
