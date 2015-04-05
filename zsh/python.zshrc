# pip
export PIP_DOWNLOAD_CACHE=$HOME/.cache/pip

# virtualenvwrapper
export WORKON_HOME=$HOME/.venvwrap/venvs
export PROJECT_HOME=$HOME/.venvwrap/projects

command -v virtualenvwrapper.sh >/dev/null 2>&1 && source virtualenvwrapper.sh
