#################
# Networky jank #
#################

# -------
# Aliases
# -------


# ---------
# Functions
# ---------

los() {
  nc -u -l $1
}

subnet-scan () {
  nmap -sP $1
}
