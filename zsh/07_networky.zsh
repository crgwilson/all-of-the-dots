#################
# Networky jank #
#################

# -------
# Aliases
# -------

alias ping='ping -c 3'
alias knockknock='nmap -sn'

# ---------
# Functions
# ---------

los() {
  nc -u -l $1
}

subnet-scan () {
  nmap -sP $1
}
