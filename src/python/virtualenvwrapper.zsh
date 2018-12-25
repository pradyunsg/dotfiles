# Helper Aliases
alias v-tmp='mktmpenv'
alias v-deact='deactivate'
alias v-wipe='wipeenv'
alias v-ls='lsvirtualenv -b | column -c $COLUMNS'

# Helper Functions
function v-tmp-here() {
  pushd > /dev/null
  v-tmp $@
  popd > /dev/null
}

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
  mkvirtualenv -a "$(pwd)" "$(basename "$(pwd)")" && echo "$(basename "$(pwd)")" > .venv
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

function v() {
  echo -e "Helpers for managing virtualenvs

  \e[36mv-mk\e[0m
    Make a virtualenv for the current project directory and add '.venv'

  \e[36mv-ls\e[0m
    List all available virtualenvs

  \e[36mv-rm\e[0m
    Remove the virtualenv (as given in '.venv' or CLI; not both)

  \e[36mv-tmp\e[0m
    Create a temporary virtualenv

  \e[36mv-rmtmp\e[0m
    Remove all temporary virtualenvs

  \e[36mv-act\e[0m
    Activate the virtualenv specified in the '.venv' file.

  \e[36mv-deact\e[0m
    Deactivate the currently active virtualenv.

  \e[36mv-wipe\e[0m
    Remove all packages installed in the current virtualenv
  "
}

# HACK: Use the same function as virtualenvwrapper for completion
compctl -K _virtualenvs v-rm
