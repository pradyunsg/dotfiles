#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively or not requested to, don't do anything
[[ "$-" != *i* ]] && return

# Call the actual bashrc
source "$HOME/.bash/bashrc"

# -- End of my stuff ----------------------------------------------------------

# added by travis gem
[ -f /home/pradyun/.travis/travis.sh ] && source /home/pradyun/.travis/travis.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
