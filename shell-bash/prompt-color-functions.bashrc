# Color Management functions for the prompt
_prompt_write() {
    echo -ne "$@"
}

# Foreground
colorize_text() {
    # $1 -> Color, $2 -> Text
    _prompt_write "\e[38;5;$1m$2"
}

# Background
_prompt_start_new_segment() {
    # $1 -> Previous Segment Name, $2 -> Current Segment Name, $3 -> Segment Text
    # Draw separator!
    if [[ $1 != 'none' ]]; then
        _prompt_write "\e[38;5;${_PROMPT_SEGMENT_COLOR[$1]}m\e[48;5;${_PROMPT_SEGMENT_COLOR[$2]}m${_PROMPT_SYMBOLS[separator]}"
    fi
    # Reset color...
    _prompt_write "\e[38;5;${_PROMPT_TEXT_COLOR[$2]}m"
    _prompt_write "\e[48;5;${_PROMPT_SEGMENT_COLOR[$2]}m$3"
}

# End the prompt, by closing the open segment
_prompt_end_segment() {
    # $1 -> Segment to close
    if [[ $1 != 'none' ]]; then
        if [[ $1 == 'prompt' ]]; then
            if [[ $2 == 0 ]]; then
                COLOR=${_PROMPT_SEGMENT_COLOR[prompt_success]}
            else
                COLOR=${_PROMPT_SEGMENT_COLOR[prompt_failed]}
            fi
        else
            COLOR=${_PROMPT_SEGMENT_COLOR[$1]}
        fi

        _prompt_write "\e[38;5;${COLOR}m\e[49m${_PROMPT_SYMBOLS[separator]}"
    fi
    _prompt_write "\e[39;49m"
}
