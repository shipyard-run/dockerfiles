#!/bin/bash

# Check if Docker is up
echo "Waiting for Docker to start"
until docker ps; do
  echo "."
  sleep 1
done

echo "Waiting for Consul to start"
until consul members; do
  echo "."
  sleep 1
done

/usr/local/bin/nomad agent -config /etc/nomad.d
