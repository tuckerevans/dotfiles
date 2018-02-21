# .bashrc
set -o vi

#source ~/.pass_completion 

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -la'
#alias school='cd !SCHOOL_FOLDER'

alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -o'

PS1='[\u@\h \W]\$ '

MAIL=/var/spool/mail/tje && export MAIL
export EDITOR=vi
