# Helper Aliases
alias v-tmp='mktmpenv'
alias v-deact='deactivate'
alias v-wipe='wipeenv'
alias v-ls='lsvirtualenv -b | column -c $COLUMNS'

# Helper Functions
function v-act() {
  if [ -r .venv ]; then
    workon "$(cat .venv)"
  else
    echo "No virtualenv associated with this directory, create a '.venv' file or use 'v-mk'"
  fi
}

function v-mk() {
  if [ -r .venv ]; then
    echo "'$(cat .venv)' virtualenv is already associated with this directory."
    return
  fi
  mkvirtualenv -a $(pwd) $(basename $(pwd)) && echo "$(basename $(pwd))" > .venv
}

function v-rm() {
  if [ -r .venv ]; then
    rmvirtualenv $(cat .venv) && rm .venv
    return
  fi
  rmvirtualenv $@
}

function v-rmtmp() {
  lsvirtualenv -b | grep tmp- | while read line; do
    rmvirtualenv $line
  done
}

alias v="echo \"\
Helper commands for managing virtualenvs

v-mk:
  Make a virtualenv for the current project directory and create a \".venv\"
  file; if it doesn't already exist.
v-rm:
  Remove the virtualenv (as given in \".venv\" or CLI; not both)
v-tmp:
  Create a temporary virtualenv
v-rmtmp:
  Remove all temporary virtualenvs
v-act:
  Activate the virtualenv specified in the \".venv\" file.
v-deact:
  Deactivate the currently active virtualenv.
v-wipe:
  Remove all packages installed in the current virtualenv
v-ls:
  List all available virtualenvs\
\""
