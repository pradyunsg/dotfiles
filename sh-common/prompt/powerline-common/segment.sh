# -----------------------------------------------------------------------------
# Segment Coloring
# -----------------------------------------------------------------------------
_prompt_segment_fg() {
    _prompt_write ${_PROMPT_SEGMENT_FG[$1]}
}
_prompt_segment_bg() {
    _prompt_write ${_PROMPT_SEGMENT_BG[$1]}
}

# -----------------------------------------------------------------------------
# Segment Drawing
# -----------------------------------------------------------------------------
_prompt_start_new_left_segment() {
    # $1 -> Previous Segment Name
    # $2 -> Next Segment Name

    # Draw separator
    if [[ $1 != 'none' ]]; then
        _prompt_color_fg_start $(_prompt_segment_bg $1)
        _prompt_color_bg_start $(_prompt_segment_bg $2)
        _prompt_write "${_PROMPT_SYMBOLS[left_separator]}"
    fi

    _prompt_color_fg_start $(_prompt_segment_fg $2)
    _prompt_color_bg_start $(_prompt_segment_bg $2)
}

_prompt_end_left_segment() {
    # $1 -> Segment to close
    if [[ $1 != 'none' ]]; then
        _prompt_color_reset
        _prompt_color_fg_start $(_prompt_segment_bg $1)
        _prompt_write ${_PROMPT_SYMBOLS[left_separator]}
    fi
    _prompt_color_reset
}

_prompt_start_new_right_segment() {
    # $1 -> Previous Segment Name
    # $2 -> Next Segment Name

    # Draw separator
    _prompt_color_fg_start $(_prompt_segment_bg $2)
    if [[ $1 != 'none' ]]; then
        _prompt_color_bg_start $(_prompt_segment_bg $1)
    fi
    _prompt_write "${_PROMPT_SYMBOLS[right_separator]}"

    _prompt_color_fg_start $(_prompt_segment_fg $2)
    _prompt_color_bg_start $(_prompt_segment_bg $2)
}

_prompt_end_right_segment() {
    _prompt_color_reset
}
