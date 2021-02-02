# Initialise up pyenv, if it's available
if command -v pyenv --version > /dev/null 2>&1; then
  eval "$(pyenv init -)"

  # For pyenv and "brew doctor" working together well.
  # See https://github.com/pyenv/pyenv/issues/106
  alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
fi
