if [ ! -d "$HOME/.antigen-repo" ]; then
    echo "Downloading antigen..."
    git clone --depth=1 https://github.com/zsh-users/antigen.git $HOME/.antigen-repo
fi

source ~/.antigen-repo/antigen.zsh

# Default bundles
antigen bundles <<EOBUNDLES
  git
  pip
  command-not-found
EOBUNDLES

# External bundles
antigen bundles <<EOBUNDLES
  Tarrasch/zsh-autoenv
  zsh-users/zsh-syntax-highlighting
EOBUNDLES

# Tell antigen that you're done.
antigen apply
