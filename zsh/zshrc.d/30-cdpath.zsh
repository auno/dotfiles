if [[ -n "$LLM_AGENT" ]]; then
  unset CDPATH
  return
fi

CDPATH="$HOME"

if [[ -d "$HOME/work" ]]; then
  CDPATH=$(
    (echo "$CDPATH"; realpath "$HOME/work/"*) \
      | paste -sd:
  )
fi
