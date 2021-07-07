# set PATH so it includes system wide sbin if it exists
if [ -d "/usr/local/sbin" ] ; then
    PATH="/usr/local/sbin:$PATH"
fi

# set PATH so it includes user's personal bin if it exists
if [ -d "$HOME/Developer/bin" ] ; then
    PATH="$HOME/Developer/bin:$PATH"
fi

# set PATH so it includes user's local bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
