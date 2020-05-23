#######
# SSH #
#######

# ---------
# Functions
# ---------

# Delete Known Host (by line number)
dkh() {
  sed -i.bak -e "$1d" ~/.ssh/known_hosts
}

sox-ssh () {
  ssh -D 8080 $1
}

vnc-ssh () {
  ssh $1 -L 5901:127.0.0.1:5901
}
