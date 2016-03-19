
# =============================================================================
# CONFIG:: Define the stuff that the prompt uses to display itself.
# These values define how the prompt looks.
# =============================================================================

DEFAULT_USER=
DIRNAME_FILENAME=.dirname

declare -A _PROMPT_SYMBOLS
declare -A _PROMPT_SEGMENT_BG
declare -A _PROMPT_SEGMENT_FG

# -----------------------------------------------------------------------------
# Symbols
# -----------------------------------------------------------------------------
_PROMPT_SYMBOLS[left_separator]="⮀"
_PROMPT_SYMBOLS[right_separator]="⮂"

_PROMPT_SYMBOLS[background_job_count]="⚙"

_PROMPT_SYMBOLS[git_deviation_ahead]="↑"
_PROMPT_SYMBOLS[git_deviation_behind]="↓"

_PROMPT_SYMBOLS[git_upstream_pointer]="→"
_PROMPT_SYMBOLS[git_branch_name_prefix]="⭠"
_PROMPT_SYMBOLS[git_hash_prefix]=":"

_PROMPT_SYMBOLS[git_repo_clean]="⎘"

_PROMPT_SYMBOLS[git_staged_file]="+"
_PROMPT_SYMBOLS[git_deleted_file]="-"
_PROMPT_SYMBOLS[git_modified_file]="✎"
_PROMPT_SYMBOLS[git_unmerged_file]="×"
_PROMPT_SYMBOLS[git_untracked_file]="?"

_PROMPT_SYMBOLS[working_directory_aliased]="⟴  "
_PROMPT_SYMBOLS[working_directory_seperator]="  "

_PROMPT_SYMBOLS[root_input]=" ⚡ "
_PROMPT_SYMBOLS[input]=""

# -----------------------------------------------------------------------------
# Background
# -----------------------------------------------------------------------------
_PROMPT_SEGMENT_BG[user_name]="234"
_PROMPT_SEGMENT_BG[virtualenv]="26"
_PROMPT_SEGMENT_BG[background_job_count]="89"
_PROMPT_SEGMENT_BG[working_directory]="33"
_PROMPT_SEGMENT_BG[git]="250"

_PROMPT_SEGMENT_BG[prompt_success]="64"
_PROMPT_SEGMENT_BG[prompt_failed]="160"
_PROMPT_SEGMENT_BG[powerline_bg]="232"

# -----------------------------------------------------------------------------
# Foreground
# -----------------------------------------------------------------------------
_PROMPT_SEGMENT_FG[user_name]="208"
_PROMPT_SEGMENT_FG[virtualenv_name]="255"
_PROMPT_SEGMENT_FG[background_job_count]="255"
_PROMPT_SEGMENT_FG[working_directory]="255"
_PROMPT_SEGMENT_FG[git]="233"

# Git colors
_PROMPT_SEGMENT_FG[git_branch_name_prefix]="234"
_PROMPT_SEGMENT_FG[git_branch_name]="233"
_PROMPT_SEGMENT_FG[git_upstream_pointer]="234"
_PROMPT_SEGMENT_FG[git_upstream_name]="233"

_PROMPT_SEGMENT_FG[git_deviation_ahead]="28"
_PROMPT_SEGMENT_FG[git_deviation_behind]="88"

_PROMPT_SEGMENT_FG[git_hash]="1"

_PROMPT_SEGMENT_FG[git_repo_clean]="28"

_PROMPT_SEGMENT_FG[git_staged_file]="28"
_PROMPT_SEGMENT_FG[git_deleted_file]="124"
_PROMPT_SEGMENT_FG[git_modified_file]="65"
_PROMPT_SEGMENT_FG[git_unmerged_file]="1"
_PROMPT_SEGMENT_FG[git_untracked_file]="136"

# Prompt colors
_PROMPT_SEGMENT_FG[prompt_success]="64"
_PROMPT_SEGMENT_FG[prompt_failed]="160"

_PROMPT_SEGMENT_FG[powerline_bg]="232"
