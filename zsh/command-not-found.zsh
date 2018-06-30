_pradyunsg_log "Loading brew completions..."

if brew command command-not-found-init > /dev/null 2>&1; then
  eval "$(brew command-not-found-init)"
else
  # Instructions at: https://github.com/Homebrew/homebrew-command-not-found#install
  echo -e "\e[33mWARN: brew completions not installed.\e[0m"
fi
