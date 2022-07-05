#####################
# Misc utils / jank #
#####################

# Nonsense

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

sweep () {
  rm -rf /tmp/go.*
  rm -rf /tmp/go-build*
  rm -rf /tmp/coc.nvim-*
  rm -rf /tmp/node-client*
  rm -rf /tmp/gradle-worker-classpath*
  rm -rf /tmp/pytest-of-$(whoami)
}
