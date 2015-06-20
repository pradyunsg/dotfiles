# Prompt configuration
source ~/.sh-common/prompt/powerline-awesome/config.sh

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

    _prompt_start_new_left_segment $2 ${SEGMENT_NAME}
    if [[ $UID == 0 || $EUID == 0 ]]; then
        _prompt_write "${_PROMPT_SYMBOLS[root_input]}"
    fi
    _prompt_color_reset

    _prompt_color_fg_start $(_prompt_segment_bg ${SEGMENT_NAME})
    # _prompt_color_bg_start $(_prompt_segment_bg ${SEGMENT_NAME})
    _prompt_write "${_PROMPT_SYMBOLS[left_separator]}"
    _prompt_color_reset
    _prompt_write " "
}

# -----------------------------------------------------------------------------
# Final entry point
# -----------------------------------------------------------------------------
function _prompt_PS1() {
    last_failed=$?

    previous_left_segment=none
    # CONFIG:: Left prompt segments
    for left_segment_name in "working_directory"
    do
        left_segment_text=$(_prompt_segment_${left_segment_name})
        if [[ -n $left_segment_text ]]; then
            _prompt_start_new_left_segment $previous_left_segment $left_segment_name
            _prompt_write $left_segment_text
            # _prompt_write " ... "
            previous_left_segment=$left_segment_name
        fi
    done
    if [[ $PROMPT_ONE_LINE != 'true' ]]; then
        _prompt_end_left_segment $previous_left_segment
        _prompt_write "\n"
        _prompt_for_input ${last_failed} none
    else
        _prompt_for_input ${last_failed} ${previous_left_segment}
    fi

    # Input on separate line
}

function _prompt_RPROMPT() {
    previous_right_segment=none
    # CONFIG:: Right prompt segments
    for right_segment_name in "background_job_count" "virtualenv" "git" "user_name"
    do
        right_segment_text=$(_prompt_segment_${right_segment_name})
        if [[ -n $right_segment_text ]]; then
            _prompt_start_new_right_segment $previous_right_segment $right_segment_name
            _prompt_write $right_segment_text
            # _prompt_write "..."
            previous_right_segment=$right_segment_name
        fi
    done
    _prompt_end_right_segment $previous_right_segment
}
function _prompt_PS2() {
    _prompt_for_input $?
}

export PS1='$(_prompt_PS1)'
export PS2='$(_prompt_PS2)'

export RPROMPT='$(_prompt_RPROMPT)'
