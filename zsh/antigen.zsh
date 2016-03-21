# CONFIG:: ZSH Bundles
antigen_default_bundles=()
antigen_default_bundles+='git'
antigen_default_bundles+='pip'
antigen_default_bundles+='command-not-found'

antigen_third_party_bundles=()
antigen_third_party_bundles+='Tarrasch/zsh-autoenv'
antigen_third_party_bundles+='zsh-users/zsh-syntax-highlighting'  # Keep last

# CONFIG:: Extra ZSH configuration variables
# How often to auto-update (in days).
UPDATE_ZSH_DAYS=1
# Command auto-correction.
ENABLE_CORRECTION="true"
# display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# -----------------------------------------------------------------------------
if [ ! -d "$HOME/.antigen-repo" ]; then
    echo "Downloading antigen..."
    git clone --depth=1 https://github.com/zsh-users/antigen.git $HOME/.antigen-repo
fi

source ~/.antigen-repo/antigen.zsh

antigen use oh-my-zsh

# Default bundles
for bundle in $antigen_default_bundles; do
    antigen bundle $bundle
done

# Third party bundles
for bundle in $antigen_third_party_bundles; do
    antigen bundle $bundle
done

# CONFIG:: ZSH theme.
# echo "Loading oh-my-zsh theme... "
# antigen theme bhilburn/powerlevel9k powerlevel9k.zsh-theme

# Tell antigen that you're done.
antigen apply
