# Loads all shell files to be sourced from the dotfiles
# Largely taken from @holman's dotfiles

typeset -U config_files

config_files=($DOTFILES_LOCATION/**/*.(shrc|${CURRENT_SHELL}))

# load the path files
for file in ${(M)config_files:#*/path.(shrc|${CURRENT_SHELL})}
do
  source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.(shrc|${CURRENT_SHELL})}:#*/completion.(shrc|${CURRENT_SHELL})}
do
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.(shrc|${CURRENT_SHELL})}
do
  source $file
done

unset config_files
