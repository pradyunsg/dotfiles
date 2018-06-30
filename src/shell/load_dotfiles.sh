# Loads all shell files to be sourced from the dotfiles

typeset -U config_files

# Helper functions
add_to_path() {
    if ! echo $PATH | \grep -Eq "(^|:)$1($|:)" ; then
       if [ "$2" = "prepend" ] ; then
          PATH=$1:$PATH
       else
          PATH=$PATH:$1
       fi
    fi
}
_pradyunsg_log() {
    echo -n "$(python -c "import datetime; print(datetime.datetime.now())"): "
    echo $@
}


config_files=($DOTFILES_LOCATION/**/*.zsh)

# load the "first" files
for file in ${(M)config_files:#*/*first.zsh}
do
  source $file
done

# load everything but the first and last files
for file in ${${config_files:#*/*first.zsh}:#*/last.zsh}
do
  source $file
done

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load the "last" files
for file in ${(M)config_files:#*/last.zsh}
do
  source $file
done

unset config_files
