#!/bin/bash

# A way to re-load the stuff
alias _reload_bashrc='source ~/.bashrc'

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
