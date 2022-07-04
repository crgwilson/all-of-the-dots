################
# Vagrant jank #
################

export VAGRANT_DEFAULT_PROVIDER='virtualbox'
# export VAGRANT_DEFAULT_PROVIDER='libvirt'

# -------
# Aliases
# -------
alias vu='vagrant up'
alias vr='vd && vu'
alias vd='vagrant destroy -f'
alias vp='vagrant provision'
alias vs='vagrant status'
alias vss='vagrant ssh'
alias vgs='vagrant global-status'
alias vagrant destroy='vagrant destroy -f'
