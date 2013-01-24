# vim: set ts=4 sw=4 expandtab:

if [ -r "$HOME/.zsh/zshrc-functions" ]; then 
. "$HOME/.zsh/zshrc-functions"
fi

#
#  VARIABLES
#
HISTFILE=~/.zsh_history
SAVEHIST=25000
HISTSIZE=25000

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
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt NO_AUTO_MENU
setopt NO_AUTO_REMOVE_SLASH
setopt NO_CHECK_JOBS
setopt NO_CLOBBER
setopt NO_HUP
setopt PUSHD_SILENT

#
#  ALIAS
#
alias less=less\ -S
alias ll=ls\ -l
alias la=ls\ -a
alias l=ls
alias lla=ls\ -la
alias g=gvim\ --remote-silent
alias diff=diff\ -u
alias gvim=UBUNTU_MENUPROXY=\ gvim

svndiff () {
    if which colordiff > /dev/null; then
        svn diff "${@}" | colordiff | less -FXR
    else
        svn diff | less -FXR
    fi
}

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

#
#  MISC
#

#
#  PROMPT
#

if [ "$UID" = "0" ]; then
    export PROMPT=" %{${fg_bold[red]}%}%m %{$fg_bold[default]%}>%{$fg_no_bold[default]%}> %{$reset_color%}"
    export RPROMPT="%{$fg_no_bold[default]%}%~ %{$fg_bold[default]%}[%(?.%{$fg_bold[default]%}0.%{$fg_bold[red]%}%?)%{$fg_bold[default]%}]%{$reset_color%}"
else
    export PROMPT=" %{${fg_bold[green]}%}%n@%m %{$fg_bold[default]%}>%{$fg_no_bold[default]%}> %{$reset_color%}"
    export RPROMPT="%{$fg_no_bold[default]%}%~ %{$fg_bold[blue]%}[%(?.%{$fg_bold[default]%}0.%{$fg_bold[red]%}%?)%{$fg_bold[blue]%}]%{$reset_color%}"
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

