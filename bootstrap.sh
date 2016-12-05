#!/bin/sh

##
## Run this script to setup a new system.
##

SCRIPT_DIR=$( cd $(dirname $0) ; pwd )

function have_command() {
    which $1 > /dev/null
    if [ $? != "0" ]; then
        echo false
    else
        echo true
    fi
}

# If we don't have pip or python 3.4+ available
if [[ $(have_tool python3) == "false" || $(have_tool pip3) == "false" ]]; then
    echo "Please install Python 3.4+ and pip 8.2.0+ to continue."
    exit 1
fi

echo "Installing click==6.6 for manage script"
pip3 install click==6.6

python3 manage setup_new_system
python3 manage sync
