# vim: set ts=2 sw=2 expandtab:

() {
  local variable_name
  for variable_name in $(set | grep '^___ZSHRC_' | cut -d= -f1); do
    unset "$variable_name"
  done

  local function_name
  for function_name in $(print -l ${(ok)functions} | grep '^zshrc::'); do
    unfunction "$function_name"
  done
}
