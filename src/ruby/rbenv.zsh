# Initialise up rbenv, if it's available
if command -v rbenv --version > /dev/null 2>&1; then
  eval "$(rbenv init -)"
fi
