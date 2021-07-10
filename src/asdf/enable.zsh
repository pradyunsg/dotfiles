if [[ "$OSTYPE" == darwin* ]]; then
  export ASDF_DIR=$(brew --prefix asdf)
  source $ASDF_DIR/asdf.sh
fi
