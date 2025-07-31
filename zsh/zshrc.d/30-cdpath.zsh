export CDPATH="$HOME"

if [[ -d "$HOME/work" ]]; then
  export CDPATH=$(
    (echo "$CDPATH"; realpath "$HOME/work/"*) \
      | paste -sd:
  )
fi
