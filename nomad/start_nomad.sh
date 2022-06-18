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

# update resolve.conf to add DNSMasq
echo "options ndots:0" > /etc/resolv.conf
echo "nameserver 127.0.0.1" >> /etc/resolv.conf

/usr/bin/nomad agent -config /etc/nomad.d -log-level=DEBUG
