#################
# Networky jank #
#################

# -------
# Aliases
# -------

alias ping='/sbin/ping -c 3'

# ---------
# Functions
# ---------

los() {
  nc -u -l $1
}

subnet-scan () {
  nmap -sP $1
}
