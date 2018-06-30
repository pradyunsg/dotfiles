_pradyunsg_log "Loading virtualenvwrapper..."

export WORKON_HOME=$HOME/.venvwrap/venvs
export PROJECT_HOME=$HOME/.venvwrap/projects

if [[ "$OSTYPE" == darwin* ]]; then
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
  export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
fi

command -v virtualenvwrapper.sh >/dev/null 2>&1 && source virtualenvwrapper.sh
