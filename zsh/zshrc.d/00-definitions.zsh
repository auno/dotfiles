# vim: set ts=2 sw=2 expandtab:

___ZSHRC_INITIAL_PATH=($path)
___ZSHRC_USER_PATH=()

zshrc::append_to_path() {
  ___ZSHRC_USER_PATH+=("$1")
  path=($___ZSHRC_USER_PATH $___ZSHRC_INITIAL_PATH)
}

zshrc::prepend_to_path() {
  ___ZSHRC_USER_PATH=("$1" $___ZSHRC_USER_PATH)
  path=($___ZSHRC_USER_PATH $___ZSHRC_INITIAL_PATH)
}

OS=$(uname -s | tr "[:upper:]" "[:lower:]")
