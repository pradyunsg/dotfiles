export PATH="/opt/homebrew/bin:$PATH"
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
