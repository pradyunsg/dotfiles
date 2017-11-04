export ZPLUG_HOME=${ZPLUG_HOME:="/usr/local/opt/zplug"}
export ZPLUG_REPOS=${ZPLUG_REPOS:="$HOME/.zplug"}
source $ZPLUG_HOME/init.zsh

command -v zplug >/dev/null 2>&1 || return

zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/compleat", from:oh-my-zsh
zplug "plugins/rbenv", from:oh-my-zsh
zplug "plugins/rust", from:oh-my-zsh
zplug "plugins/heroku", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh

zplug "djui/alias-tips", from:github
zplug "supercrabtree/k", from:github
zplug "Tarrasch/zsh-autoenv", from:github
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "zsh-users/zsh-syntax-highlighting", from:github

# If the plugins are not installed, install them
if ! zplug check; then
    zplug install
fi

# Load the plugins
zplug load
