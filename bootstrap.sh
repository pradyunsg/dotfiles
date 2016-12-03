#!/bin/sh

##
## Run this script to setup a new system.
##

SCRIPT_DIR=$( cd $(dirname $0) ; pwd )

# Check if Python/Pip 3 is installed. . If that fails, abort.
which pip3 > /dev/null

# If not installed, then install it, via apt
if [ $? != "0" ]; then
    sudo apt-get update
    echo "Installing Python 3 and pip."
    sudo apt-get install --yes python3 python3-pip
    if [ $? != "0" ]; then
        echo "Could not install Python 3. Please install Python 3 (with pip) and re-run."
        exit 1
    fi
fi

echo "Installing click for the user..."
pip3 install --user click==6.2.0

python3 manage setup_new_system
