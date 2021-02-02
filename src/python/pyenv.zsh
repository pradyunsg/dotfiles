# Initialise up pyenv, if it's available
if command -v pyenv --version > /dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
