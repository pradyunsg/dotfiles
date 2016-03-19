
# Because I'm always improving this.
alias reload_shell="source ~/.\${CURRENT_SHELL}rc"

# -----------------------------------------------------------------------------
# UNIX tools
# -----------------------------------------------------------------------------
# Be colorful!
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Shorthands
alias md='echo "Using alias for mkdir" && mkdir'
alias la='ls -a'
alias nau='nautilus'

alias apt-update="echo 'Updating cache...' && sudo apt-get update > /dev/null"
alias apt-upgrade="sudo apt-get upgrade"
alias apt-upgrade-full="sudo apt-get dist-upgrade"

# Better safe than sorry!
alias rm='rm -I --preserve-root'

# -----------------------------------------------------------------------------
# Git
# -----------------------------------------------------------------------------
alias gst="git st"

# -----------------------------------------------------------------------------
# Because we need inspiration and laughter in life.
# -----------------------------------------------------------------------------
alias forsay="fortune | cowsay | lolcat"

# -----------------------------------------------------------------------------
# virtualenvwrapper shorthands
# -----------------------------------------------------------------------------
alias mkvenv="mkvirtualenv"
alias rmvenv="rmvirtualenv"
