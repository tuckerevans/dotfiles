# .bashrc
set -o vi

#source ~/.pass_completion 

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -laF'

alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -o'

alias rtv='rtv --enable-media'

alias sloc='sloccount'

PS1='[\u@\h \W]\$ '

export GPG_TTY=$(tty)

MAIL=/var/spool/mail/tje && export MAIL
export EDITOR=vim


export IRCNICK="TropicalTea"
export IRCNAME="tje"
export IRCSERVER="chat.freenode.net"

alias word=wordgrinder
