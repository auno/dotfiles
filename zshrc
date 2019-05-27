# vim: set ts=4 sw=4 expandtab:

if [ -r "$HOME/.zsh/zshrc-functions" ]; then 
  . "$HOME/.zsh/zshrc-functions"
fi

#
#  VARIABLES
#
HISTFILE=~/.zsh_history
SAVEHIST=1000000
HISTSIZE=1000000

#
# EXPORTS
#
export BROWSER=firefox
export EDITOR=vim
export PATH="$HOME/.local/bin:$PATH"
export PAGER=less

if [ "$DISPLAY" != "" ]; then
    export TERM=xterm-256color
fi

#
#  OPTIONS
#
setopt AUTO_CONTINUE
setopt AUTO_PUSHD
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt NO_AUTO_MENU
setopt NO_AUTO_REMOVE_SLASH
setopt NO_CHECK_JOBS
setopt NO_CLOBBER
setopt NO_HUP
setopt PUSHD_SILENT
setopt RE_MATCH_PCRE

#
#  ALIAS
#
alias less=less\ -SR
alias ll=ls\ -l
alias la=ls\ -a
alias l=ls
alias lla=ls\ -la
alias g=gvim\ --remote-silent
alias diff=diff\ -u
alias gvim=UBUNTU_MENUPROXY=\ gvim

#
#  ZSH MODULES
#
autoload -U colors; colors
autoload -U compinit; compinit
autoload -U edit-command-line; zle -N edit-command-line

#
# COMPLETION
#
zmodload -i zsh/complist
zstyle ':completion:*' list-colors `dircolors | tr : ' '`

# Case insensitive autocompletion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#
#  KEYBINDINGS
#
bindkey -e # Set initial keymap to emacs emulation.

bindkey '^[[1~' beginning-of-line                   # HOME
bindkey '^[[2~' overwrite-mode                      # INSERT
bindkey '^[[3~' delete-char                         # DELETE
bindkey '^[[4~' end-of-line                         # END
bindkey '^[[5~' history-beginning-search-backward   # PAGE UP
bindkey '^[[6~' history-beginning-search-forward    # PAGE DOWN
bindkey '^[[H'	beginning-of-line                   # HOME
bindkey '^[[F'	end-of-line                         # END

bindkey '^Xe'   edit-command-line

# Prepend sudo using Alt-s
function prepend-sudo {
  if ! [[ $BUFFER =~ '^ *sudo ' ]]; then
    BUFFER="sudo $BUFFER"; CURSOR+=5
  fi
}
zle -N prepend-sudo
bindkey "^[s" prepend-sudo

#
#  MISC
#

# backward-kill-word to slash or period etc, instead of just space
autoload -U select-word-style
select-word-style bash

#
# DIRCOLORS
#

DIRCOLORS_FILE="$HOME/.dir_colors/dircolors"

if [ -r "$DIRCOLORS_FILE" ]; then
    eval $(dircolors "$DIRCOLORS_FILE")
fi

#
#  PROMPT
#

if [ -r "$HOME/.zsh/zshrc-prompt" ]; then 
  . "$HOME/.zsh/zshrc-prompt"
fi

#
# SYSTEM/HOST SPECIFIC CONFIGURATION
#

SYSTEM=`uname -s`
SYSTEM=`toLower $SYSTEM`

if [ -r "$HOME/.zsh/zshrc-$SYSTEM" ]; then
    source "$HOME/.zsh/zshrc-$SYSTEM"
fi

if [ -r "$HOME/.zsh/zshrc-$HOST" ]; then 
    source "$HOME/.zsh/zshrc-$HOST"
fi

if [ -r "$HOME/.locale" ]; then
    source "$HOME/.locale"
fi

