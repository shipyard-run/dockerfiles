#!/bin/sh

# Load the CA and add to the cache
if [[ -z "${PROXY_CA}" ]]; then
  echo "Ignore custom certificates for the proxy"
else
  echo "Adding cert ${PROXY_CA} to cache"
  echo "${PROXY_CA}" > /usr/local/share/ca-certificates/proxy.crt
  update-ca-certificates
fi

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
