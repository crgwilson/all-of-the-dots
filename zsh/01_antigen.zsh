################
# Antigen Jank #
################

# Antigen source path
source /usr/local/share/antigen/antigen.zsh

# Be sure to load oh-my-zsh for antigen
antigen use oh-my-zsh

# Antigen packages, my dudes
antigen bundles <<EOBUNDLES
  ansible
  git
  git-flow
  github
  pip
  gem
  wd
  osx
  tmux
  tmuxinator
  terraform
  jsontools
  chrissicool/zsh-256color
  web-search
  colored-man-pages
  cargo
  python
  docker
  golang
  docker-compose
  zsh_reload
  hlissner/zsh-autopair
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-syntax-highlighting
EOBUNDLES

antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
antigen apply
