# vim: set ts=2 sw=2 expandtab:

zshrc::append_to_path "$HOME/.local/bin"

path() {
  set -o localoptions -o localtraps

  trap 'return 1' INT
  trap 'rm -f -- "$___zsh_path_edit_temp_file"; unset ___zsh_path_edit_temp_file' EXIT

  local usage_formatter=(cat)
  local list_formatter=(cat)

  if [[ -n "$BAT" ]] && type "$BAT" > /dev/null; then
    usage_formatter=("$BAT" --plain --language help)
    list_formatter=("$BAT" --plain --language ls)
  fi

  local usage_text=(
    "Usage: path [command]"
    ""
    "Commands:"
    ""
    "  list      list path elements"
    "  ls        alias for list"
    "  show      alias for list"
  )

  case "$1" in
    list | ls | show | "")
      echo "$PATH" \
        | tr ':' '\n' \
        | $list_formatter
      ;;
    edit)
      ___zsh_path_edit_temp_file=$(mktemp "${TMPDIR:-/tmp}/zsh-path-edit.XXXXXX")
      echo "$PATH" | tr ':' '\n' >! "$___zsh_path_edit_temp_file"
      "${EDITOR:-vim}" "$___zsh_path_edit_temp_file" || return 1
      path=("${(f)$(cat "$___zsh_path_edit_temp_file")}")
      ;;
    help | --help)
      (IFS=$'\n'; echo "${usage_text[*]}") \
        | $usage_formatter
      ;;
    *)
      echo "Error: Unknown command: $1" >&2
      echo >&2
      (IFS=$'\n'; echo "${usage_text[*]}") \
        | $usage_formatter \
        >&2
      return 1
      ;;
  esac
}
