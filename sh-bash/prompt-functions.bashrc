
# Write text in a manner that shows color
_prompt_write() {
    echo -ne "$@"
}

# Names are self-explainatory
_prompt_color_fg_start() {
    _prompt_write "\e[38;5;$1m"
}
_prompt_color_bg_start() {
    _prompt_write "\e[48;5;$1m"
}
_prompt_color_reset() {
    _prompt_write "\e[39;49m"
}
