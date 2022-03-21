export ZPLUG_HOME=${ZPLUG_HOME:="/opt/homebrew/opt/zplug"}
export ZPLUG_REPOS=${ZPLUG_REPOS:="$HOME/.zplug"}
source $ZPLUG_HOME/init.zsh

command -v zplug >/dev/null 2>&1 || return

zplug "zsh-users/zsh-autosuggestions", from:github
zplug "zsh-users/zsh-syntax-highlighting", from:github
zplug "romkatv/zsh-prompt-benchmark", from:github
zplug "romkatv/powerlevel10k", as:theme, depth:1

# If the plugins are not installed, install them
if ! zplug check; then
    zplug install
fi

# Load the plugins
zplug load
