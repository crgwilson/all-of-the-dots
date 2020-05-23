##########
# Python #
##########

export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# Automagically activate pyenv-virtualenvs when a .python-version file is present
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# -------
# Aliases
# -------
alias jcat='python -m json.tool'
alias grip='~/.pyenv/versions/grip/bin/grip'

# ---------
# Functions
# ---------
# Install cwd's requirements.txt into venvs used for deoplete
# NOTE: This function assumes the venvs being used for deoplete for python2 and 3
#       are named 'nvim2' and 'nvim3' respectively. This can be set in your nvim
#       config.
venv-init() {
  ~/.pyenv/versions/2.7.10/envs/nvim2/bin/pip install -r requirements.txt
  ~/.pyenv/versions/3.8.1/envs/nvim3/bin/pip install -r requirements.txt
}
