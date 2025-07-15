#!/bin/bash

# Script to monitor and restart stopped Docker containers

echo "Checking for stopped containers..."

stopped_containers=$(docker ps -a --filter "status=exited" --format "{{.ID}} {{.Names}}")

if [ -z "$stopped_containers" ]; then
  echo "No stopped containers found."
else
  echo "Found stopped containers:"
  echo "$stopped_containers"
  
  while read -r container_id container_name; do
    echo "Restarting container: $container_name ($container_id)"
    docker start "$container_id"
  done <<< "$stopped_containers"
fi

echo "Monitor script finished."
