# If not running interactively or not requested to, don't do anything
[[ "$-" != *i* ]] && [[ -z $SETUP_SHELL ]] && return

CURRENT_SHELL=$(basename -- $0)
DOTFILES_LOCATION=$(cat ~/.dotfiles-dir)

if [[ "$CURRENT_SHELL" != *"zsh"* ]]; then
    echo "What the hell are you upto? This is not zsh."
    return;
fi

# Source a local zshrc if it exists
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"

# Load the dotfiles
source ${DOTFILES_LOCATION}/shell/load_dotfiles
