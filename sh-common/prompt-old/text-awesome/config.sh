
# Defines the stuff that the prompt uses to display itself. These values define
# how the prompt looks.

# -----------------------------------------------------------------------------

declare -A _PROMPT_SYMBOLS
_PROMPT_SYMBOLS[separator]="⮀"

_PROMPT_SYMBOLS[background_job_count]="⚙"

_PROMPT_SYMBOLS[git_deviation_ahead]="↑"
_PROMPT_SYMBOLS[git_deviation_behind]="↓"

_PROMPT_SYMBOLS[git_upstream_pointer]="→"
_PROMPT_SYMBOLS[git_branch_name_prefix]="⭠"
_PROMPT_SYMBOLS[git_hash_prefix]=":"

_PROMPT_SYMBOLS[git_deleted_file]="-"
_PROMPT_SYMBOLS[git_modified_file]="✎"
_PROMPT_SYMBOLS[git_unmerged_file]="×"
_PROMPT_SYMBOLS[git_untracked_file]="?"

_PROMPT_SYMBOLS[input]="❯"

# -----------------------------------------------------------------------------

declare -A _PROMPT_SEGMENT_BG
_PROMPT_SEGMENT_BG[user_name]="0"
_PROMPT_SEGMENT_BG[virtualenv]="0"
_PROMPT_SEGMENT_BG[background_job_count]="0"
_PROMPT_SEGMENT_BG[working_directory]="0"
_PROMPT_SEGMENT_BG[git]="0"

_PROMPT_SEGMENT_BG[prompt_success]="0"
_PROMPT_SEGMENT_BG[prompt_failed]="0"
_PROMPT_SEGMENT_BG[powerline_bg]="0"

# -----------------------------------------------------------------------------

declare -A _PROMPT_SEGMENT_FG
_PROMPT_SEGMENT_FG[user_name]="208"
_PROMPT_SEGMENT_FG[virtualenv_name]="255"
_PROMPT_SEGMENT_FG[background_job_count]="255"
_PROMPT_SEGMENT_FG[working_directory]="255"
_PROMPT_SEGMENT_FG[git]="241"

# Git colors
_PROMPT_SEGMENT_FG[git_branch_name_prefix]="244"
_PROMPT_SEGMENT_FG[git_branch_name]="241"
_PROMPT_SEGMENT_FG[git_upstream_pointer]="244"
_PROMPT_SEGMENT_FG[git_upstream_name]="241"

_PROMPT_SEGMENT_FG[git_deviation_ahead]="28"
_PROMPT_SEGMENT_FG[git_deviation_behind]="88"

_PROMPT_SEGMENT_FG[git_hash]="1"

_PROMPT_SEGMENT_FG[git_deleted_file]="124"
_PROMPT_SEGMENT_FG[git_modified_file]="65"
_PROMPT_SEGMENT_FG[git_unmerged_file]="1"
_PROMPT_SEGMENT_FG[git_untracked_file]="136"

# Prompt colors
_PROMPT_SEGMENT_FG[prompt_success]="64"
_PROMPT_SEGMENT_FG[prompt_failed]="160"

_PROMPT_SEGMENT_FG[powerline_bg]="232"
