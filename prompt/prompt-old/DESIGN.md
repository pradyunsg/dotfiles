# Prompts
This directory contains prompts. Each prompt is defined in a separate sub-folder of this directory.

## How to define prompts
### Entry point
Each folder must contain a `prompt.sh` file which will be sourced to activate the prompt. It has to assign a value to PS1 to print the prompt.

### Variable naming
All exposed functions should be named like `_prompt_[name]`
All exposed variables should be named like `_PROMPT_[NAME]`

### Folder organization
Prompts which use the same code should move the common code into a `[prefix]-common` folder and rename themselves to `[prefix]-[name]`. This groups similar prompts by folder name and makes the similarity more visible.

### Prompt configuration
If the prompt is configurable, it should contain a `config.sh` file with sane defaults. This file should be sourced from `prompt.sh`. The configuration should be overridden in a "prompt-override.<shell>rc" in the shell-specific locations.
