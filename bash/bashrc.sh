# If not interactive or requested, don't bother setting things up!
if [[ -z $PS1$SETUP_ENV ]]; then
    return
fi

# Configuration
source "$HOME/.bash/config.sh"
# Aliases
source "$HOME/.bash/aliases.sh"
# Functions
source "$HOME/.bash/functions.sh"
# Prompt (Be last, might be using aliases, functions)
source "$HOME/.bash/prompt.sh"
