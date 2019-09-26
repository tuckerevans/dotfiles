# .bashrc
set -o vi

PATH=~/bin:$PATH
PATH=~/.local/bin:$PATH
LPDEST=pictor

source ~/.pass_completion
source ~/.git-completion.bash
HISTSIZE=-1
HISTFILESIZE=-1

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -laF'
alias school='cd ~/Documents/clarkson'

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

