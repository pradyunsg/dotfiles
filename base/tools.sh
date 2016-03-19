
# -----------------------------------------------------------------------------
# Because local binaries matter
# -----------------------------------------------------------------------------
export PATH=$PATH:$HOME/.bin:$HOME/.local/bin

# -----------------------------------------------------------------------------
# Autoenv
# -----------------------------------------------------------------------------
export AUTOENV_FILE_ENTER=.env_enter
export AUTOENV_FILE_LEAVE=.env_leave
export AUTOENV_LOOK_UPWARDS=0

# -----------------------------------------------------------------------------
# Python
# -----------------------------------------------------------------------------
# virtualenvwrapper
export WORKON_HOME=$HOME/.venvwrap/venvs
export PROJECT_HOME=$HOME/.venvwrap/projects
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

command -v virtualenvwrapper.sh >/dev/null 2>&1 && source virtualenvwrapper.sh

# -----------------------------------------------------------------------------
# Go
# -----------------------------------------------------------------------------
export GOPATH=~/code/go

# -----------------------------------------------------------------------------
# Travis
# -----------------------------------------------------------------------------
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# -----------------------------------------------------------------------------
# Heroku
# -----------------------------------------------------------------------------
export PATH="/usr/local/heroku/bin:$PATH"

# # -----------------------------------------------------------------------------
# # JMol
# # -----------------------------------------------------------------------------
# export JMOL_HOME="$HOME/.jmol-app"
# export PATH=$JMOL_HOME:$PATH

# -----------------------------------------------------------------------------
# Ruby
# -----------------------------------------------------------------------------
# NOTE:: Keep this at the end.

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
