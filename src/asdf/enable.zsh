if [[ "$OSTYPE" == darwin* ]]; then
  if [[ -f $HOME/.asdf/asdf.sh ]]; then
    source $HOME/.asdf/asdf.sh
  fi
  export ASDF_DIR=$(brew --prefix asdf)
fi
