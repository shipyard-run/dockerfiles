#!/bin/sh
set -o errexit
set -o nounset
set -o pipefail

if [ -f /sys/fs/cgroup/cgroup.controllers ]; then
	# move the processes from the root group to the /init group,
  # otherwise writing subtree_control fails with EBUSY.
  mkdir -p /sys/fs/cgroup/init
  busybox xargs -rn1 < /sys/fs/cgroup/cgroup.procs > /sys/fs/cgroup/init/cgroup.procs || :
  # enable controllers
  sed -e 's/ / +/g' -e 's/^/+/' <"/sys/fs/cgroup/cgroup.controllers" >"/sys/fs/cgroup/cgroup.subtree_control"
fi

# Load the CA and add to the cache
if [[ -z "${PROXY_CA}" ]]; then
  echo "Ignore custom certificates for the proxy"
else
  echo "Adding cert ${PROXY_CA} to cache"
  echo "${PROXY_CA}" > /etc/ssl/certs/proxy.crt
  echo "${PROXY_CA}" >> /etc/ssl/certs/ca-certificates.crt
fi

mount --make-rshared /

/bin/k3s $@
