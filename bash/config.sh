#------------------------------------------------------------------------------
# Shell Options
#        See man bash for more options...
#------------------------------------------------------------------------------

# Don't wait for job termination notification
set -o notify

# Don't use ^D to exit
set -o ignoreeof

# Use case-insensitive filename globbing
shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
# shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

# Enable recursive globbing (** is recursive)
shopt -s globstar

#------------------------------------------------------------------------------
# Completion options
#        These completion tuning parameters change the default behavior of
#        bash_completion.
#------------------------------------------------------------------------------

# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1

# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1

# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

. $HOME/.bash/completions/apt-complete.sh
eval `pip completion --bash`

#------------------------------------------------------------------------------
# History Options
#------------------------------------------------------------------------------

# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
#         The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:clear'

# Export hostory to a different file
export HISTFILE="${HOME}/.bash/history/history.txt"


#==============================================================================
# Go
#==============================================================================
GOPATH=~/Programming/Go

#==============================================================================
# Python
#==============================================================================
# virtualenvwrapper
export WORKON_HOME=$HOME/.venvwrap/venvs
export PROJECT_HOME=$HOME/.venvwrap/projects
echo -n "Sourcing virtualenvwrapper.sh..."
command -v virtualenvwrapper.sh >/dev/null 2>&1 && source virtualenvwrapper.sh
echo "Done!"
# pip
export PIP_DOWNLOAD_CACHE=$HOME/.cache/pip

#------------------------------------------------------------------------------
# Color scheme for ls
#------------------------------------------------------------------------------
DIRCOLORS_FILE=$HOME/.bash/dircolors/rainbow.dircolors
python3.4 $HOME/.bash/python/rainbow_dircolors.py > $DIRCOLORS_FILE
eval $(dircolors $DIRCOLORS_FILE)

unset DIRCOLORS_FILE

