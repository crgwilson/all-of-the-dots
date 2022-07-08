if [ -f "$XDG_DATA_HOME/antigen/bin/antigen.zsh" ]; then
  source "$XDG_DATA_HOME/antigen/bin/antigen.zsh"

  antigen bundle hlissner/zsh-autopair
  antigen bundle zsh-users/zsh-completions
  antigen bundle zsh-users/zsh-history-substring-search
  antigen bundle zsh-users/zsh-autosuggestions
  antigen bundle zsh-users/zsh-syntax-highlighting

  antigen apply
fi
