#!/bin/bash

# Typing sudo apt-get... is a pain in the a**
alias apt-update="echo 'Updating cache...' && sudo apt update > /dev/null"
alias apt-upgrade="sudo apt upgrade"
alias apt-upgrade-full="sudo apt full-upgrade"

# A way to re-load the stuff
alias _reload_zshrc='source ~/.zshrc'

# Be colorful!
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Shorthands
alias md='echo "Using alias for mkdir" && mkdir'
alias la='ls -A'

# Better safe than sorry!
alias rm='rm -I --preserve-root'

alias 'pip install'='pip install --user'
#------------------------------------------------------------------------------
# Git
#------------------------------------------------------------------------------
alias gd="git diff"
alias gst="git status"
