_pradyunsg_log "Setting up aliases..."

# Because I'm always improving this.
alias reload_shell="source ~/.\${CURRENT_SHELL}rc"
alias reload_prompt="source \"${SIGMA_PROMPT_LOCATION}/prompt.sh\""

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
  alias nau='nautilus'
fi

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Shorthands
alias la='ls -a'
alias ll='ls -l'
alias path='echo $PATH | tr -s ":" "\n"'
alias '?=man'

# Better safe than sorry!
alias ln="ln -v"

# -----------------------------------------------------------------------------
# Apt has a very tedious CLI
# -----------------------------------------------------------------------------
if [[ "$OSTYPE" != darwin* ]]; then
  alias apt-ar='sudo apt-get autoremove'
  alias apt-i='sudo apt-get install'
  alias apt-r='sudo apt-get remove'
  alias apt-ui='sudo apt-get remove'

  alias apt-upd='echo "Updating cache..." && sudo apt-get update > /dev/null'
  alias apt-upg='sudo apt-get upgrade'
  alias apt-upgf='sudo apt-get dist-upgrade'
fi

# -----------------------------------------------------------------------------
# Because it's shorter
# -----------------------------------------------------------------------------
alias g="git"
alias workon-ghp="rvm use ruby-2.4.0@gh-pages"
alias prompt_one_line_toggle='{
  [ "$PROMPT_POWERLINE_ONE_LINE" = "true" ] \
   && PROMPT_POWERLINE_ONE_LINE="false" \
   || PROMPT_POWERLINE_ONE_LINE="true";
}'

# For pyenv and "brew doctor" working together well.
# See https://github.com/pyenv/pyenv/issues/106
alias brew="env PATH=${PATH//$(pyenv root)\/shims:/} brew"
