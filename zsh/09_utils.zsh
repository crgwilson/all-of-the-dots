##############
# Misc utils #
##############

alias get_top_open_files="lsof | awk '{print $1}' | uniq -c | sort -rn | head"
alias c='clear'
alias mkdir='mkdir -pv'
alias now='date +"%T"'

# Nonsense
alias shrug='echo "¯\_(ツ)_/¯"'
alias weather='curl wttr.in'
alias party='curl parrot.live'

# ---------
# Functions
# ---------
gpw() {
  pwgen -Bsy $1 1
}

cheat () {
  cheat_help() {
    echo "curl cht.sh! but be lazy about it..."
    echo "Along with the command 'cheat', enter the programming language you're dealing with, and you question."
    echo "Example: cheat bash 'what are computers'"
  }

  CHEAT_LANG=$1
  CHEAT_QUESTION="${@:2}"

  if [ -z "$CHEAT_LANG" ] || [ -z "$CHEAT_QUESTION" ]; then
    cheat_help
  else
    echo "curling cht.sh/$CHEAT_LANG/${CHEAT_QUESTION// /+}"
    curl cht.sh/$CHEAT_LANG/${CHEAT_QUESTION// /+}
  fi
}
