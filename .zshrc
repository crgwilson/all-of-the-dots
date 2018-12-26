##################
# oh-my-zsh jank #
##################

# Path to your oh-my-zsh installation.
plugins=(git wd)
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

#################
# Antigen Jank! #
#################

# Antigen source path
source /usr/local/share/antigen/antigen.zsh

# Number of days before auto update
export UPDATE_ZSH_DAYS=7

# Be sure to load oh-my-zsh for antigen
antigen use oh-my-zsh

# Antigen packages, my dudes
antigen bundles <<EOBUNDLES
  aws
  git
  git-flow
  github
  pip
  gem
  brew
  bundler
  osx
  tmux
  tmuxinator
  command-not-found
  dnf
  jsontools
  desync/vagrant-zsh-completion
  chrissiscool/zsh-256color
  web-search
  colored-man-pages
  hlissner/zsh-autopair
  zsh-users/zsh-autosuggestions
  zsh-users/syntax-highlighting
  zsh-users/zsh-completions
  zsh-users/zsh-history-substring-search
EOBUNDLES

# Freakin powerline is busted with iterm2 again so all the fancy characters
# in spaceship don't currently work
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_DIR_TRUNC=3
antigen apply

###########################
# Regular 'ol shell jank! #
###########################
export VAGRANT_DEFAULT_PROVIDER='virtualbox'
export EDITOR='nvim'

source ~/.zsh_profile
source $HOME/.cargo/env

