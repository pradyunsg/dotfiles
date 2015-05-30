#!/bin/bash

DIRCOLORS_FILE=$HOME/.bash/dircolors/rainbow.dircolors
# Uncomment next line when developing scheme...
# python3.4 $HOME/.bash/dircolors/rainbow_dircolors.py > $DIRCOLORS_FILE
eval $(dircolors $DIRCOLORS_FILE)
