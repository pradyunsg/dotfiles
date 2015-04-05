antigen_default_bundles=()
antigen_default_bundles+='git'
antigen_default_bundles+='pip'
antigen_default_bundles+='command-not-found'

antigen_third_party_bundles=()
# antigen_third_party_bundles+='nojhan/liquidprompt'

# Theme
# antigen_theme_name="agnoster"
# antigen_theme_repo="https://gist.github.com/3750104.git"

log() {
    # Clear line and return to start.
    echo -ne "\e[2K\r"
    echo -n $@
}

log "Sourcing antigen.zsh"
source ~/.zsh/antigen/antigen.zsh

log "Enabling oh-my-zsh..."
antigen use oh-my-zsh

# Default bundles
for bundle in $antigen_default_bundles; do
    log "Enabling default oh-my-zsh bundles: ${bundle}"
    antigen bundle $bundle
done

# Third party bundles
for bundle in $antigen_third_party_bundles; do
    log "Enabling third-party oh-my-zsh bundles: ${bundle}"
    antigen bundle $bundle
done

log ""

if [[ ! -z $antigen_theme_name ]]; then
    # Load the theme.
    log "Loading oh-my-zsh theme... "
    antigen theme $antigen_theme_repo $antigen_theme_name
fi

# Tell antigen that you're done.
log "Applying Changes..."
antigen apply

# Clear out!
log ""
