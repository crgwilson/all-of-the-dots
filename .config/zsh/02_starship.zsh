if [ -f "$USER_LOCAL_BIN/starship" ]; then
  eval "$($USER_LOCAL_BIN/starship init zsh)"
fi

if [ -f "/usr/bin/starship" ]; then
  eval "$(starship init zsh)"
fi
