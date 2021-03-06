# Because I'm always improving this.
alias reload_shell="source ~/.\${CURRENT_SHELL}rc"

alias dotpath="cat ~/.dotfiles-dir; echo"
#                                   ^^^^
#                                   Need a newline after the path

# -----------------------------------------------------------------------------
# UNIX tools
# -----------------------------------------------------------------------------
# Be colorful!

if [[ "$OSTYPE" == darwin* ]]; then
  CLICOLOR=1
else
  alias ls='ls --color=auto'
  alias rm='rm -I --preserve-root'
fi

# Shorthands
alias la='ls -a'
alias ll='ls -l'
alias path='echo $PATH | tr -s ":" "\n"'
alias gpg-test='echo "test" | gpg --clearsign'

# Better safe than sorry!
alias ln="ln -v"

# -----------------------------------------------------------------------------
# Apt has a very tedious CLI
# -----------------------------------------------------------------------------
if [[ "$OSTYPE" != darwin* ]]; then
  alias ddd="dpkg-distro-dev"
fi

# -----------------------------------------------------------------------------
# Because it's shorter
# -----------------------------------------------------------------------------
alias g="git"
