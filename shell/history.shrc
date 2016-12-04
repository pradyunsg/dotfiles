## History Options

# Append rather than overwrite the history on disk
# shopt -s histappend

# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups:erasedups

# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
#         The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:clear'

# Export hostory to a different file
export HISTFILE="${HOME}/.history/${CURRENT_SHELL}.history.txt"
