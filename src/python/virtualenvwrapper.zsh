export VENV_NAME_FILE=".venvname"

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
  if [ -r ${VENV_NAME_FILE} ]; then
    workon "$(cat ${VENV_NAME_FILE})"
  else
    echo "No virtualenv associated with this directory, create a '${VENV_NAME_FILE}' file or use 'v-mk'"
  fi
}

function v-mk() {
  if [ -r ${VENV_NAME_FILE} ]; then
    echo "'$(cat ${VENV_NAME_FILE})' virtualenv is already associated with this directory."
    return
  fi
  mkvirtualenv -a "$(pwd)" "$(basename "$(pwd)")" && echo "$(basename "$(pwd)")" > ${VENV_NAME_FILE}
}

function v-rm() {
  if [ -r ${VENV_NAME_FILE} ]; then
    rmvirtualenv $(cat ${VENV_NAME_FILE}) && rm ${VENV_NAME_FILE}
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
    Make a virtualenv for the current project directory and add '${VENV_NAME_FILE}'

  \e[36mv-ls\e[0m
    List all available virtualenvs

  \e[36mv-rm\e[0m
    Remove the virtualenv (as given in '${VENV_NAME_FILE}' or CLI; not both)

  \e[36mv-tmp\e[0m
    Create a temporary virtualenv

  \e[36mv-rmtmp\e[0m
    Remove all temporary virtualenvs

  \e[36mv-act\e[0m
    Activate the virtualenv specified in the '${VENV_NAME_FILE}' file.

  \e[36mv-deact\e[0m
    Deactivate the currently active virtualenv.

  \e[36mv-wipe\e[0m
    Remove all packages installed in the current virtualenv
  "
}

# HACK: Use the same function as virtualenvwrapper for completion
compctl -K _virtualenvs v-rm
