ANTIGEN_LOCATION="${ANTIGEN_LOCATION:=$HOME/.antigen-repo}"

if [ ! -d "${ANTIGEN_LOCATION}" ]; then
    echo "Downloading antigen..."
    git clone --depth=1 https://github.com/zsh-users/antigen.git "${ANTIGEN_LOCATION}"
fi

source ${ANTIGEN_LOCATION}/antigen.zsh

# Default bundles
antigen bundles <<EOBUNDLES
  compleat
  pip
  python
  heroku
  vagrant
  command-not-found
EOBUNDLES

# External bundles
antigen bundles <<EOBUNDLES
  djui/alias-tips
  supercrabtree/k
  Tarrasch/zsh-autoenv
  zsh-users/zsh-syntax-highlighting
  pradyunsg/rvm.plugin.zsh
EOBUNDLES
# pradyunsg/heroku.plugin.zsh
# pradyunsg/virtualenvwrapper.plugin.zsh

# Tell antigen that you're done.
antigen apply
