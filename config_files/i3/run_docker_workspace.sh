#!/bin/bash

if [ -z "$1" ]; then
  echo "MISSING: No container name was provided"
  echo ""
  echo "Usage: start_docker_workspace.sh <container_name>"
  exit 1
fi

CONTAINER_NAME=$1

# Start the container in detached mode so we can exec into it
CONTAINER_ID=$(docker run -dit \
  --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --net=host \
  --privileged \
  $CONTAINER_NAME)

# echo "Started container $CONTAINER_ID"

# Give container a moment to start
sleep 2

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


