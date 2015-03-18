# -----------------------------------------------------------------------------
# Completions
# -----------------------------------------------------------------------------
# Enable programmable completion features
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi
fi

# -----------------------------------------------------------------------------
# Shell Options
# -----------------------------------------------------------------------------
# Don't wait for job termination notification
set -o notify
# Don't use ^D to exit
set -o ignoreeof
# Use case-insensitive filename globbing
shopt -s nocaseglob
# Enable recursive globbing (** is recursive)
shopt -s globstar
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell
