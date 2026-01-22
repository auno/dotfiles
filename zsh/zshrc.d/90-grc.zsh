# vim: set ts=2 sw=2 expandtab:

# Automatically enable grc for all recognized commands if available
if type grc > /dev/null && [[ -f "/etc/grc.zsh" ]]; then
  ignored_cmds=(
    gmake
    make
  )

  for ignored_cmd in $ignored_cmds; do
    if (( $+functions[$ignored_cmd] )); then
      functions -c $ignored_cmd $ignored_cmd.pre-grc-backup
    fi
  done

  . /etc/grc.zsh

  for ignored_cmd in $ignored_cmds; do
    if (( $+functions[$ignored_cmd.pre-grc-backup] )); then
      functions -c $ignored_cmd.pre-grc-backup $ignored_cmd
      unfunction $ignored_cmd.pre-grc-backup
    else
      unfunction $ignored_cmd
    fi
  done

  unset ignored_cmds ignored_cmd
fi
