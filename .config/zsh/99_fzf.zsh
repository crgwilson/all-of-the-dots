if [ -d "$XDG_DATA_HOME/fzf" ]; then
  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "$XDG_DATA_HOME/fzf/shell/completion.zsh" 2> /dev/null

  # Key bindings
  # ------------
  source "$XDG_DATA_HOME/fzf/shell/key-bindings.zsh"
fi
