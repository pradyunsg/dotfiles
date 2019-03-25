# Export variable instead of calling pyenv to minimize startup time.
export PYENV_VERSIONS=3.7.1:3.6.7:3.5.6:3.4.9:2.7.15

# Load lazily to minimize startup time.
export VIRTUALENVWRAPPER_SCRIPT=/Users/pradyunsg/.pyenv/versions/3.7.1/bin/virtualenvwrapper.sh
source /Users/pradyunsg/.pyenv/versions/3.7.1/bin/virtualenvwrapper_lazy.sh
