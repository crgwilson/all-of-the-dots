export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

alias vi='nvim'
alias vim='nvim'
alias git a='git add -A'
alias git cm='git commit -am'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias mkdir='mkdir -pv'
alias now='date +"%T"'
alias ping='ping -c 3'
alias vu='vagrant up'
alias vd='vagrant destroy -f'
alias vp='vagrant provision'
alias vagrant destroy='vagrant destroy -f'
