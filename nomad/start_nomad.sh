#!/bin/sh

# Load the CA and add to the cache
if [[ -z "${PROXY_CA}" ]]; then
  echo "Ignore custom certificates for the proxy"
else
  echo "Adding cert ${PROXY_CA} to cache"
  echo "${PROXY_CA}" > /usr/local/share/ca-certificates/proxy.crt
  update-ca-certificates
fi

/usr/bin/nomad agent -config /etc/nomad.d -log-level=DEBUG