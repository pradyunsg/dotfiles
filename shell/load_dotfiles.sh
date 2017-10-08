# Loads all shell files to be sourced from the dotfiles

typeset -U config_files

# Helper function
add_to_path() {
    if ! echo $PATH | /bin/grep -Eq "(^|:)$1($|:)" ; then
       if [ "$2" = "prepend" ] ; then
          PATH=$1:$PATH
       else
          PATH=$PATH:$1
       fi
    fi
}


config_files=($DOTFILES_LOCATION/**/*.(shrc|${CURRENT_SHELL}))

# load the config files
for file in ${(M)config_files:#*/*config.(shrc|${CURRENT_SHELL})}
do
  source $file
done

# load everything but the config and completion files
for file in ${${config_files:#*/*config.(shrc|${CURRENT_SHELL})}:#*/completion.(shrc|${CURRENT_SHELL})}
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
