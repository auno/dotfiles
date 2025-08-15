# vim: set ts=2 sw=2 expandtab:

setopt PROMPT_SUBST

git_prompt_branch() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

  if [[ "$branch" == "HEAD" || "$branch" == "" ]]; then
    git name-rev --name-only --no-undefined --always HEAD 2>/dev/null
  else
    echo "$branch"
  fi
}

git_prompt_dirty() {
  git diff-index --quiet HEAD -- 2>/dev/null || echo "*"
}

git_prompt_info() {
  echo "$(git_prompt_branch)$(git_prompt_dirty)"
}

vcs_precmd() {
  if [[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" == "true" ]]; then
    VCS_PROMPT=" %{$fg_no_bold[yellow]%}<$(git_prompt_info)>"
  else
    VCS_PROMPT=''
  fi
}

urgent() {
  if [ "$___TERMINAL_URGENCY_HINT_FIRST_COMMAND" = "false" ]; then
    # Echo a BELL character to cause the terminal to set the urgency hint
    echo -en "\a"
  fi

  ___TERMINAL_URGENCY_HINT_FIRST_COMMAND=false
}

autoload -U add-zsh-hook
add-zsh-hook precmd vcs_precmd
add-zsh-hook precmd urgent

if [[ "$UID" == "0" ]]; then
  USER_PROMPT="%m"
  USER_PROMPT_COLOR="red"
else
  USER_PROMPT="%n@%m"
  USER_PROMPT_COLOR="blue"
fi

export PROMPT=" %{${fg_bold[$USER_PROMPT_COLOR]}%}$USER_PROMPT %{$fg_bold[default]%}>> %{$reset_color%}"
export RPROMPT="%{$fg_no_bold[default]%}%~\$VCS_PROMPT %{$fg_bold[blue]%}[%(?.%{$fg_bold[default]%}0.%{$fg_bold[red]%}%?)%{$fg_bold[blue]%}]%{$reset_color%}"
