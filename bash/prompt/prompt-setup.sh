#!/bin/bash

function has_jobs() {
    local output=$(jobs -p)
    if [ -n "$output" ]; then
        echo $(echo output | wc -l)
    else
        echo 0
    fi
}

PROMPT_COMMAND="PS1=\$(python3.4 ~/.bash/prompt/prompt.py \$? \$(has_jobs))"
