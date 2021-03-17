#!/bin/bash

# Load the CA and add to the cache
echo "Adding cert ${PROXY_CA} to cache"
echo "${PROXY_CA}" > /usr/local/share/ca-certificates/proxy.crt
update-ca-certificates

# Start supervisor and docker
/usr/bin/supervisord -c /etc/supervisord.conf

# Check if Docker is up
echo "Waiting for Docker to start"

until docker ps > /dev/null 2>&1; do
  echo -n "."
  sleep 1
done

echo ""

shipyard $@

# Ensure container does not exit
tail -f /dev/null