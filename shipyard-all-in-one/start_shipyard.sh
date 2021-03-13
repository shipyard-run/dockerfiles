#!/bin/bash

# Start supervisor and docker
/usr/bin/supervisord -c /etc/supervisord.conf

# Check if Docker is up
echo "Waiting for Docker to start"
until docker ps; do
  echo "."
  sleep 1
done

shipyard $@

# Ensure container does not exit
tail -f /dev/null