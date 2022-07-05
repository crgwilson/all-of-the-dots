###############
# Docker jank #
###############

# -------
# Aliases
# -------
# Docker aliases

# Docker compose aliases

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
