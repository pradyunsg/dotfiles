# If not running interactively or not requested to, don't do anything
[[ "$-" != *i* ]] && [[ -z $SETUP_SHELL ]] && return

CURRENT_SHELL=$(basename -- $0)
if [[ "$CURRENT_SHELL" != *"zsh"* ]]; then
    echo "What the hell are you upto? This is not zsh."
    return;
fi

# Source a local zshrc if it exists
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"

# initialize autocomplete here, otherwise functions won't be loaded
autoload -Uz compinit

# Speed up startup by only checking once a day, if the cached .zcompdump
# file should be regenerated
for dump in ~/.zcompdump(N.mh+24); do
  compinit -u
done
compinit -uC

# Run all the files in ~/.zsh
for file in ~/.zsh/*.zsh; do
  echo $file
  source $file
done
