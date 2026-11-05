if [[ -n "$LLM_AGENT" ]]; then
  unset CDPATH
  return
fi

export CDPATH="$HOME"

if [[ -d "$HOME/work" ]]; then
  export CDPATH=$(
    (echo "$CDPATH"; realpath "$HOME/work/"*) \
      | paste -sd:
  )
fi
