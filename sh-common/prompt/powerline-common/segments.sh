# -----------------------------------------------------------------------------
# Segment Coloring
# -----------------------------------------------------------------------------
_prompt_segment_fg() {
    _prompt_write ${_PROMPT_SEGMENT_FG[$1]}
}
_prompt_segment_bg() {
    _prompt_write ${_PROMPT_SEGMENT_BG[$1]}
}
source ~/.sh-common/prompt/powerline-common/colors.sh

# -----------------------------------------------------------------------------
# Segment Drawing
# -----------------------------------------------------------------------------
_prompt_start_new_left_segment() {
    # $1 -> Previous Segment Name
    # $2 -> Current Segment Name
    # $3 -> Segment Text

    # Draw separator
    if [[ $1 != 'none' ]]; then
        _prompt_color_fg_start $(_prompt_segment_bg $1)
        _prompt_color_bg_start $(_prompt_segment_bg $2)
        _prompt_write "${_PROMPT_SYMBOLS[separator]}"
    fi

    _prompt_color_fg_start $(_prompt_segment_fg $2)
    _prompt_color_bg_start $(_prompt_segment_bg $2)
    _prompt_write "$3"
}

# End the prompt, by closing the open segment
_prompt_end_left_segment() {
    # $1 -> Segment to close
    if [[ $1 != 'none' ]]; then
        _prompt_color_reset
        _prompt_color_fg_start $(_prompt_segment_bg $1)
        _prompt_write ${_PROMPT_SYMBOLS[separator]}
    fi
    _prompt_color_reset
}

# =============================================================================
# Prompt Segments
# =============================================================================
# -----------------------------------------------------------------------------
# Git
# -----------------------------------------------------------------------------
_prompt_segment_git() {
    # # Verify that we have git
    # command -v git >/dev/null 2>&1 || return

    # Only add information if we are in a repository
    git rev-parse --is-inside-work-tree > /dev/null 2>&1 || return

    # HEAD related information
    git_HEAD_ref=$(git symbolic-ref HEAD 2> /dev/null)
    if [[ $git_HEAD_ref == "refs/heads/"* ]]; then
        git_head_status="$(_prompt_git_branch_upstream_info)"
    else
        git_head_status="$(_prompt_git_detached_HEAD_info)"
    fi

    # Working Directory information
    git_working_dir_status="$(_prompt_git_working_dir_info)"
    git_segment_text="$git_head_status"
    if [[ -n $git_working_dir_status ]]; then
        git_segment_text+="$git_working_dir_status"
    fi
    # Return the text for the git segments
    _prompt_write "$git_segment_text"
}

_prompt_git_working_dir_info() {
    deleted=$(git ls-files -d | wc -l)
    modified=$(git ls-files -m | wc -l)
    unmerged=$(git ls-files -u | wc -l)
    untracked=$(git ls-files -o --exclude-standard | wc -l)

    retval=
    if (( ${untracked} > 0 )); then
        _prompt_color_fg_start $(_prompt_segment_fg git_untracked_file)
        _prompt_write "${_PROMPT_SYMBOLS[git_untracked_file]}${untracked} "
    fi
    if (( ${unmerged} > 0 )); then
        _prompt_color_fg_start $(_prompt_segment_fg git_unmerged_file)
        _prompt_write "${_PROMPT_SYMBOLS[git_unmerged_file]}${unmerged} "
    fi
    if (( ${modified} > 0 )); then
        _prompt_color_fg_start $(_prompt_segment_fg git_modified_file)
        _prompt_write "${_PROMPT_SYMBOLS[git_modified_file]}${modified} "
    fi
    if (( ${deleted} > 0 )); then
        _prompt_color_fg_start $(_prompt_segment_fg git_deleted_file)
        _prompt_write "${_PROMPT_SYMBOLS[git_deleted_file]}${deleted} "
    fi
}

_prompt_git_detached_HEAD_info() {
    # Get the commit hash
    git_hash="$(git rev-parse --short=20 HEAD)"
    # Return the hash
    _prompt_color_fg_start $(_prompt_segment_fg git_hash)
    _prompt_write " ${_PROMPT_SYMBOLS[git_hash_prefix]}$git_hash "
}

_prompt_git_branch_upstream_info() {
    # Get branch name, upstream name
    git_HEAD_ref="$(git symbolic-ref HEAD)"
    git_branch_name="${git_HEAD_ref:11}"

    git_upstream_name="$(git rev-parse --abbrev-ref "@{upstream}" 2>/dev/null)"

    # Figure out divergence information.
    if [[ $? == 0 ]]; then
        temp="$(git rev-list --count --left-right "$git_upstream_name...HEAD")"
        behind=$(echo -n $temp | cut -f1)
        ahead=$(echo -n $temp | cut -f2)
    fi

    ### Return the collected information, in a properly formatted manner.
    # Branch name
    _prompt_write " "
    _prompt_color_fg_start $(_prompt_segment_fg git_branch_name_prefix)
    _prompt_write "${_PROMPT_SYMBOLS[git_branch_name_prefix]} "
    _prompt_color_fg_start $(_prompt_segment_fg git_branch_name)
    _prompt_write "$git_branch_name"
    if [[ -n $git_upstream_name ]]; then
        _prompt_write " "
        # Upstream name
        _prompt_color_fg_start $(_prompt_segment_fg git_upstream_pointer)
        _prompt_write "${_PROMPT_SYMBOLS[git_upstream_pointer]} "
        _prompt_color_fg_start $(_prompt_segment_fg git_upstream_name)
        _prompt_write "$git_upstream_name"
        # Divergence text
        git_divergence=
        if (( ahead > 0 )); then
            git_divergence+=" $(_prompt_color_fg_start $(_prompt_segment_fg git_deviation_ahead))"
            git_divergence+=" ${_PROMPT_SYMBOLS[git_deviation_ahead]}$ahead"
        fi
        if (( behind > 0 )); then
            git_divergence+=" $(_prompt_color_fg_start $(_prompt_segment_fg git_deviation_behind))"
            git_divergence+=" ${_PROMPT_SYMBOLS[git_deviation_behind]}$behind"
        fi
        _prompt_write $git_divergence
    fi
    _prompt_write " "
}

# -----------------------------------------------------------------------------
# Python Virtual Environment
# -----------------------------------------------------------------------------
_prompt_segment_virtualenv() {
    venv_name=$(basename "$VIRTUAL_ENV")
    if [[ -n $venv_name ]]; then
        _prompt_color_fg_start $(_prompt_segment_fg virtualenv_name)
        _prompt_write " $venv_name "
    fi
}
# Because it just got integrated into the prompt!!
VIRTUAL_ENV_DISABLE_PROMPT=1

# -----------------------------------------------------------------------------
# Background Jobs
# -----------------------------------------------------------------------------
_prompt_segment_background_job_count() {
    job_count=$(jobs -rp | wc -l)
    if [[ $job_count != '0' ]]; then
        _prompt_color_fg_start $(_prompt_segment_fg background_job_count)
        _prompt_write " ${_PROMPT_SYMBOLS[background_job_count]}$job_count "
    fi
}

# -----------------------------------------------------------------------------
# Working Directory
# -----------------------------------------------------------------------------
_prompt_segment_working_directory() {
    _prompt_color_fg_start $(_prompt_segment_fg working_directory)
    _prompt_write " ${PWD//${HOME}/"~"} "
}

# -----------------------------------------------------------------------------
# User Name
# -----------------------------------------------------------------------------
_prompt_segment_user_name() {
    _prompt_color_fg_start $(_prompt_segment_fg user_name)
    _prompt_write " ${USER} "
}
