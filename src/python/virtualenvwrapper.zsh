# Helper Aliases
#   I think these should become functions but I will do that later. Possibly
#   even package it up into a nice plugin-like thing to make life easier?

alias v-tmp='mktmpenv'
alias v-mk='\
  [ -e .venv ] \
  && echo "\"$(cat .venv)\" virtualenv is already associated with this directory." \
  || mkvirtualenv -a $(pwd) $(basename $(pwd)) && echo "$(basename $(pwd))" > .venv
'
alias v-rm='([ -e .venv ] && rmvirtualenv $(cat .venv) && rm .venv) || rmvirtualenv'
alias v-rmtmp='lsvirtualenv -b | grep tmp- | while read line ; do rmvirtualenv $line ; done'

alias v-act='[ -e .venv ] && workon "$(cat .venv)" || echo "No virtualenv associated with this directory."'
alias v-deact='deactivate'

alias v-wipe='wipeenv'
alias v-ls='lsvirtualenv -b | column -c $COLUMNS'

alias v='echo "\
Helper commands for managing virtualenvs

v-mk:
    Make a virtualenv for the current project directory and create a \".venv\"
    file; if it doesn''t already exist.
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
"'
