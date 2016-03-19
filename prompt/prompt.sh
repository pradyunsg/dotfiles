# CONFIG:: Set the prompt
if [ -z "${PROMPT_CLASS}" ]; then
    PROMPT_CLASS=text
fi
if [ -z "${PROMPT_SPECIES}" ]; then
    PROMPT_SPECIES=basic
fi

if [ -z "$DO_NOT_SET_PROMPT" ]; then
    for prompt_common in ${DOTFILES_LOCATION}/prompt/prompt-old/common/*.sh; do
        echo "Sourcing $prompt_common"
        source $prompt_common
    done
    for class_common in ${DOTFILES_LOCATION}/prompt/prompt-old/${PROMPT_CLASS}/*.sh; do
        echo "Sourcing $class_common"
        source $class_common
    done

    echo "Sourcing ${DOTFILES_LOCATION}/prompt/prompt-old/${PROMPT_CLASS}-${PROMPT_SPECIES}/prompt.sh"
    source ${DOTFILES_LOCATION}/prompt/prompt-old/${PROMPT_CLASS}-${PROMPT_SPECIES}/prompt.sh

fi

if [[ ${CURRENT_SHELL} == "bash" ]]; then
    if [[ $PROMPT_COMMAND != "*;_prompt_precmd" ]]; then
        export PROMPT_COMMAND=$PROMPT_COMMAND;_prompt_precmd
    fi
elif [[ ${CURRENT_SHELL} == "zsh" ]]; then
    for s in "${precmd_functions[@]}"; do
        if [ "$s" = "_prompt_precmd" ]; then
            return
        fi
    done
    precmd_functions+=(_prompt_precmd)
fi
