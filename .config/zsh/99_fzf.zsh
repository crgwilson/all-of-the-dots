if [ -d "$USER_LOCAL_OPT/fzf" ]; then
  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "$USER_LOCAL_OPT/fzf/shell/completion.zsh" 2> /dev/null

  # Key bindings
  # ------------
  source "$USER_LOCAL_OPT/fzf/shell/key-bindings.zsh"
fi
