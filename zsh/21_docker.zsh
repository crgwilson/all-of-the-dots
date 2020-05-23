###############
# Docker jank #
###############

ulimit -n 4096

# -------
# Aliases
# -------
# Docker aliases
alias start-docker='open --background -a Docker'
alias stop-docker='test -z "$(docker ps -q 2>/dev/null)" && osascript -e "quit app \"Docker\""'
alias dic='docker rmi $(docker images --filter "dangling=true" -q)'
alias drd9='docker run -it --rm debian:9'
alias drd10='docker run -it --rm debian:10'
alias drc8='docker run -it --rm centos:8'

# Docker compose aliases
alias dkc='docker-compose'
alias dkcu='dkc up'
alias dkcd='dkc down'
alias dkcp='dkc ps'

# ---------
# Functions
# ---------
docker-shell() {
  container=`docker container ls | sed -n 2p | awk '{print $1}'`
  docker exec -it $container /bin/bash
}

docker-ip() {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' "$@"
}
