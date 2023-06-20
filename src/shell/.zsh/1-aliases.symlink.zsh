# Because I'm always improving this.
alias reload_shell="source ~/.\${CURRENT_SHELL}rc"

# -----------------------------------------------------------------------------
# UNIX tools
# -----------------------------------------------------------------------------
# Be colorful!

if [[ "$OSTYPE" == darwin* ]]; then
  export CLICOLOR=1
else
  alias ls='ls --color=auto'
  alias rm='rm -I --preserve-root'
fi

# Shorthands
alias la='ls -a'
alias ll='ls -lhF'
alias path='echo $PATH | tr -s ":" "\n"'
alias gpg-test='echo "test" | gpg --clearsign'

# Better safe than sorry!
alias ln="ln -v"

# -----------------------------------------------------------------------------
# DPKG has a very tedious CLI
# -----------------------------------------------------------------------------
if [[ "$OSTYPE" != darwin* ]]; then
  alias ddd="dpkg-distro-dev"
fi

# -----------------------------------------------------------------------------
# Because it's shorter
# -----------------------------------------------------------------------------
alias g="git"
alias pip-pdb="python -m pdb -m pip --debug"
alias python-debug="python -m debugpy --listen 5678 --wait-for-client"
alias dot-clean="find -L ~ -type l -maxdepth 3 -exec rm -i {} \;"

# -----------------------------------------------------------------------------
# Because it's nicer
# -----------------------------------------------------------------------------
alias make="mike"

function long() {
  $@ && say $1 succeeded || say $1 failed
}
