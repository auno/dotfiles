# vim: set ts=2 sw=2 expandtab:

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
alias g=gvim\ --remote-silent
alias diff=diff\ -u
alias gvim=UBUNTU_MENUPROXY=\ gvim
alias df=df\ -h
alias diff=diff\ -u
alias d=dirs\ -v

if type ack-grep > /dev/null; then
  alias ack=ack-grep
fi

if [[ "$OS" = "linux" ]]; then
  alias grep=grep\ --color=auto
  alias topproc="ps axo comm,pmem,rss,vsz --sort -rss | head -n 11"
  alias sudo=sudo\ --preserve-env=HOME
fi
