# Export variable instead of calling pyenv to minimize startup time.
export PYENV_VERSION=3.8.0:3.7.4:3.6.9:3.5.7:2.7.16

# Setup virtualenvwrapper
eval "$(pyenv init -)"
pyenv virtualenvwrapper_lazy
