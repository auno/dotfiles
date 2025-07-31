# vim: set ts=2 sw=2 expandtab:

autoload is-at-least

if type eza > /dev/null; then
  alias eza=eza\ --group-directories-first
  alias ls=eza
elif [[ "$OS" = "linux" ]]; then
  alias ls=ls\ --color=auto\ -h
else
  alias ls=ls\ -h
fi

alias less=less\ -SR
alias ll=ls\ -l
alias la=ls\ -a
alias l=ls
alias lla=ls\ -la
alias lld=ls\ -ld
alias g=gvim\ --remote-silent
alias diff=diff\ -u
alias gvim=UBUNTU_MENUPROXY=\ gvim
alias df=df\ -h
alias diff=diff\ -u
alias d=dirs\ -v
alias xargs="xargs " # Expand aliases given as arguments
alias xargsn="xargs --delimiter=\"\\n\" " # Expand aliases given as arguments
alias dmesg="dmesg --reltime --color=always | less -SR +G"

if type ack-grep > /dev/null; then
  alias ack=ack-grep
fi

if [[ "$OS" = "linux" ]]; then
  alias grep=grep\ --color=auto
  alias topproc="ps axo comm,pmem,rss,vsz --sort -rss | head -n 11"

  ___ZSHRC_SUDO_OPTIONS=("--preserve-env=HOME")
  ___ZSHRC_SUDO_VERSION=$((sudo --version | grep '^Sudo version' | grep -Po '\d+\.\d+\.\d+') 2>/dev/null || echo '0.0.0')

  if is-at-least 1.9.12 "$___ZSHRC_SUDO_VERSION"; then
    ___ZSHRC_SUDO_OPTIONS+=("--no-update")
  fi

  alias sudo="sudo $___ZSHRC_SUDO_OPTIONS " # Expand aliases given as arguments
fi
