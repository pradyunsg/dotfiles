_pradyunsg_log "Enabling prompt..."

PROMPT_DESIGN=${PROMPT_DESIGN:=powerline}
PROMPT_THEME=${PROMPT_THEME:=pradyunsg}

SIGMA_PROMPT_LOCATION=${SIGMA_PROMPT_LOCATION:=~/code/sigma-prompts}

if [[ -f "${SIGMA_PROMPT_LOCATION}/prompt.sh" ]]; then
    source "${SIGMA_PROMPT_LOCATION}/prompt.sh"
fi
