# .bashrc
set -o vi

source ~/.pass_completion

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -la'
alias school='cd /home/tje/Documents/landmark'
alias embed='school && cd CS2771'
alias os='school && cd CS3871'
alias web='school && cd CSC2621'
alias mobile='school && cd CSC2636'
alias pol='school && cd POL1011'
alias art='school && cd HIS1031'

alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -o'

PS1='[\u@\h \W]\$ '

MAIL=/var/spool/mail/tje && export MAIL
export EDITOR=vi
