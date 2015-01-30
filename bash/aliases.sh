#!/bin/bash

# Be colorful!
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Shorthands
alias md='echo "Using alias for mkdir" && mkdir'
alias la='ls -A'

# Ask before working
alias rm='rm -I --preserve-root'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias re_config='source ~/.bashrc'

# Typing sudo apt-get... is a pain in the a**
alias apt-upgrade="sudo apt upgrade"
alias apt-upgrade-full="sudo apt full-upgrade"

alias apt-update="echo 'Updating cache...' && sudo apt-get update > /dev/null"

# Git shortcuts
alias gd="git diff"
alias gst="git st"
