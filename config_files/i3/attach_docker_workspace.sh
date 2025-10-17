#!/bin/bash

if [ -z "$1" ]; then
  echo "MISSING: No container id was provided"
  echo ""
  echo "Usage: start_docker_workspace.sh <container_id>"
  exit 1
fi

CONTAINER_ID=$1

# Open 8 terminals
for i in {1..8}; do
#   gnome-terminal -- bash -c "docker exec -it $CONTAINER_ID /bin/bash; exec bash"
  alacritty -e bash -c "docker exec -it $CONTAINER_ID /bin/bash; exec bash" &
done

# echo "Opened 8 terminals in container $CONTAINER_ID"

sleep 2
bash ~/.config/i3/i3_grid.sh # rearrange windows in grid

# Attach to the container's primary process; exiting will end the container
docker attach "$CONTAINER_ID"


