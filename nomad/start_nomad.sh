#!/bin/bash

# Load the CA and add to the cache
if [[ -z "${PROXY_CA}" ]]; then
  echo "Ignore custom certificates for the proxy"
else
  echo "Adding cert ${PROXY_CA} to cache"
  echo "${PROXY_CA}" > /etc/ssl/certs/proxy.crt
  echo "${PROXY_CA}" >> /etc/ssl/certs/ca-certificates.crt
  update-ca-certificates
fi

exec /usr/bin/nomad agent -config /etc/nomad.d -log-level=DEBUG