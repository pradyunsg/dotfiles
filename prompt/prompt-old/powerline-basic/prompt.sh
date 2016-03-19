# Prompt configuration
source ${DOTFILES_LOCATION}/prompt/prompt-old/powerline-basic/config.sh

# -----------------------------------------------------------------------------
# Input "prompt" symbol
# -----------------------------------------------------------------------------
_prompt_for_input() {
    # Just show the indicator, for input.
    if [[ $1 == 0 ]]; then
        SEGMENT_NAME=prompt_success
    else
        SEGMENT_NAME=prompt_failed
    fi
    _prompt_color_fg_start $(_prompt_segment_fg ${SEGMENT_NAME})
    # _prompt_color_bg_start $(_prompt_segment_bg ${SEGMENT_NAME})
    _prompt_write "${_PROMPT_SYMBOLS[input]}"
    _prompt_color_reset
    _prompt_write " "
}

# -----------------------------------------------------------------------------
# Final entry point
# -----------------------------------------------------------------------------
function _prompt_print() {
    last_failed=$?
    # Draw left segments
    previous_segment=none
    for segment_name in "user_name" "virtualenv" "background_job_count" "working_directory" "git"
    do
        segment_text=$(_prompt_segment_${segment_name})
        if [[ -n $segment_text ]]; then
            _prompt_start_new_left_segment $previous_segment $segment_name
            _prompt_write $segment_text
            previous_segment=$segment_name
        fi
    done
    _prompt_end_left_segment $previous_segment

    # Input on separate line
    _prompt_write "\n"
    _prompt_for_input ${last_failed}
}

export PS1='$(_prompt_print)'
