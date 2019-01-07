# .bashrc
set -o vi

PATH=~/bin:$PATH

source ~/.pass_completion
HISTSIZE=10000000
HISTFILESIZE=8000000

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -laF'
alias landmark='cd /home/tje/Documents/landmark'
alias embed='landmark && cd CS2771'
alias os='landmark && cd CS3871'
alias web='landmark && cd CSC2621'
alias mobile='landmark && cd CSC2636'
alias pol='landmark && cd POL1011'
alias art='landmark && cd HIS1031'

alias school='cd /home/tje/Documents/clarkson'
alias fa='school && cd CS345'
alias pl='school && cd CS341'
alias phys='school && cd PH131'
alias calc='school && cd MA131'

alias xcopy='xclip -selection clipboard'
alias xpaste='xclip -selection clipboard -o'

alias rtv='rtv --enable-media'

alias sloc='sloccount'

alias t='t --task-dir ~/tasks'

alias fm='vifm'

PS1='[\u@\h \W]\$ '

export GPG_TTY=$(tty)

MAIL=/var/spool/mail/tje && export MAIL
export EDITOR=vim


export IRCNICK="TropicalTea"
export IRCNAME="tje"
export IRCSERVER="chat.freenode.net"

alias word=wordgrinder

GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_IGNORE_SUBMODULES=1
# GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
# GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files
# GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files
# GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10
# GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
# GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

# as last entry source the gitprompt script
# GIT_PROMPT_THEME=Custom # use custom theme specified in file GIT_PROMPT_THEME_FILE (default ~/.git-prompt-colors.sh)
GIT_PROMPT_THEME="Custom"; # use theme optimized for solarized color scheme
GIT_PROMPT_THEME_FILE=~/.git-prompt-colors.sh

source /home/tje/.git-prompt/gitprompt.sh

alias dwarf="/home/tje/Downloads/programs/df_linux/df"
alias tele="telegram -k /home/tje/Downloads/programs/tg/tg-server.pub"
