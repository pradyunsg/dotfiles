
#------------------------------------------------------------------------------
# Prompt Segment Order
#------------------------------------------------------------------------------
_PROMPT_SEGMENT_ORDER=("user_name" "virtualenv" "background_job_count" "current_directory" "git")

#------------------------------------------------------------------------------
# Current Directory
#------------------------------------------------------------------------------
# Shell-Specific
_prompt_segment_current_directory() {
    colorize_text ${_PROMPT_TEXT_COLOR[current_directory]} " %~ "
}

#------------------------------------------------------------------------------
# Current User
#------------------------------------------------------------------------------
# Shell-Specific
_prompt_segment_user_name() {
    colorize_text ${_PROMPT_TEXT_COLOR[user_name]} " %n "
}
