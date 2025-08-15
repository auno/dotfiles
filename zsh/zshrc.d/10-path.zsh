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
    "Usage: [option...] path [command]"
    ""
    "Commands:"
    ""
    "  list      list path elements"
    "  ls        alias for list"
    "  show      alias for list"
    ""
    "Options:"
    ""
    "  --cdpath  edit \$CDPATH instead of \$PATH"
    "  --fpath   edit \$FPATH instead of \$PATH"
  )

  local variable_name="PATH"

  while true; do
    case "$1" in
      "list" | "ls" | "show" | "")
        echo "${(P)variable_name}" \
          | tr ':' '\n' \
          | $list_formatter
        break
        ;;
      "edit")
        local variable_array_name="${(L)variable_name}"
        ___zsh_path_edit_temp_file=$(mktemp "${TMPDIR:-/tmp}/zsh-path-edit.XXXXXX")
        echo "${(P)variable_name}" | tr ':' '\n' >! "$___zsh_path_edit_temp_file"
        "${EDITOR:-vim}" "$___zsh_path_edit_temp_file" || return 1
        local -a updated_paths=("${(f)$(cat "$___zsh_path_edit_temp_file")}")
        case "$variable_name" in
          "PATH")
            path=($updated_paths)
            ;;
          "CDPATH")
            cdpath=($updated_paths)
            ;;
          "FPATH")
            fpath=($updated_paths)
            ;;
        esac
        break
        ;;
      "help" | "--help")
        (IFS=$'\n'; echo "${usage_text[*]}") \
          | $usage_formatter
        break
        ;;
      "--cdpath")
        variable_name="CDPATH"
        shift
        ;;
      "--fpath")
        variable_name="FPATH"
        shift
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
  done
}
